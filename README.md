# NX_WM — постпроцессоры Siemens NX CAM

Коллекция постпроцессоров для генерации УП под разные станки и контроллеры.

## Посты

| Папка | Описание |
|-------|----------|
| `1.ai_3ax` | 3-осевой пост |
| `1.ai_3ax_probe` | 3-осевой пост с поддержкой измерений щупом (Hexagon) |
| `1.ai_4ax` | 4-осевой пост |
| `2.Cutter CH` | Cutter CH |
| `3.Sicono` | Sicono CNC |

Список постов для установки в NX — в файле `template_post.dat`.

## Щуп и UDE (Hexagon)

Пост `1.ai_3ax_probe` включает UDE-события:

1. **Probe wall check**
2. **Probe set Z top**
3. **Probe set boss center**
4. **Probe set hole center**

Для событий измерения доступен переключатель **Feed override**.

## Установка Probe_Installer на другой ПК

В репозитории есть папка `Probe_Installer/` с установщиком поста `1.ai_3ax_probe` и UDE-файлов.

1. Запустить `Probe_Installer/install.bat`.
2. Рекомендуется сначала выполнить установку в режиме `-DryRun`.
3. Для отката использовать режим `-Uninstall`.

Установщик изменяет строку `USER_DEFINED_EVENTS` в `cam_general.dat` и записи в `template_post.dat`, перед изменениями делает резервные копии в `E:\\NX_Tools\\Backup`.

## Структура

- `*.tcl` — основной код постпроцессора
- `*.def` — определение поста
- `*.pui` — интерфейс Post Builder
- `ugpost_base.tcl` — базовые функции поста

## Журнал изменений

См. `POST_CHANGES_LOG_2026-03-23.txt`.
