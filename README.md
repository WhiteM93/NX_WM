# NX_WM - постпроцессоры Siemens NX CAM

Подробная инструкция на русском: [README_RU.md](README_RU.md).

## Посты

| Папка | Описание |
|-------|----------|
| `1.ai_3ax` | 3-осевой пост |
| `1.ai_3ax_omp` | 3-осевой пост с щупом OMP (UDE `prb_center_axis`) |
| `1.ai_3ax_probe` | 3-осевой пост с поддержкой измерений щупом (Hexagon) |
| `1.ai_4ax` | 4-осевой пост |
| `2.Cutter CH` | Cutter CH |
| `3.Sicono` | Sicono CNC |

Список постов для установки в NX - в файле `template_post.dat`.

## UDE

Все пользовательские события подключаются через общий `ude_wm.cdl` (строка `USER_DEFINED_EVENTS` в `configuration/cam_general.dat`):

- `1.ai_3ax_omp`: **prb_center_axis**
- `1.ai_3ax_probe`: **Probe wall check**, **Probe set Z top**, **Probe set boss center**, **Probe set hole center**

## Установка

Закрыть NX, запустить `install.bat -DryRun`, затем `install.bat`. Откат: `install.bat -Uninstall`. См. [README_RU.md](README_RU.md).

## Файлы

- `*.tcl` - основной код постпроцессора
- `*.def` - определение поста
- `*.pui` - интерфейс Post Builder
- `ugpost_base.tcl` - базовые функции Siemens
