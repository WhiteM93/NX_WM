# WM_TOOL_LIST — список операций (цеховая документация WM)

Пост генерирует **список операций по программе**: для каждой программы — таблица «Имя операции | Описание (тип/подтип) | Инструмент». Форматы: **HTML** и **текст (TXT)**.

---

## Как это работает

1. NX при выборе поста **WM_TOOL_LIST(html)** или текстового варианта загружает из этой папки:
   - **WM_OPERATION_LIST_html.tcl** или **WM_OPERATION_LIST_text.tcl**
   - **WM_OPERATION_LIST.def** (MACHINE shopdoc)

2. В начале скрипта подключается общий заголовок цеховой документации:
   - `mom_source_directory = UGII_CAM_SHOP_DOC_DIR`
   - `source "${mom_source_directory}shopdoc_header.tcl"`
   В `shopdoc_header.tcl` определены, в частности: **ShopDoc_Header_html**, **ShopDoc_Header_text** (и другие общие процедуры для Shop Documentation).

3. Для прохода по иерархии (Setup → Program → Operations → Tools) вызывается **шаблон .tpl**:
   - HTML: `MOM_do_template_file ${cam_post_dir}post_operation_list_html.tpl`
   - Текст: `MOM_do_template_file ${cam_post_dir}post_operation_list_text.tpl`  
   Здесь **cam_post_dir = UGII_CAM_SHOP_DOC_DIR** (каталог Shop Documentation NX, не постпроцессор).

4. Шаблон .tpl задаёт цикл обхода — тот же, что в **WM_OPERATION_LIST.tpl** в этой папке:
   ```tcl
   [MOM_cycle_objects {SETUP {PROGRAMVIEW {MEMBERS {TOOL}}}}]
   ```
   При проходе NX вызывает обработчики в .tcl: **MOM_SETUP_HDR**, **MOM_PROGRAMVIEW_HDR**, **MOM_TOOL_BODY**, **MOM_OPER_BODY** и т.д.

5. Вывод:
   - **HTML**: заголовок документа и таблицы задаёт **shopdoc_header.tcl** (нет своего полного HTML-каркаса в папке 7). В .tcl выводятся строки таблицы: имя операции, описание (template_type/template_subtype), имя инструмента. Специально обрабатывается тип операции **Wire EDM** (в **MOM_OPER_BODY**).
   - **Текст**: заголовки и разделители выводятся из **WM_OPERATION_LIST_text.tcl**; строки — операция, описание, инструмент.

---

## Файлы в папке WM_TOOL_LIST

| Файл | Назначение |
|------|------------|
| **WM_OPERATION_LIST.def** | Определение поста: `MACHINE shopdoc`. Обязателен для регистрации в NX. |
| **WM_OPERATION_LIST.tpl** | Описание цикла обхода: SETUP → PROGRAMVIEW → MEMBERS → TOOL. Используется NX при загрузке поста (структура цикла). |
| **WM_OPERATION_LIST_html.tcl** | Логика поста для вывода списка операций в **HTML**. Вызывает `post_operation_list_html.tpl` из каталога Shop Doc. |
| **WM_OPERATION_LIST_text.tcl** | Логика поста для вывода списка операций в **текстовом** виде. Вызывает `post_operation_list_text.tpl` из каталога Shop Doc. |

---

## Зависимости и пути (что не ломать)

### 1. Регистрация в template_post.dat

В **template_post.dat** в корне постпроцессора должна быть строка:

```
WM_TOOL_LIST(html),${UGII_CAM_POST_DIR}WM_TOOL_LIST\WM_OPERATION_LIST_html.tcl,${UGII_CAM_POST_DIR}WM_TOOL_LIST\WM_OPERATION_LIST.def
```

- Имя поста в NX: **WM_TOOL_LIST(html)**.
- Путь к .tcl и .def задаётся через **UGII_CAM_POST_DIR** (каталог постпроцессора), подпапка **WM_TOOL_LIST**.

При необходимости текстовый вариант:

```
WM_TOOL_LIST(text),${UGII_CAM_POST_DIR}WM_TOOL_LIST\WM_OPERATION_LIST_text.tcl,${UGII_CAM_POST_DIR}WM_TOOL_LIST\WM_OPERATION_LIST.def
```

Не менять имена файлов и папки **WM_TOOL_LIST** без правки template_post.dat.

---

### 2. Переменные окружения NX

| Переменная | Где используется | Назначение |
|------------|------------------|------------|
| **UGII_CAM_POST_DIR** | template_post.dat | Корень постпроцессора. Путь к папке 7 и к файлам поста. |
| **UGII_CAM_SHOP_DOC_DIR** | Оба .tcl в 7 | Каталог Shop Documentation NX. Отсюда загружаются **shopdoc_header.tcl** и шаблоны **post_operation_list_*.tpl**. |

В скриптах явно задано:

- `mom_source_directory = [MOM_ask_env_var UGII_CAM_SHOP_DOC_DIR]`
- `source "${mom_source_directory}shopdoc_header.tcl"`
- `cam_post_dir = [MOM_ask_env_var UGII_CAM_SHOP_DOC_DIR]`
- `MOM_do_template_file ${cam_post_dir}post_operation_list_html.tpl` / `...post_operation_list_text.tpl`

