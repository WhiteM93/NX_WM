<#
  install.ps1 - установка UDE "Probe wall check" (probe_wall_check) для NX2506
  и тестового поста 1.ai_3ax_probe (Fanuc 0i-MF Plus + щуп Hexagon).

  Запуск: через install.bat (сам запросит права администратора).
    install.bat                 - установка
    install.bat -DryRun         - только показать, что будет сделано (ничего не меняет)
    install.bat -Uninstall      - откат из последнего бэкапа
    install.bat -Uninstall -BackupDir E:\NX_Tools\Backup\2026-10-31_1730
  Доп. параметры: -NxDir <папка NX2506>  -UdeDir <папка для cdl/tcl>
                  -BackupRoot <папка бэкапов>  -Yes (без вопросов)
#>
[CmdletBinding()]
param(
    [switch]$Uninstall,
    [Alias('WhatIf')][switch]$DryRun,
    [string]$NxDir,
    [string]$UdeDir,
    [string]$BackupRoot,
    [string]$BackupDir,
    [switch]$Yes
)

$ErrorActionPreference = 'Stop'
try { [Console]::OutputEncoding = [Text.Encoding]::UTF8; $OutputEncoding = [Text.Encoding]::UTF8 } catch {}

$Here        = Split-Path -Parent $MyInvocation.MyCommand.Path
$Files       = Join-Path $Here 'files'
$Lat         = [Text.Encoding]::GetEncoding(28591)   # байт-в-байт, кодировка файлов не меняется
$Token       = 'E:/NX_Tools/ai_3ax_probe_test'       # путь, зашитый в файлы пакета
$PostFolder  = '1.ai_3ax_probe'
$PostLine    = '1.ai_3ax_probe,${UGII_CAM_POST_DIR}1.ai_3ax_probe\ai_3ax_probe.tcl,${UGII_CAM_POST_DIR}1.ai_3ax_probe\ai_3ax_probe.def'
$StockUde    = 'USER_DEFINED_EVENTS,${UGII_CAM_USER_DEF_EVENT_DIR}ude.cdl,${UGII_CAM_USER_DEF_EVENT_DIR}ude.tcl'
$BaseTclHash = (Get-Content (Join-Path $Files 'base_ai_3ax_tcl.sha256') -TotalCount 1).Trim().ToUpper()
$UdeFiles    = 'ude_plus_probe.cdl','probe_wall_check.cdl','probe_wall_check.tcl','probe_set.cdl','probe_set.tcl'
$PostFiles   = 'ai_3ax_probe.tcl','ai_3ax_probe.def','ai_3ax_probe.pui','probe_wall_check.cdl','probe_wall_check.tcl','probe_set.cdl','probe_set.tcl'
$Stamp       = Get-Date -Format 'yyyy-MM-dd_HHmm'

function Test-OneDrive([string]$p) {
    if (-not $p) { return $false }
    if ($p -match '(?i)onedrive') { return $true }
    foreach ($v in $env:OneDrive, $env:OneDriveCommercial, $env:OneDriveConsumer) {
        if ($v -and $p.StartsWith($v, [StringComparison]::OrdinalIgnoreCase)) { return $true }
    }
    return $false
}

