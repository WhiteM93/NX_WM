<#
  Установщик постпроцессоров NX_WM в Siemens NX2506.
  Параметры:
    -NxDir <путь>    папка NX (например "D:\Program Files\Siemens\NX2506")
    -DryRun          только показать, что будет изменено
    -Uninstall       откатить последнюю установку из резервной копии (или -BackupDir)
    -Yes             не спрашивать подтверждения (template_post.dat / cam_general.dat)
    -IncludeBase     также предлагать ugpost_base*.tcl (базовые файлы Siemens)
    -BackupRoot      куда класть резервные копии (по умолчанию E:\NX_Tools\Backup)
  Устаревшие посты 1.ai_3ax_omp и 1.ai_3ax_probe (объединены в 1.ai_3ax) установщик
  сохраняет в резервную копию, затем удаляет из NX вместе с их строками template_post.dat.
#>
param(
  [string]$NxDir,
  [switch]$DryRun,
  [switch]$Uninstall,
  [switch]$Yes,
  [switch]$IncludeBase,
  [string]$BackupRoot,
  [string]$BackupDir
)
$ErrorActionPreference = 'Stop'
$Repo = $PSScriptRoot
$Raw  = [Text.Encoding]::GetEncoding(28591)   # байт-в-байт (кодировка сохраняется)
$PostFolders = @('1.ai_3ax','1.ai_4ax','2.Cutter CH','3.Sicono')
$ObsoleteFolders = @('1.ai_3ax_omp','1.ai_3ax_probe')   # объединены в 1.ai_3ax (2026-11-03)
$RootFiles   = @('ude_wm.cdl')
$BaseFiles   = @('ugpost_base.tcl','ugpost_base_math.tcl')

