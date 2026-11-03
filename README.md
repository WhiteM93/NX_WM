# NX_WM - постпроцессоры Siemens NX CAM

Подробная инструкция на русском: [README_RU.md](README_RU.md).

## Посты

| Папка | Описание |
|-------|----------|
| `1.ai_3ax` | 3-осевой пост (FANUC) + щуп Hexagon: On Machine Probing, UDE `prb_center_axis`, `probe_wall_check`, `probe_set_*` |
| `1.ai_4ax` | 4-осевой пост |
| `2.Cutter CH` | Cutter CH |
| `3.Sicono` | Sicono CNC |

Список постов для установки в NX - в файле `template_post.dat`.

## UDE

Все пользовательские события подключаются через общий `ude_wm.cdl` (строка `USER_DEFINED_EVENTS` в `configuration/cam_general.dat`):

- `1.ai_3ax`: **prb_center_axis**, **Probe wall check**, **Probe set Z top**, **Probe set boss center**, **Probe set hole center**

Посты `1.ai_3ax_omp` и `1.ai_3ax_probe` объединены в `1.ai_3ax` (2026-11-03); `install.bat` удаляет их из NX (с резервной копией).

## Установка

Закрыть NX, запустить `install.bat -DryRun`, затем `install.bat`. Откат: `install.bat -Uninstall`. См. [README_RU.md](README_RU.md).

## Файлы

- `*.tcl` - основной код постпроцессора
- `*.def` - определение поста
- `*.pui` - интерфейс Post Builder
- `ugpost_base.tcl` - базовые функции Siemens