# ---------- лог ----------
$LogDir = $Here
if (Test-OneDrive $LogDir) { $LogDir = $(if (Test-Path 'E:\') { 'E:\NX_Tools\Backup' } else { $env:TEMP }) }
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Force $LogDir | Out-Null }
$LogFile = Join-Path $LogDir 'install_log.txt'

function Log([string]$m, [string]$lvl = 'INFO') {
    $c = @{ INFO = 'Gray'; OK = 'Green'; WARN = 'Yellow'; ERR = 'Red'; PLAN = 'Cyan' }[$lvl]
    Write-Host $m -ForegroundColor $c
    Add-Content -Path $LogFile -Value ("{0} [{1}] {2}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $lvl, $m) -Encoding UTF8
}
function Fail([string]$m) { Log $m 'ERR'; throw "STOP: $m" }
function Ask([string]$q) {
    if ($Yes) { Log "$q -> да (-Yes)"; return $true }
    $a = Read-Host "$q [д/н]"
    return ($a -match '^(д|да|y|yes)$')
}
function Read-Bytes([string]$f) { $Lat.GetString([IO.File]::ReadAllBytes($f)) }
function Write-Bytes([string]$f, [string]$t) {
    # файлы NX бывают с атрибутом "Только чтение": снимаем на время записи и возвращаем
    $ro = $false
    if (Test-Path -LiteralPath $f) {
        $fi = Get-Item -LiteralPath $f -Force
        if ($fi.Attributes -band [IO.FileAttributes]::ReadOnly) { $ro = $true; $fi.Attributes = $fi.Attributes -band (-bnot [IO.FileAttributes]::ReadOnly) }
    }
    try { [IO.File]::WriteAllBytes($f, $Lat.GetBytes($t)) }
    finally { if ($ro) { $fi.Refresh(); $fi.Attributes = $fi.Attributes -bor [IO.FileAttributes]::ReadOnly } }
}
function Get-NL([string]$t) { if ($t.Contains("`r`n")) { "`r`n" } else { "`n" } }
function Hash([string]$f) { (Get-FileHash -LiteralPath $f -Algorithm SHA256).Hash }

function Test-NxDir([string]$d) {
    $d -and (Test-Path (Join-Path $d 'MACH\resource\configuration\cam_general.dat')) -and
            (Test-Path (Join-Path $d 'MACH\resource\postprocessor\template_post.dat'))
}
function Find-Nx {
    $c = @()
    if ($NxDir) { $c += $NxDir }
    $c += $env:UGII_BASE_DIR
    $c += [Environment]::GetEnvironmentVariable('UGII_BASE_DIR', 'Machine')
    foreach ($k in 'HKLM:\SOFTWARE\Siemens\NX 2506', 'HKLM:\SOFTWARE\WOW6432Node\Siemens\NX 2506') {
        try { $p = Get-ItemProperty $k; $c += $p.UGII_BASE_DIR; $c += $p.INSTALLDIR } catch {}
    }
    $c += 'C:\Program Files\Siemens\NX2506', 'D:\Program Files\Siemens\NX2506'
    foreach ($d in $c) { if ($d) { $d = $d.TrimEnd('\'); if (Test-NxDir $d) { return $d } } }
    Log 'NX2506 не найден автоматически.' 'WARN'
    while ($true) {
        $d = Read-Host 'Введите путь к папке NX2506 (например C:\Program Files\Siemens\NX2506) или пусто для отмены'
        if (-not $d) { Fail 'Отменено: NX2506 не найден.' }
        $d = $d.Trim('"').TrimEnd('\')
        if (Test-NxDir $d) { return $d }
        Log "В '$d' нет MACH\resource\configuration\cam_general.dat / postprocessor\template_post.dat" 'WARN'
    }
}
function Wait-NxClosed {
    while ($true) {
        $p = Get-Process -Name 'ugraf' -ErrorAction SilentlyContinue
        if (-not $p) { Log 'NX (ugraf.exe) не запущен.' 'OK'; return }
        Log "NX запущен (ugraf.exe, PID $(($p | ForEach-Object Id) -join ', ')). Закройте NX." 'WARN'
        if ($DryRun) { Log 'DryRun: продолжаю только показ плана.' 'WARN'; return }
        $a = Read-Host 'П - повторить проверку, О - отмена'
        if ($a -notmatch '^(п|p|r)') { Fail 'Отменено пользователем: NX запущен.' }
    }
}
function Test-Writable([string]$f) {
    try {
        $fi = Get-Item -LiteralPath $f -Force
        if ($fi.Attributes -band [IO.FileAttributes]::ReadOnly) {
            # только чтение: проверяем право менять атрибуты (его хватит, чтобы снять ReadOnly)
            $s = New-Object IO.FileStream($f, [IO.FileMode]::Open, [Security.AccessControl.FileSystemRights]::WriteAttributes, [IO.FileShare]::ReadWrite, 4096, [IO.FileOptions]::None)
        } else { $s = [IO.File]::Open($f, 'Open', 'ReadWrite', 'ReadWrite') }
        $s.Close(); return $true
    } catch { return $false }
}
function Get-BackupRoot {
    if ($BackupRoot) { $r = $BackupRoot }
    elseif (Test-Path 'E:\') { $r = 'E:\NX_Tools\Backup' }
    else { $r = Join-Path $Here 'Backup' }
    while (Test-OneDrive $r) {
        Log "Папка бэкапа '$r' в OneDrive - запрещено." 'WARN'
        $r = (Read-Host 'Укажите папку для бэкапов (не OneDrive), пусто - отмена').Trim('"')
        if (-not $r) { Fail 'Отменено: нет папки для бэкапа.' }
    }
    return $r.TrimEnd('\')
}
function Get-UdeDir {
    $d = $UdeDir
    if (-not $d) { if (Test-Path 'E:\') { $d = 'E:\NX_Tools\ai_3ax_probe_test' } }
    while ($true) {
        if (-not $d) {
            $d = (Read-Host 'Диска E: нет. Укажите папку для файлов UDE (латиница, без пробелов, не OneDrive), пусто - отмена').Trim('"')
            if (-not $d) { Fail 'Отменено: не указана папка UDE.' }
        }
        $d = $d.TrimEnd('\')
        $bad = $null
        if (Test-OneDrive $d) { $bad = 'папка в OneDrive' }
        elseif ($d -match '\s') { $bad = 'в пути есть пробелы (INCLUDE в CDL их не допускает)' }
        elseif ($d -match '[^\x21-\x7E]') { $bad = 'в пути есть не-латинские символы' }
        elseif ($d -notmatch '^[A-Za-z]:\\') { $bad = 'нужен полный путь вида X:\папка' }
        if (-not $bad) { return $d }
        Log "Папка '$d' не подходит: $bad." 'WARN'; $d = $null
    }
}
function Test-SameAsPackage([string]$src, [string]$dst, [string]$udeFwd) {
    if (-not (Test-Path -LiteralPath $dst)) { return $false }
    $t = Read-Bytes $src; if ($udeFwd -ne $Token) { $t = $t.Replace($Token, $udeFwd) }
    $sha = [Security.Cryptography.SHA256]::Create()
    $h1 = [BitConverter]::ToString($sha.ComputeHash($Lat.GetBytes($t)))
    return ($h1 -eq [BitConverter]::ToString($sha.ComputeHash([IO.File]::ReadAllBytes($dst))))
}
function Copy-WithToken([string]$src, [string]$dst, [string]$udeFwd) {
    $t = Read-Bytes $src
    if ($udeFwd -ne $Token) { $t = $t.Replace($Token, $udeFwd) }
    Write-Bytes $dst $t
}

# ======================================================================
Log '=================================================================='
Log ("probe_wall_check installer: режим {0}{1}" -f $(if ($Uninstall) { 'ОТКАТ' } else { 'УСТАНОВКА' }), $(if ($DryRun) { ' (DryRun - без изменений)' } else { '' }))
Log "Лог: $LogFile"

$Nx       = Find-Nx
$Res      = Join-Path $Nx 'MACH\resource'
$CamGen   = Join-Path $Res 'configuration\cam_general.dat'
$TplPost  = Join-Path $Res 'postprocessor\template_post.dat'
$PostDst  = Join-Path $Res "postprocessor\$PostFolder"
Log "NX2506: $Nx" 'OK'
Wait-NxClosed

$isAdmin = (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
$canWrite = (Test-Writable $CamGen) -and (Test-Writable $TplPost)
if (-not $canWrite) {
    if ($DryRun) { Log 'Нет прав на запись в cam_general.dat/template_post.dat - для установки запускайте install.bat (запросит права администратора).' 'WARN' }
    else { Fail 'Нет прав на запись в файлы NX. Запустите install.bat (он запросит права администратора).' }
} else { Log "Права на запись в файлы NX есть (администратор: $isAdmin)." 'OK' }

$Root = Get-BackupRoot

# ======================================================================
if ($Uninstall) {
    if ($BackupDir) { $B = $BackupDir.TrimEnd('\') }
    else {
        $cand = @()
        foreach ($r in @($Root, (Join-Path $Here 'Backup')) | Select-Object -Unique) {
            if (Test-Path $r) {
                $cand += Get-ChildItem $r -Directory | Where-Object {
                    (Test-Path (Join-Path $_.FullName 'cam_general.dat')) -and (Test-Path (Join-Path $_.FullName 'template_post.dat')) -and
                    ($_.Name -notmatch 'before_uninstall') -and
                    -not ((Read-Bytes (Join-Path $_.FullName 'cam_general.dat')) -match 'ude_plus_probe\.cdl') }
            }
        }
        if (-not $cand) { Fail "Бэкапы с исходным (до установки) cam_general.dat не найдены в $Root. Укажите -BackupDir." }
        $B = ($cand | Sort-Object LastWriteTime -Descending | Select-Object -First 1).FullName
        Log ("Найдено бэкапов: {0}. Последний: {1}" -f $cand.Count, $B)
    }
    foreach ($n in 'cam_general.dat', 'template_post.dat') { if (-not (Test-Path (Join-Path $B $n))) { Fail "В бэкапе $B нет $n" } }
    $info = Join-Path $B 'backup_info.txt'
    if (Test-Path $info) {
        $nxLine = Select-String -Path $info -Pattern '^NX=' | Select-Object -First 1
        if ($nxLine -and ($nxLine.Line.Substring(3) -ne $Nx)) { Log "Бэкап сделан для другой папки NX: $($nxLine.Line.Substring(3))" 'WARN'; if (-not (Ask 'Всё равно восстановить?')) { Fail 'Отменено.' } }
    }
    Log "ПЛАН ОТКАТА:" 'PLAN'
    Log "  восстановить $CamGen  <- $B\cam_general.dat" 'PLAN'
    Log "  восстановить $TplPost <- $B\template_post.dat (и убрать строку 1.ai_3ax_probe, если осталась)" 'PLAN'
    if (Test-Path (Join-Path $B "${PostFolder}_prev")) { Log "  вернуть прежнюю папку $PostDst из бэкапа" 'PLAN' }
    else { Log "  удалить папку $PostDst" 'PLAN' }
    Log "  (файлы UDE в папке UDE не удаляются - они ни на что не влияют)" 'PLAN'
    if ($DryRun) { Log 'DryRun: изменений не сделано.' 'OK'; return }
    if (-not (Ask 'Выполнить откат?')) { Fail 'Отменено пользователем.' }

    $S = Join-Path $Root "${Stamp}_before_uninstall"; New-Item -ItemType Directory -Force $S | Out-Null
    Copy-Item $CamGen $S; Copy-Item $TplPost $S
    Log "Текущие файлы сохранены в $S" 'OK'

    Copy-Item (Join-Path $B 'cam_general.dat') $CamGen -Force
    Copy-Item (Join-Path $B 'template_post.dat') $TplPost -Force
    $t = Read-Bytes $TplPost; $nl = Get-NL $t
    if ($t.Contains($PostLine)) {
        $t = $t.Replace($PostLine + $nl, '').Replace($PostLine, ''); Write-Bytes $TplPost $t
        Log 'Строка 1.ai_3ax_probe удалена из template_post.dat' 'OK'
    }
    if ((Read-Bytes $CamGen) -match 'ude_plus_probe\.cdl') { Log 'ВНИМАНИЕ: cam_general.dat всё ещё ссылается на ude_plus_probe.cdl (бэкап был сделан уже после установки?).' 'WARN' }
    if (Test-Path $PostDst) { Remove-Item -LiteralPath $PostDst -Recurse -Force; Log "Удалена папка $PostDst" 'OK' }
    $prev = Join-Path $B "${PostFolder}_prev"
    if (Test-Path $prev) { Copy-Item $prev $PostDst -Recurse; Log "Восстановлена прежняя папка $PostDst" 'OK' }
    Log 'ОТКАТ ЗАВЕРШЁН. Запустите NX и проверьте.' 'OK'
    return
}

# ======================================================================
# УСТАНОВКА
$Ude    = Get-UdeDir
$UdeFwd = $Ude.Replace('\', '/')
$NewUde = "USER_DEFINED_EVENTS,$Ude\ude_plus_probe.cdl,`${UGII_CAM_USER_DEF_EVENT_DIR}ude.tcl"
$B      = Join-Path $Root $Stamp
if (Test-Path $B) { $B = "$B" + (Get-Date -Format '_ss') }
Log "Папка UDE:    $Ude"
Log "Папка бэкапа: $B"

foreach ($n in $UdeFiles) { if (-not (Test-Path (Join-Path $Files "ude\$n"))) { Fail "В пакете нет files\ude\$n" } }
foreach ($n in $PostFiles) { if (-not (Test-Path (Join-Path $Files "post\$n"))) { Fail "В пакете нет files\post\$n" } }

# проверка исходного поста 1.ai_3ax
$baseTcl = Join-Path $Res 'postprocessor\1.ai_3ax\ai_3ax.tcl'
if (-not (Test-Path $baseTcl)) {
    Log 'На этом ПК нет поста 1.ai_3ax\ai_3ax.tcl. Пакетный пост ai_3ax_probe собран из 1.ai_3ax с ПК Макса и может не подходить к вашему станку.' 'WARN'
    if (-not $DryRun -and -not (Ask 'Продолжить установку?')) { Fail 'Отменено пользователем.' }
} elseif ((Hash $baseTcl) -ne $BaseTclHash) {
    Log 'ВНИМАНИЕ: 1.ai_3ax\ai_3ax.tcl на этом ПК ОТЛИЧАЕТСЯ от того, из которого собран пакет (другая версия поста).' 'WARN'
    Log '  Пост ai_3ax_probe будет установлен в версии с ПК Макса - проверьте вывод перед работой.' 'WARN'
    if (-not $DryRun -and -not (Ask 'Продолжить установку?')) { Fail 'Отменено пользователем.' }
} else { Log '1.ai_3ax\ai_3ax.tcl совпадает с исходным постом пакета.' 'OK' }

# анализ cam_general.dat
$cg = Read-Bytes $CamGen; $cgNL = Get-NL $cg
$cgLines = $cg -split [regex]::Escape($cgNL)
$idx = -1; for ($i = 0; $i -lt $cgLines.Count; $i++) { if ($cgLines[$i] -match '^USER_DEFINED_EVENTS,') { $idx = $i; break } }
if ($idx -lt 0) { Fail "В $CamGen нет строки USER_DEFINED_EVENTS" }
$cgOld = $cgLines[$idx]
$cgNeed = $true
if ($cgOld -match 'ude_plus_probe\.cdl') { $cgNeed = $false; Log "cam_general.dat уже указывает на ude_plus_probe.cdl (строка $($idx+1)) - не меняю." 'OK' }
elseif ($cgOld -ne $StockUde) {
    Log "Строка $($idx+1) cam_general.dat не стандартная: $cgOld" 'WARN'
    Log '  ude_plus_probe.cdl подключает только стандартный ude.cdl - ваш вариант будет заменён (в бэкапе сохранится).' 'WARN'
    if (-not $DryRun -and -not (Ask 'Заменить эту строку?')) { Fail 'Отменено пользователем.' }
}
# анализ template_post.dat
$tp = Read-Bytes $TplPost; $tpNL = Get-NL $tp
$tpNeed = -not ($tp -split [regex]::Escape($tpNL) | Where-Object { $_ -match '^1\.ai_3ax_probe,' })
if (-not $tpNeed) { Log 'template_post.dat уже содержит строку 1.ai_3ax_probe - не меняю.' 'OK' }

$udeSame  = -not ($UdeFiles  | Where-Object { -not (Test-SameAsPackage (Join-Path $Files "ude\$_")  (Join-Path $Ude $_) $UdeFwd) })
$postSame = -not ($PostFiles | Where-Object { -not (Test-SameAsPackage (Join-Path $Files "post\$_") (Join-Path $PostDst $_) $UdeFwd) })
if (-not $cgNeed -and -not $tpNeed -and $udeSame -and $postSame) {
    Log 'Всё уже установлено и совпадает с пакетом - изменений не требуется.' 'OK'
    return
}
Log 'ПЛАН УСТАНОВКИ:' 'PLAN'
Log "  1) бэкап cam_general.dat, template_post.dat -> $B" 'PLAN'
Log "  2) файлы UDE ($($UdeFiles -join ', ')) -> $Ude" 'PLAN'
Log "  3) пост ($($PostFiles -join ', ')) -> $PostDst$(if (Test-Path $PostDst) { ' (папка есть - старая уйдёт в бэкап)' })" 'PLAN'
if ($cgNeed) { Log "  4) cam_general.dat строка $($idx+1):" 'PLAN'; Log "       было: $cgOld" 'PLAN'; Log "      стало: $NewUde" 'PLAN' }
if ($tpNeed) { Log "  5) template_post.dat: добавить строку $PostLine" 'PLAN' }
if ($UdeFwd -ne $Token) { Log "  пути в cdl/def/tcl: $Token -> $UdeFwd" 'PLAN' }
if ($DryRun) { Log 'DryRun: изменений не сделано.' 'OK'; return }
if (-not (Ask 'Выполнить установку?')) { Fail 'Отменено пользователем.' }

# 1) бэкап
New-Item -ItemType Directory -Force $B | Out-Null
Copy-Item $CamGen $B; Copy-Item $TplPost $B
foreach ($p in @(@($CamGen, "$B\cam_general.dat"), @($TplPost, "$B\template_post.dat"))) {
    if ((Hash $p[0]) -ne (Hash $p[1])) { Fail "Бэкап $($p[1]) не совпадает с оригиналом" }
}
if (Test-Path $PostDst) { Copy-Item $PostDst (Join-Path $B "${PostFolder}_prev") -Recurse }
@("NX=$Nx", "UDE=$Ude", "DATE=$(Get-Date -Format s)", "USER=$env:USERNAME", "PC=$env:COMPUTERNAME",
  "CAM_GENERAL_LINE_OLD=$cgOld", "POST_FOLDER_EXISTED=$(Test-Path $PostDst)") | Set-Content (Join-Path $B 'backup_info.txt') -Encoding UTF8
Log "Бэкап готов и проверен: $B" 'OK'

# 2) UDE
if (-not (Test-Path $Ude)) { New-Item -ItemType Directory -Force $Ude | Out-Null }
foreach ($n in $UdeFiles) {
    $d = Join-Path $Ude $n
    if (Test-Path $d) { New-Item -ItemType Directory -Force "$B\ude_prev" | Out-Null; Copy-Item $d "$B\ude_prev\" }
    Copy-WithToken (Join-Path $Files "ude\$n") $d $UdeFwd
}
Log "Файлы UDE скопированы в $Ude" 'OK'

# 3) пост
if (Test-Path $PostDst) { Remove-Item -LiteralPath $PostDst -Recurse -Force }
New-Item -ItemType Directory -Force $PostDst | Out-Null
foreach ($n in $PostFiles) { Copy-WithToken (Join-Path $Files "post\$n") (Join-Path $PostDst $n) $UdeFwd }
Log "Пост скопирован в $PostDst" 'OK'

# 4) cam_general.dat
if ($cgNeed) {
    $cgLines[$idx] = $NewUde
    Write-Bytes $CamGen ($cgLines -join $cgNL)
    Log "cam_general.dat: строка $($idx+1) заменена." 'OK'
}
# 5) template_post.dat
if ($tpNeed) {
    $lines = [Collections.Generic.List[string]]($tp -split [regex]::Escape($tpNL))
    $pos = -1; for ($i = 0; $i -lt $lines.Count; $i++) { if ($lines[$i] -match '^1\.ai_3ax,') { $pos = $i + 1; break } }
    if ($pos -lt 0) {
        $pos = $lines.Count; if ($lines[$pos - 1] -eq '') { $pos-- }
    }
    $lines.Insert($pos, $PostLine)
    Write-Bytes $TplPost ($lines -join $tpNL)
    Log "template_post.dat: добавлена строка $($pos+1)." 'OK'
}

# проверка
$ok = $true
if (-not ((Read-Bytes $CamGen) -match 'ude_plus_probe\.cdl')) { $ok = $false; Log 'cam_general.dat не содержит ude_plus_probe.cdl' 'ERR' }
if (-not ((Read-Bytes $TplPost).Contains($PostLine))) { $ok = $false; Log 'template_post.dat не содержит строку поста' 'ERR' }
foreach ($n in $PostFiles) { if (-not (Test-Path (Join-Path $PostDst $n))) { $ok = $false; Log "нет $n в $PostDst" 'ERR' } }
if ($ok) {
    Log 'УСТАНОВКА ЗАВЕРШЕНА.' 'OK'
    Log 'Дальше: запустите NX, откройте деталь, в операции: Управление станком -> Начальные события -> Редактировать -> "Probe wall check".' 'OK'
    Log 'Постпроцессор: "1.ai_3ax_probe" в списке постпроцессоров.' 'OK'
    Log "Откат: install.bat -Uninstall (восстановит из $B)" 'OK'
} else { Log "Установка с ошибками - см. лог. Откат: install.bat -Uninstall -BackupDir `"$B`"" 'ERR' }
