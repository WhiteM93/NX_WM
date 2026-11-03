# NX_WM — постпроцессоры для Siemens NX2506

## Постпроцессоры (папки = имена в списке NX, не переименовывать)
| Папка | Назначение |
|---|---|
| `1.ai_3ax` | 3-осевой фрезерный (FANUC) |
| `1.ai_3ax_omp` | 3-осевой + измерительный щуп OMP (UDE `prb_center_axis`, `probe_omp.tcl/.cdl`) |
| `1.ai_3ax_probe` | 3-осевой + щуп: `probe_wall_check`, `probe_set_*` (`probe_*.tcl/.cdl`) |
| `1.ai_4ax` | 4-осевой (в `template_post.dat` не добавляется) |
| `2.Cutter CH` | Cutter CH |
| `3.Sicono` | Sicono |

Прочее:
- `ude_wm.cdl` — общий файл UDE: подключает `probe_omp.cdl`, `probe_wall_check.cdl`, `probe_set.cdl` и стандартный `ude.cdl` NX.
- `configuration/cam_general.dat` — изменена только строка `USER_DEFINED_EVENTS` (→ `${UGII_CAM_POST_DIR}ude_wm.cdl`). Оригинал Siemens: `cam_general.dat.siemens_original`.
- `template_post.dat` — строки списка постпроцессоров NX.
- `ugpost_base*.tcl` — базовые файлы Siemens (установщик заменяет их только с `-IncludeBase`).

## Где живут UDE
CDL/TCL событий лежат в папках постпроцессоров (`1.ai_3ax_omp`, `1.ai_3ax_probe`). Обработчики `MOM_*` подгружаются из `.tcl` поста через `info script`, при неудаче — из `$env(UGII_CAM_POST_DIR)/<папка>/`.

## Установка на рабочем ПК
1. `git clone https://github.com/WhiteM93/NX_WM.git` (или `git pull` в существующей папке).
2. Закройте NX.
3. Сначала проверка: `install.bat -DryRun` — покажет, что будет изменено.
4. Установка: `install.bat` — для `template_post.dat` и `cam_general.dat` отдельно спросит подтверждение (`д`).
   Резервная копия и лог: `E:\NX_Tools\Backup\nx_install_<время>\`.
   Параметр `-NxDir "D:\Program Files\Siemens\NX2506"`, если NX не найден автоматически.

## Ручная установка
1. Скопировать папки постпроцессоров и `ude_wm.cdl` в `<NX>\MACH\resource\postprocessor\`.
2. Добавить/заменить строки из `template_post.dat` в `<NX>\MACH\resource\postprocessor\template_post.dat`.
3. В `<NX>\MACH\resource\configuration\cam_general.dat` заменить строку `USER_DEFINED_EVENTS` на строку из репозитория.
Сохранять кодировку файлов (CDL — Windows-1251, CRLF).

## Откат
`install.bat -Uninstall` — восстанавливает файлы из последней резервной копии и удаляет добавленные (или `-BackupDir <папка>`).
