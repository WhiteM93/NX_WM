# NX_WM — постпроцессоры для Siemens NX2506

## Постпроцессоры (папки = имена в списке NX, не переименовывать)
| Папка | Назначение |
|---|---|
| `1.ai_3ax` | 3-осевой фрезерный (FANUC) + щуп: OMP (UDE `prb_center_axis` «Привязка центра по 2 точкам», `prb_z_point` «Привязка Z», `probe_omp.tcl/.cdl`), `probe_wall_check`, `probe_set_*` (`probe_*.tcl/.cdl`) |
| `1.ai_4ax` | 4-осевой (в `template_post.dat` не добавляется) |
| `2.Cutter CH` | Cutter CH |
| `3.Sicono` | Sicono |

Прочее:
- `ude_wm.cdl` — общий файл UDE: подключает `probe_omp.cdl`, `probe_wall_check.cdl`, `probe_set.cdl` и стандартный `ude.cdl` NX.
- `configuration/cam_general.dat` — изменена только строка `USER_DEFINED_EVENTS` (→ `${UGII_CAM_POST_DIR}ude_wm.cdl`). Оригинал Siemens: `cam_general.dat.siemens_original`.
- `template_post.dat` — строки списка постпроцессоров NX.
- `ugpost_base*.tcl` — базовые файлы Siemens (установщик заменяет их только с `-IncludeBase`).

## Где живут UDE
CDL/TCL событий лежат в папке поста `1.ai_3ax` (посты `1.ai_3ax_omp` и `1.ai_3ax_probe` объединены в `1.ai_3ax` 2026-11-03; операции, где они были выбраны, переключите на `1.ai_3ax`). Обработчики `MOM_*` подгружаются из `.tcl` поста через `info script`, при неудаче — из `$env(UGII_CAM_POST_DIR)/1.ai_3ax/`.

## Установка на рабочем ПК
1. `git clone https://github.com/WhiteM93/NX_WM.git` (или `git pull` в существующей папке).
2. Закройте NX.
3. Сначала проверка: `install.bat -DryRun` — покажет, что будет изменено.
4. Установка: `install.bat` — для `template_post.dat` и `cam_general.dat` отдельно спросит подтверждение (`д`).
   Устаревшие папки `1.ai_3ax_omp` / `1.ai_3ax_probe` и их строки в `template_post.dat` установщик сохраняет в резервную копию и удаляет (спросит `д`).
   Резервная копия и лог: `E:\NX_Tools\Backup\nx_install_<время>\`.
   Параметр `-NxDir "D:\Program Files\Siemens\NX2506"`, если NX не найден автоматически.

### Если NX установлен в Program Files (ошибка «Отказано в доступе»)
Файлы в `C:\Program Files\...` (или `D:\Program Files\...`) по умолчанию защищены от записи, поэтому `cam_general.dat` может не записаться (`UnauthorizedAccessException`).
1. Закройте NX.
2. Откройте PowerShell **от имени администратора** (Win+X → «Терминал (администратор)»).
3. Снимите «только чтение» с файла:
   `attrib -r "C:\Program Files\Siemens\NX2506\MACH\resource\configuration\cam_general.dat"`
4. Один раз выдайте себе права на папку `resource` (дальше установщик можно запускать без администратора):
   `icacls "C:\Program Files\Siemens\NX2506\MACH\resource" /grant "${env:USERNAME}:(OI)(CI)M" /T`
   В PowerShell пишите именно `${env:USERNAME}`; `%USERNAME%` работает только в cmd.
5. Запустите установку снова: `install.bat` (или `& ".\install.ps1"`) и подтвердите `д`.
6. Проверка в NX: в списке UDE должны быть «Привязка центра по 2 точкам», «Привязка Z» и старые события щупа.

## Ручная установка
1. Скопировать папки постпроцессоров и `ude_wm.cdl` в `<NX>\MACH\resource\postprocessor\`.
2. Добавить/заменить строки из `template_post.dat` в `<NX>\MACH\resource\postprocessor\template_post.dat`.
3. В `<NX>\MACH\resource\configuration\cam_general.dat` заменить строку `USER_DEFINED_EVENTS` на строку из репозитория.
Сохранять кодировку файлов (CDL — Windows-1251, CRLF).

## Откат
`install.bat -Uninstall` — восстанавливает файлы из последней резервной копии и удаляет добавленные (или `-BackupDir <папка>`).