То есть **шаблоны списка операций ищутся в каталоге Shop Doc**, а не в папке постпроцессора.

---

### 3. Внешние файлы (обязательные для работы)

Все пути относительно **UGII_CAM_SHOP_DOC_DIR** (каталог Shop Documentation, задаётся NX):

| Файл | Назначение |
|------|------------|
| **shopdoc_header.tcl** | Общие процедуры цеховой документации: ShopDoc_Header_html, ShopDoc_Header_text и др. Без него пост падает при загрузке. |
| **post_operation_list_html.tpl** | Шаблон цикла для HTML-поста. Содержит вызов `MOM_cycle_objects {SETUP {PROGRAMVIEW {MEMBERS {TOOL}}}}`. Должен лежать в UGII_CAM_SHOP_DOC_DIR. |
| **post_operation_list_text.tpl** | То же для текстового поста. Должен лежать в UGII_CAM_SHOP_DOC_DIR. |

Содержимое обоих .tpl по структуре должно совпадать с **WM_OPERATION_LIST.tpl** в этой папке (цикл SETUP → PROGRAMVIEW → MEMBERS → TOOL).

Если **post_operation_list_*.tpl** в каталоге Shop Doc нет, NX при постобработке выдаст ошибку (шаблон не найден). Варианты решения:

- Скопировать **WM_OPERATION_LIST.tpl** в каталог Shop Doc как **post_operation_list_html.tpl** и **post_operation_list_text.tpl**,  
  **или**
- Перенести шаблоны в корень постпроцессора, в .tcl заменить `UGII_CAM_SHOP_DOC_DIR` на `UGII_CAM_POST_DIR` и использовать `[file join $cam_post_dir post_operation_list_html.tpl]` (и аналогично для text), положив .tpl в корень постпроцессора.

---

### 4. Где что лежит (кратко)

```
NX (переменные):
  UGII_CAM_POST_DIR     = корень постпроцессора (например ...\postprocessor)
  UGII_CAM_SHOP_DOC_DIR = каталог Shop Documentation NX (часто внутри установки NX)

Корень постпроцессора:
  template_post.dat     — строка с WM_TOOL_LIST(html) и путём к WM_TOOL_LIST\...

Папка WM_TOOL_LIST:
  WM_OPERATION_LIST.def
  WM_OPERATION_LIST.tpl
  WM_OPERATION_LIST_html.tcl
  WM_OPERATION_LIST_text.tcl

Каталог Shop Doc (UGII_CAM_SHOP_DOC_DIR):
  shopdoc_header.tcl
  post_operation_list_html.tpl   — обязателен для HTML-поста
  post_operation_list_text.tpl   — обязателен для текстового поста
```

---

## Важные процедуры в .tcl (не переименовывать без правки NX)

- **MOM_Start_Part_Documentation** — вызывает ShopDoc_Header_html / ShopDoc_Header_text.
- **MOM_start_of_program**, **MOM_start_of_group** — инициализация вывода и вызов create_operation_list_html / create_operation_list_text.
- **create_operation_list_html** / **create_operation_list_text** — задают cam_post_dir и вызывают **MOM_do_template_file** с соответствующим .tpl.
- **MOM_SETUP_HDR** — заголовок документа (текст: «WM OPERATION LIST BY PROGRAM»; HTML: Setup_Header_html из shopdoc_header).
- **MOM_PROGRAMVIEW_HDR** — заголовок блока программы и таблицы (PROGRAM NAME, колонки OPERATION NAME / DESCRIPTION / TOOL NAME).
- **MOM_TOOL_BODY** — вывод строки по каждой операции/инструменту (имя операции, template_type/template_subtype, имя инструмента).
- **MOM_OPER_BODY** — запоминает template_type/template_subtype; для Wire EDM сразу выводит строку.
- **MOM_MEMBERS_HDR** / **MOM_MEMBERS_FTR**, **MOM_PROGRAM_BODY**, **MOM_PROGRAMVIEW_FTR** — обход программ и закрытие таблиц.

Переименование или удаление этих событий приведёт к поломке вывода или к ошибкам NX.

---

## Проверка после изменений

1. В NX в списке постов есть **WM_TOOL_LIST(html)** (и при необходимости WM_TOOL_LIST(text)).
2. Запуск поста не выдаёт ошибок вида «can't read ...» или «file not found».
3. Сгенерированный HTML содержит таблицы с колонками «OPERATION NAME», «OPERATION DESCRIPTION», «TOOL NAME» и строками по операциям/инструментам.
4. Текстовый вывод содержит заголовки «WM OPERATION LIST BY PROGRAM», «PROGRAM NAME : ...» и таблицу операция | описание | инструмент.

Если что-то из этого перестало работать — в первую очередь проверить наличие **shopdoc_header.tcl** и **post_operation_list_*.tpl** в каталоге **UGII_CAM_SHOP_DOC_DIR** и запись в **template_post.dat** для WM_TOOL_LIST.
