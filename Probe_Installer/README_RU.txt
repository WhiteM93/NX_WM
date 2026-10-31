Установщик UDE "Probe wall check" + "Probe set ..." (3 шт.) + пост 1.ai_3ax_probe для NX2506
===================================================================

Что делает install.bat (сам запросит права администратора):
 1. Находит NX2506 (UGII_BASE_DIR -> реестр -> C:\ и D:\Program Files\Siemens\NX2506,
    иначе спросит путь).
 2. Проверяет, что NX закрыт (ugraf.exe). Если открыт - предложит повторить.
 3. Делает бэкап cam_general.dat и template_post.dat в
    E:\NX_Tools\Backup\<дата_время>\  (если нет диска E: - в папку Backup рядом
    со скриптом). OneDrive не используется никогда.
 4. Копирует ude_plus_probe.cdl, probe_wall_check.cdl/.tcl, probe_set.cdl/.tcl в
    E:\NX_Tools\ai_3ax_probe_test\ (если нет E: - спросит папку: латиница,
    без пробелов, не OneDrive; пути внутри cdl/def/tcl будут исправлены).
 5. Копирует пост в <NX>\MACH\resource\postprocessor\1.ai_3ax_probe\
 6. В cam_general.dat меняет строку USER_DEFINED_EVENTS на ude_plus_probe.cdl
    (только если ещё не изменена). В template_post.dat добавляет строку
    1.ai_3ax_probe после 1.ai_3ax (только если её нет). Кодировка и переводы
    строк файлов сохраняются.
 7. Предупреждает, если 1.ai_3ax\ai_3ax.tcl на этом ПК отличается от того,
    из которого собран пакет.

Запуск:
  install.bat              - установка
  install.bat -DryRun      - только показать план, ничего не менять
  install.bat -Uninstall   - откат из последнего бэкапа (вернёт cam_general.dat и
                             template_post.dat, удалит папку 1.ai_3ax_probe)
  install.bat -Uninstall -BackupDir "E:\NX_Tools\Backup\2026-10-31_1730"
  Доп.: -NxDir "<папка NX2506>"  -UdeDir "<папка>"  -BackupRoot "<папка>"  -Yes

Лог: install_log.txt рядом со скриптом.

После установки в NX:
  Операция -> Управление станком -> Начальные события -> Редактировать ->
  "Probe wall check", "Probe set Z top", "Probe set boss center",
  "Probe set hole center". Постпроцессор: 1.ai_3ax_probe.

Важно: изменение cam_general.dat влияет только на конфигурацию cam_general.
Если вы работаете в mill_planar / mill_contour и т.п. - в них строка
USER_DEFINED_EVENTS не меняется.

Параметры событий (обновлено 31.10.2026)
========================================
Общее для всех событий:
  - В начале события: G90 G40 G80 G17 / G00 G90 G53 Z0. / T<T> M06 /
    G00 G90 <G54..> X Y / G43 H<T> Z<Zsafe>. Перед #3006 - G00 G90 G53 Z0.
  - X/Y и Z никогда не выводятся в одном кадре.
  - После события пост выводит полный G90 + X Y Z (+G43 H) в следующей
    операции. Если следующая операция с тем же инструментом, что был до
    щупа (NX не делает смену), смена инструмента выводится принудительно -
    щуп в шпинделе не остаётся.
  - Текст "&#nnn&" в #3006 пишется в файл .ptp буквально (проверено реальным
    постпроцессингом NX2506). Если в окне "Информация" NX вместо "&#190&"
    видно "¾&" - это только отображение окна NX, в файле всё правильно
    (откройте .ptp в Блокноте).
    Переключатель в probe_wall_check.tcl: ::pwc_amp_mode
      LITERAL (по умолчанию) | TEXT | AMP38 (&#38#) | AMPENT (&amp;#)
    ::pwc_force_tool_back 1 - принудительная смена инструмента после щупа
    (0 - выключить).

Probe wall check (probe_wall_check):
  Probe tool number (T and H) - номер щупа, по умолчанию 20 (T и H одинаковые)
  Work offset - G54..G59 или G54.1; G54.1 P number - номер P для G54.1
  Point 1 / Point 2, Z touch, Z safe, Direction, Touch distance, Tolerance,
  Var 1 / Var 2 / Var diff (152-199) - как раньше.
  Первая точка: подход G00 XY + G43 Z safe (старый G65 P9102 X Y Z50. убран).
  Вторая точка: G65 P9102 X Y, затем G65 P9102 Z.

Probe set Z top (probe_set_z_top):        Point (X Y), Z safe 50,
  Z approach 10, Z nominal 0  -> G65 P9103 Z<Znom> W#171 F#170
Probe set boss center (probe_set_boss_center): Point (центр X Y),
  Diameter D 50 (выводится с минусом), Z depth -10, Z safe, Z approach
  -> G65 P9103 D-<D> Z<Zdepth> W#171 F#170
Probe set hole center (probe_set_hole_center): Point (центр X Y),
  Diameter D 50, Z depth -10, Z safe, Z approach
  -> G65 P9102 Z<Zdepth> F#170 / G65 P9103 D<D> W#171 F#170
Общие параметры Probe set: Feed override (#170, см. ниже), Zero W (#171): 1..6 = G54..G59,
  -n = G54.1 Pn (до -300); Probe tool number (T and H) 20.
  Z точки (Point) игнорируется. Проверки: D>0, Zsafe>Zapproach>Zdepth
  (Z top: Zapproach>Znominal), W 1..6 или -1..-300, T 1..999,
  Feed>0 (только если Feed override включён).
  Сообщения: (BOBYSHKA X=&#101& Y=&#102& D=&#100&),
  (OTVERSTIE X=&#101& Y=&#102& D=&#100&), (Z NOL ZAPISAN. Z=&#103&).

Feed override - подача подвода (обновлено 31.10.2026)
=====================================================
Во всех 4 событиях (Probe set Z top / boss center / hole center и
Probe wall check) есть параметр "Feed override" с галочкой (TOGGLE).
По умолчанию галочка ВЫКЛЮЧЕНА.
  Выключено: строки #170=... нет, и ни в одном G65 P9102/P9103 нет F#170 -
             циклы щупа используют свою подачу по умолчанию (#111).
  Включено (значение, напр. 1000):
    Probe set:        #170=1000. (PODACHA PODVODA) после G90 G40 G80 G17
                      и F#170 в G65 P9102/P9103 (как раньше).
    Probe wall check: #170=1000. (PODACHA PODVODA) после G90 G40 G80 G17
                      и F#170 во всех G65 P9102/P9103. Var 1/2/diff при этом
                      не могут быть 170.
Как NX передаёт галочку в пост (проверено реальным постпроцессингом NX2506):
  включено  -> mom_pst_feed=<значение>, mom_pst_feed_defined=1
  выключено -> mom_pst_feed не передаётся, mom_pst_feed_defined=0
  (для wall check - mom_pwc_feed / mom_pwc_feed_defined).
Если UDE уже были вставлены в операции до этого обновления, откройте их
и проверьте галочку Feed override (старые события могут не иметь
нового параметра - тогда подача не выводится).