function Say($m,$c='Gray'){ Write-Host $m -ForegroundColor $c }
function Confirm-D($q){
  if ($Yes) { Say "$q -> да (-Yes)" 'Yellow'; return $true }
  $a = Read-Host "$q Введите 'д' для подтверждения"
  return ($a -eq 'д' -or $a -eq 'Д')
}
function Hash($p){ if (Test-Path -LiteralPath $p) { (Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash } else { $null } }

# --- поиск NX ---
if (-not $NxDir) {
  $cand = @()
  if ($env:UGII_BASE_DIR) { $cand += $env:UGII_BASE_DIR }
  foreach ($d in 'C','D','E') { $cand += "${d}:\Program Files\Siemens\NX2506" }
  foreach ($c in $cand) { if (Test-Path -LiteralPath (Join-Path $c 'MACH\resource\postprocessor')) { $NxDir = $c; break } }
}
if (-not $NxDir -or -not (Test-Path -LiteralPath (Join-Path $NxDir 'MACH\resource\postprocessor'))) {
  Say "NX2506 не найден. Укажите -NxDir." 'Red'; exit 1
}
$Res  = Join-Path $NxDir 'MACH\resource'
$Post = Join-Path $Res 'postprocessor'
$Cfg  = Join-Path $Res 'configuration\cam_general.dat'
Say "NX: $NxDir" 'Cyan'

if (Get-Process -Name ugraf -ErrorAction SilentlyContinue) { Say "NX запущен (ugraf.exe). Закройте NX и повторите." 'Red'; exit 2 }

# --- резервная папка ---
if (-not $BackupRoot) {
  if (Test-Path 'E:\') { $BackupRoot = 'E:\NX_Tools\Backup' }
  else { $BackupRoot = Read-Host 'Диск E: не найден. Укажите папку для резервных копий' }
}

# ================= UNINSTALL =================
if ($Uninstall) {
  if (-not $BackupDir) {
    $BackupDir = Get-ChildItem -LiteralPath $BackupRoot -Directory -Filter 'nx_install_*' -ErrorAction SilentlyContinue |
      Where-Object { Test-Path (Join-Path $_.FullName 'manifest.json') } | Sort-Object Name -Descending | Select-Object -First 1 -ExpandProperty FullName
  }
  if (-not $BackupDir) { Say "Резервная копия не найдена." 'Red'; exit 3 }
  $man = Get-Content -LiteralPath (Join-Path $BackupDir 'manifest.json') -Raw -Encoding UTF8 | ConvertFrom-Json
  Say "Откат из: $BackupDir" 'Cyan'
  foreach ($e in $man) {
    $tgt = Join-Path $Res $e.rel
    if ($e.existed) {
      Say "  восстановить $($e.rel)"
      if (-not $DryRun) { $src = Join-Path $BackupDir ('files\' + $e.rel); New-Item -ItemType Directory -Force (Split-Path $tgt) | Out-Null; Copy-Item -LiteralPath $src -Destination $tgt -Force }
    } else {
      Say "  удалить (новый) $($e.rel)"
      if (-not $DryRun -and (Test-Path -LiteralPath $tgt)) { Remove-Item -LiteralPath $tgt -Force }
    }
  }
  Say "Откат завершён." 'Green'; exit 0
}

# ================= INSTALL =================
$ts = Get-Date -Format 'yyyyMMdd_HHmmss'
$Bk = Join-Path $BackupRoot "nx_install_$ts"
if (-not $DryRun) { New-Item -ItemType Directory -Force $Bk | Out-Null; Start-Transcript -Path (Join-Path $Bk 'install.log') | Out-Null }

$plan = New-Object System.Collections.ArrayList   # @{rel; src; bytes(optional)}

# 1) файлы постпроцессоров
$items = @()
foreach ($f in $PostFolders) {
  $dir = Join-Path $Repo $f
  if (-not (Test-Path -LiteralPath $dir)) { Say "Нет папки в репозитории: $f" 'Yellow'; continue }
  Get-ChildItem -LiteralPath $dir -Recurse -File | Where-Object { $_.Name -notmatch '\.bak|\.orig$' } | ForEach-Object {
    $items += [pscustomobject]@{ rel = 'postprocessor\' + $_.FullName.Substring($Repo.Length + 1); src = $_.FullName }
  }
}
foreach ($f in $RootFiles) { $items += [pscustomobject]@{ rel = "postprocessor\$f"; src = (Join-Path $Repo $f) } }
foreach ($it in $items) {
  if ((Hash $it.src) -ne (Hash (Join-Path $Res $it.rel))) { [void]$plan.Add(@{ rel = $it.rel; src = $it.src }) }
}

# 2) базовые файлы Siemens (только по запросу)
foreach ($f in $BaseFiles) {
  $s = Join-Path $Repo $f; $t = Join-Path $Post $f
  if (-not (Test-Path -LiteralPath $s)) { continue }
  if ((Hash $s) -eq (Hash $t)) { continue }
  Say "ВНИМАНИЕ: $f в репозитории отличается от файла NX (базовый файл Siemens)." 'Yellow'
  if ($IncludeBase -and -not $DryRun) {
    $a = Read-Host "Заменить $f ? Введите 'д'"
    if ($a -eq 'д' -or $a -eq 'Д') { [void]$plan.Add(@{ rel = "postprocessor\$f"; src = $s }) }
  } else { Say "  пропущено (используйте -IncludeBase для замены)" }
}

Say "`nФайлы к копированию: $($plan.Count)" 'Cyan'
foreach ($p in $plan) { $st = if (Test-Path -LiteralPath (Join-Path $Res $p.rel)) { 'изменён' } else { 'новый' }; Say "  [$st] $($p.rel)" }

# 2b) устаревшие папки постов в NX: резервная копия, затем удаление
$obsFiles = @()
$obsDirs  = @()
foreach ($f in $ObsoleteFolders) {
  $d = Join-Path $Post $f
  if (Test-Path -LiteralPath $d) {
    $obsDirs += $d
    Get-ChildItem -LiteralPath $d -Recurse -File | ForEach-Object { $obsFiles += 'postprocessor\' + $_.FullName.Substring($Post.Length + 1) }
    Say "  [УДАЛИТЬ] postprocessor\$f (устаревший пост, объединён в 1.ai_3ax)" 'Yellow'
  }
}

# 3) template_post.dat — только наши строки
function Split-Lines($t){ $t -split "`r?`n" }
$tplT = Join-Path $Post 'template_post.dat'
$tplPlan = $null
$ourLines = Split-Lines ([IO.File]::ReadAllText((Join-Path $Repo 'template_post.dat'), $Raw)) | Where-Object { $_.Trim() -ne '' -and -not $_.StartsWith('#') }
if (Test-Path -LiteralPath $tplT) {
  $old = [IO.File]::ReadAllText($tplT, $Raw)
  $nl = if ($old -match "`r`n") { "`r`n" } else { "`n" }
  $lines = [System.Collections.ArrayList]@(Split-Lines $old)
  if ($lines.Count -gt 0 -and $lines[$lines.Count-1] -eq '') { $lines.RemoveAt($lines.Count-1); $trail = $true } else { $trail = $false }
  $changed = $false
  foreach ($ol in $ourLines) {
    $name = ($ol -split ',')[0].Trim()
    $idx = -1
    for ($i=0; $i -lt $lines.Count; $i++) { if ((($lines[$i] -split ',')[0].Trim()) -eq $name) { $idx = $i; break } }
    if ($idx -ge 0) {
      if ($lines[$idx] -ne $ol) { Say "template_post.dat заменить:`n  было:  $($lines[$idx])`n  стало: $ol" 'Yellow'; $lines[$idx] = $ol; $changed = $true }
    } else { Say "template_post.dat добавить:`n  стало: $ol" 'Yellow'; [void]$lines.Add($ol); $changed = $true }
  }
  for ($i = $lines.Count - 1; $i -ge 0; $i--) {
    if ($ObsoleteFolders -contains (($lines[$i] -split ',')[0].Trim())) {
      Say "template_post.dat удалить:`n  было:  $($lines[$i])" 'Yellow'; $lines.RemoveAt($i); $changed = $true
    }
  }
  if ($changed) { $new = ($lines -join $nl); if ($trail) { $new += $nl }; $tplPlan = $new } else { Say "template_post.dat: изменений нет" }
}

# 4) cam_general.dat — только строка USER_DEFINED_EVENTS
$cfgPlan = $null
$repoUde = Split-Lines ([IO.File]::ReadAllText((Join-Path $Repo 'configuration\cam_general.dat'), $Raw)) | Where-Object { $_ -match '^\s*USER_DEFINED_EVENTS' } | Select-Object -First 1
if ($repoUde -and (Test-Path -LiteralPath $Cfg)) {
  $old = [IO.File]::ReadAllText($Cfg, $Raw)
  $m = [regex]::Match($old, '(?m)^[ \t]*USER_DEFINED_EVENTS[^\r\n]*')
  if ($m.Success) {
    if ($m.Value -ne $repoUde) {
      Say "cam_general.dat:`n  было:  $($m.Value)`n  стало: $repoUde" 'Yellow'
      $cfgPlan = $old.Substring(0, $m.Index) + $repoUde + $old.Substring($m.Index + $m.Length)
    } else { Say "cam_general.dat: изменений нет" }
  } else { Say "cam_general.dat: строка USER_DEFINED_EVENTS не найдена — пропуск" 'Red' }
}

if ($DryRun) { Say "`n-DryRun: ничего не изменено." 'Green'; exit 0 }

$doTpl = $false; $doCfg = $false
if ($tplPlan) { $doTpl = Confirm-D 'Изменить template_post.dat?' }
if ($cfgPlan) { $doCfg = Confirm-D 'Изменить cam_general.dat?' }
$doObs = $false
if ($obsDirs.Count) { $doObs = Confirm-D 'Удалить устаревшие папки 1.ai_3ax_omp / 1.ai_3ax_probe (после резервной копии)?' }

# резервная копия + манифест
$manifest = @()
$all = @($plan | ForEach-Object { $_.rel })
if ($doTpl) { $all += 'postprocessor\template_post.dat' }
if ($doCfg) { $all += 'configuration\cam_general.dat' }
if ($doObs) { $all += $obsFiles }
foreach ($rel in $all) {
  $t = Join-Path $Res $rel; $ex = Test-Path -LiteralPath $t
  if ($ex) { $b = Join-Path $Bk ('files\' + $rel); New-Item -ItemType Directory -Force (Split-Path $b) | Out-Null; Copy-Item -LiteralPath $t -Destination $b -Force }
  $manifest += [pscustomobject]@{ rel = $rel; existed = $ex }
}
$manifest | ConvertTo-Json -Depth 3 | Set-Content -LiteralPath (Join-Path $Bk 'manifest.json') -Encoding UTF8
Say "Резервная копия: $Bk" 'Cyan'

# запись
$fail = 0
foreach ($p in $plan) {
  $t = Join-Path $Res $p.rel; New-Item -ItemType Directory -Force (Split-Path $t) | Out-Null
  Copy-Item -LiteralPath $p.src -Destination $t -Force
  if ((Hash $p.src) -ne (Hash $t)) { Say "ОШИБКА хэша: $($p.rel)" 'Red'; $fail++ }
}
if ($doTpl) { [IO.File]::WriteAllText($tplT, $tplPlan, $Raw); Say "template_post.dat обновлён" 'Green' }
if ($doCfg) { [IO.File]::WriteAllText($Cfg, $cfgPlan, $Raw); Say "cam_general.dat обновлён" 'Green' }
if ($doObs) {
  foreach ($d in $obsDirs) { Remove-Item -LiteralPath $d -Recurse -Force; Say "Удалена устаревшая папка: $d" 'Green' }
}

Say "`nГотово. Скопировано файлов: $($plan.Count), ошибок хэша: $fail" $(if ($fail) {'Red'} else {'Green'})
Say "Откат: install.bat -Uninstall"
Stop-Transcript | Out-Null
if ($fail) { exit 4 }
