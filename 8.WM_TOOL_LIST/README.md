# 8.WM_TOOL_LIST — список инструментов в PDF

Пост формирует список инструментов в формате **PDF** (A4, Arial, колонка «Диаметр»). В шапке по центру выводится логотип **MW_logo.png** в чёрно-белом виде.

---

## Как получить PDF

1. В NX выберите пост **8.WM_TOOL_LIST(pdf)** и выполните обработку.
2. В каталоге вывода появятся файл **.html** и батник **«Имя_create_PDF.bat»**.
3. Дважды щёлкните по **«Имя_create_PDF.bat»** — Chrome или Edge создаст **.pdf** с тем же именем.

Конвертация в PDF из самого поста не запускается (в NX вызов внешней программы блокирует завершение). Если Chrome/Edge не установлены, откройте **.html** в браузере и сохраните как PDF (Печать → Сохранить как PDF).

---

## Регистрация в template_post.dat

```
8.WM_TOOL_LIST(pdf),${UGII_CAM_POST_DIR}8.WM_TOOL_LIST\WM_OPERATION_LIST_pdf.tcl,${UGII_CAM_POST_DIR}8.WM_TOOL_LIST\WM_OPERATION_LIST.def
```

---

## Логотип MW_logo.png

В шапке документа по центру выводится логотип (прозрачный PNG), **в документе он отображается в чёрно-белом виде**. Файл **MW_logo.png** должен находиться:

- в папке поста **8.WM_TOOL_LIST**, либо  
- в каталоге shop doc (**UGII_CAM_SHOP_DOC_DIR**).

Пост копирует логотип в каталог вывода, чтобы он отображался в HTML и в сформированном PDF.

---

## Зависимости

- **UGII_CAM_SHOP_DOC_DIR**: `shopdoc_header.tcl`, `post_tool_list_html.tpl`
- Шаблон: цикл SETUP → PROGRAMVIEW → MEMBERS → TOOL
