#####################################################################
# Патч для красивого списка инструментов и печати на A4
# Подключите этот файл в post_tool_list_html.tcl ПОСЛЕ строки:
#   source "${mom_source_directory}shopdoc_header.tcl"
# Добавьте:  source "[file dirname [info script]]/tool_list_html_A4_patch.tcl"
#####################################################################

# Переопределение заголовка HTML для печати на A4
proc ShopDoc_Header_html { } {
  MOM_output_literal "<!DOCTYPE html>"
  MOM_output_literal "<HTML lang=\"ru\">"
  MOM_output_literal "<HEAD>"
  MOM_output_literal "<META charset=\"utf-8\">"
  MOM_output_literal "<META name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
  MOM_output_literal "<TITLE>Список инструментов</TITLE>"
  MOM_output_literal "<STYLE>"
  MOM_output_literal "  @page { size: A4; margin: 12mm 15mm; }"
  MOM_output_literal "  * { box-sizing: border-box; }"
  MOM_output_literal "  body { font-family: 'Segoe UI', Arial, sans-serif; font-size: 10pt; line-height: 1.35; color: #222; margin: 0; padding: 8px 0; max-width: 180mm; margin-left: auto; margin-right: auto; }"
  MOM_output_literal "  .doc-header { text-align: center; margin-bottom: 10px; }"
  MOM_output_literal "  .doc-title { font-size: 14pt; font-weight: 700; color: #2c5282; margin: 6px 0; letter-spacing: 0.02em; }"
  MOM_output_literal "  .section-title { font-size: 11pt; font-weight: 600; color: #2b6cb0; margin: 8px 0 6px 0; padding: 4px 0; border-bottom: 1px solid #2b6cb0; }"
  MOM_output_literal "  table.tool-list { width: 100%; max-width: 180mm; margin: 0 auto 4px auto; border-collapse: collapse; font-size: 9pt; }"
  MOM_output_literal "  table.tool-list th { background: #2b6cb0; color: #fff; padding: 5px 6px; text-align: center; font-weight: 600; border: 1px solid #2b6cb0; }"
  MOM_output_literal "  table.tool-list td { padding: 4px 6px; border: 1px solid #cbd5e0; text-align: center; }"
  MOM_output_literal "  table.tool-list tr:nth-child(even) { background: #f7fafc; }"
  MOM_output_literal "  table.tool-list tr:hover { background: #edf2f7; }"
  MOM_output_literal "  .info-table { width: 100%; max-width: 180mm; margin: 0 auto 10px auto; border-collapse: collapse; font-size: 9pt; }"
  MOM_output_literal "  .info-table th { text-align: left; padding: 4px 8px; color: #4a5568; font-weight: 600; }"
  MOM_output_literal "  .info-table td { padding: 4px 8px; border-bottom: 1px solid #e2e8f0; }"
  MOM_output_literal "  @media print { body { padding: 0; } .tool-block { page-break-inside: avoid; } }"
  MOM_output_literal "</STYLE>"
  MOM_output_literal "</HEAD>"
  MOM_output_literal "<BODY>"
  MOM_output_literal "<div class=\"doc-header\"><H1 class=\"doc-title\">СПИСОК ИНСТРУМЕНТОВ</H1></div>"
}

proc Setup_Header_html { } {
  global mom_part_name mom_logname mom_date
  MOM_output_literal "<BR>"
  MOM_output_literal "<table class=\"info-table\">"
  MOM_output_literal "<tr><th>Создал:</th><td>$mom_logname</td><th>Дата:</th><td>$mom_date</td></tr>"
  MOM_output_literal "<tr><th>Деталь:</th><td colspan=\"3\">$mom_part_name</td></tr>"
  MOM_output_literal "</table>"
  MOM_output_literal "<BR>"
}
