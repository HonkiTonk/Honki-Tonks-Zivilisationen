package ChangelogSeptember2022 is

   -- Version 0.04.0470 => 0.04.0550 (30.09.2022):
   
   -- Scrollen ist jetzt auch mit ausgewählter Debugeinheit möglich.
   -- Fehler behoben der bei zu hohen Kampfwerten zu einem Absturz führte.
   -- Fehler korrigiert welcher es unmöglich machte sich auf Straßen zu bewegen.
   -- Fehler korrigiert der er unmöglich machte gegnerische Einheiten und Städte anzugreifen.
   -- Fehler korrigiert welcher dazu führte das eine ausgewählte Einheit nach einem Kampfsieg nicht mehr blinkte.
   -- Fehler korrigiert welcher nach beim Entfernen aller Einheiten und Städten nach einem Sieg zu einem feststecken im Ladebereich führte.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.0425 => 0.04.0470 (29.09.2022):
   
   -- Virtuelles System mit Debian Bullseye aufgesetzt um Tests in einer unmodifizeirten Umgebung durchführen zu können.
   -- Diverse Anpassungen an der gpr Datei vorgenommen um mehr Dateien statisch einzukompilieren und so plattformunabhängiger zu sein.
   -- Interne Benennung überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.0265 => 0.04.0425 (28.09.2022):
   
   -- Die Feldersichtbarkeitsprüfungen überarbeiten, so dass eine Ebene halbwegs logisch von einer anderen Ebene aus aufgedeckt wird.
   -- Stadtnamen von Unterwasserstädten werden jetzt nicht mehr an der Oberfläche angezeigt.
   -- Angefangen die EAchsenkonstanten einzubauen.
   -- Baumenüanzeige überarbeitet.
   -- Sichtweiten und Bewegungsfeld überarbeitet, es past sich jetzt ein wenig an die aktuelle Auflösung an.
   -- Die Produktionswerte einer Stadt werden bei einer Änderung der bearbeiteten Felder sofort korrekt angezeigt und nicht erst in der nächsten Runde.
   -- Bei der Berechnung der Nahrungsproduktion werden jetzt die vorhandenen Einwohner berücksichtigt.
   -- Fehler korrigiert der verhinderte das Einwohner einer Stadt verhungern konnten.
   -- Fehler korrigiert, welcher zu einem Absturz durch Fehlberechnung der verbleibenden Forschungszeit führte.
   -- Falsche Anzeige bei der Kartenartauswahl korrigiert.
   -- Fehler im Kartengenerator korrigiert, welcher bei zu großen Landflächen auf kleinen Karten zu Abstürzen führte.
   -- Karteneinstellungen überarbeitet.
   -- Kartengenerator überarbeitet.
   -- KI überarbeitet.
   -- Contracts, Kommenatare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.04.0265 => 0.04.0265 (27.09.2022):
   
   -- null.
   
   

   -- Version 0.04.0185 => 0.04.0265 (26.09.2022):
   
   -- Interne Benennung überarbeitet.
   -- Interne Struktur überarbeitet.
   -- Datenbanken und Standardeinstellungen vollständig voneinander getrennt und besseres Setzen der Standardeinstellungen eingebaut.
   -- Seitenleisteninformationen überarbeitet.
   -- Forschungsmenü überarbeitet.
   -- Baumenü überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.0110 => 0.04.0185 (25.09.2022):
   
   -- Erste Version des Forschungsbaums der Tesorahn eingebaut.
   -- Erste Version der Tesorahneinheiten eingebaut.
   -- Erste Version der Tesorahngebäude eingebaut.
   -- Forschungsanforderungen in ein Enum umgewandelt.
   -- Interne Benennung überarbeitet.
   -- Interne Struktur überarbeitet.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.04.0085 => 0.04.0110 (24.09.2022):
   
   -- Weiter am Forschungsbaum der Tesorahn gearbeitet.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.0000 => 0.04.0085 (23.09.2022):
   
   -- Seitenleiste leicht überarbeitet.
   -- Es ist jetzt möglich alle Datenbanken auf den Standard zurückzusetzen.
   -- Es ist jetzt wieder möglich die Standarddatenbanken als externe Datei zu speichern.
   -- Änderungen an den Datenbanken vorgenommen um sie später besser Editieren zu können.
   -- Ein Grundgerüst für die Datenbankeditoren eingebaut.
   -- Angefangen eine erste Version für den Kartengrundeditor einzubauen.
   -- Angefangen den Forschungsbaum der Tesorahn zu erstellen.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.03.9850 => 0.04.0000 (22.09.2022):
   
   -- Debian GNAT 12.2.0-2 auf Debian GNAT 12.2.0-3 aktualisiert.
   -- Aufbau des Forschungsmenüs angepasst.
   -- Fehler in der Ermittlung der Sichtbarkeit korrigiert, welcher verhinderte dass die UnterflächenSpezies die Karten aufgedeckt bekamen.
   -- Diverse Berechnungen mit zusätzlichen Prüfungen versehen, um Fehlberechnungen und Programmstopps zu verhindern.
   -- Bestimmung der Mausposition und dem Vergleichen mit Viewbereichen überarbeitet.
   -- Probleme die bei sehr niedrigen Fensterauflösungen autraten behoben.
   -- Aufbau diverser Menüs leicht überarbeitet.
   -- Textskalierung verbessert.
   -- Sollte man das Fenster verlassen, auf die Befehlsknöpfe oder die Seitenleiste mit der Maus gehen wird jetzt die Karten nicht mehr gescrollt.
   -- Seitenleisteninformationen kürzer und übersichtlicher gestaltet.
   -- Einige Fehler die Aufgrund der letzten Änderungen entstanden korrigiert.
   -- Neue Beispielbilder erstellt.
   -- Contarcts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.03.9650 => 0.03.9850 (21.09.2022):
   
   -- Linuxdateien und Windowsdateien sauber voneinander getrennt und in beiden Versionen alle Dateien entsprechend angepasst.
   -- Skalierung und Positionierung der Seitenleisteninformationen überarbeitet, ist jetzt deutlich einheitlicher.
   -- Wenn sich der aktuelle Grund und der Basisgrund unterscheiden, dann ist der aktuelle Grund jetzt auch leicht durchsichtig.
   -- Anzeige des Städtenamens über der Stadt skaliert jetzt mit der Zoomeinstellung.
   -- Angefangen eine KIPrüfung für vorhandene Transporter einzubauen.
   -- Es ist jetzt möglich eigene Einheiten die Plätze tauschen zu lassen.
   -- Fehler korrigiert der es einem erlaubten nicht vorhandene Einheit in einem Transporter anzuwählen.
   -- Die Sichtbarkeitsprüfung berücksichtigt jetzt auch die EAchse und deckt entsprechend auf.
   -- Einige Optimierungen durchgeführt.
   -- Prüfung ob die Vorraussetzungen für ein Gebäude erfüllt sind überarbeitet.
   -- Gebäude können jetzt auch Verbesserungen oder andere Gebäude vorraussetzen.
   -- Die notwendigen Technolgien zum Bauen von Wegen und Verbesserungen werden jetzt auch in der Forschungsdatenbank gespeichert und eingelesen.
   -- Unnötige Code gelöscht.
   -- Code zusammengeführt.
   -- Die notwendigen Technologien für die Bestimmung der Stadtumgebung ist jetzt auch Teil der Forschungsdatenbank und kann jetzt auch leer und nicht vorhanden sein.
   -- Sichtweite und Bewegungsfeld können jetzt auch basierend auf dem Seitenverhältnis berechnet werden.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/verbessert.
   
   

   -- Version 0.03.9495 => 0.03.9650 (20.09.2022):
   
   -- An einer Windowsversion auf Basis der A/C/SFML gearbeitet.
   -- Liste zum Laden/Speichern der vorhandenen Spielstände fertig eingebaut.
   -- Speichern/Laden an das neue Listensystem angepasst.
   -- Es wird jetzt auch die Erstellzeit der Spielstände angezeigt.
   -- Speichern/Laden an die letzten Spieländerungen angepasst.
   -- Neues Spielstandsystem vollständig eingebaut.
   -- Bei Änderungen der Kartengröße werden jetzt alle davon abhängigen Werte angepasst.
   -- Zahlreiche veraltete Kommentare, Erinnerungen, Hinweise und Notizen korrigiert/angepasst/entfernt.
   -- Unnötigen Code gelöscht.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.03.9395 => 0.03.9495 (19.09.2022):
   
   -- Warnmeldungen überarbeitet.
   -- Fehlermeldungen überarbeitet.
   -- Fehler in der Zahleneingabe korrigiert welcher bei der Eingabe von negativen Zahlen zu einem Absturz führte.
   -- Logikteil der Zahleneingabe überarbeitet.
   -- Das Durchgehen von Einheiten und Städten überarbeitet.
   -- Unnötigen Code gelöscht.
   -- Planetenzerstörerbombe in verschiedene Varianten aufgeteilt und die Planetenvernichtung um entsprechende Zusammenbruchszeit erweitert.
   -- Einstellungen in verschiedene Speicherdateien aufgeteilt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.03.9355 => 0.03.9395 (18.09.2022):
   
   -- Weiter an der Spielstandliste gearbeitet.
   -- Interne Benennung und Struktur überarbeitet.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.03.9245 => 0.03.9355 (17.09.2022):
   
   -- Es sollte jetzt alle spielrelevanten Variablen wieder auf ihr Standardwerte gesetzt werden, wenn man zurück in Hauptmenü geht.
   -- Befehlsknopf für die PZB eingebaut.
   -- Einheitenbefehlsknöpfe funktionieren jetzt fehlerfrei.
   -- Kartenbefehlsknöpfe funktionieren jetzt fehlerfrei.
   -- Texturen für die Kartenbefehlsknöpfe erstellt.
   -- Die Auswahlmöglichkeiten zum Durchgehen von Einheiten und Städten funktionieren jetzt wieder.
   -- Es ist jetzt wieder möglich Städte nach ihrem Namen zu suchen.
   -- GeheZu ist jetzt besser auf die Zielposition angepasst.
   -- Angefangen eine Spielstandliste einzubauen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.03.9185 => 0.03.9245 (16.09.2022):
   
   -- Befehlsknöpfe für Einheiten können jetzt nicht nur Text sondern auch Bilder sein.
   -- Texturen für die Einheitenbefehlsknöpfe erstellt.
   -- Angefangen Kartenbefehlsknöpfe ebenfalls als Bilder einzubauen.
   -- Angefangen Texturen für die Kartenbefehlsknöpfe zu erstellen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.03.9085 => 0.03.9185 (15.09.2022):
   
   -- Kartengenerator überarbeitet.
   -- Unnötigen Code gelöscht.
   -- Code zusammengeführt.
   -- Ladezeitberechnung und -anzeige überarbeitet.
   -- Angefangen Systemsymbole einzubauen.
   -- Textureneinlesesystem überarbeitet.
   -- Texteinlesesystem überarbeitet.
   -- Man scrollt jetzt nicht mehr wenn man sich in den Karten- und Einheitenbefehlen befindet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.03.8990 => 0.03.9085 (14.09.2022):
   
   -- Sichtbarkeit der Ebene unterhalb der aktuellen Ebene ist jetzt einstellbar.
   -- Code zusammengeführt.
   -- Unnötigen Code gelöscht.
   -- Speziesspezifisches Einlesesystem für Musik eingebaut.
   -- Einlesesystem für Sounds eingebaut.
   -- Angefangen bessere Warn- und Fehlermeldungen einzubauen.
   -- Interne Struktur des Menüsystems überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/verbessert.
   
   

   -- Version 0.03.8905 => 0.03.8990 (13.09.2022):
   
   -- Einfache Befehlsknöpfe für die Weltkarte eingebaut.
   -- Einfach Befehlsknöpfe für Einheitenbefehle eingebaut.
   -- Einige Fehler mit den neuen System korrigiert, die zu Systemstopps führen konnten.
   -- Kampfrelevante Datentypen besser aufgeteilt.
   -- Grafikoption eingebaut die den Wechsel zwischen Texturen und einfachen Rechtecken zulässt.
   -- Angefangen die RückgabeDatentype zu überarbeiten und zu verkleinern.
   -- Constracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/entfernt.
   
   

   -- Version 0.03.8855 => 0.03.8905 (12.09.2022):
   
   -- Interne Struktur und Benennung überarbeitet.
   -- Angefangen Befehlsknöpfe für die Weltkarte einzubauen.
   -- Weiter an den Befehlsknöpfen für Einheitenbefehle zu arbeiten.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.03.8830 => 0.03.8855 (11.09.2022):
   
   -- Interne Struktur und Benennung überarbeitet.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.03.8805 => 0.03.8830 (10.09.2022):
   
   -- Interne Struktur und Benennung überarbeitet.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.03.8725 => 0.03.8805 (09.09.2022):
   
   -- Diverse Fehler die zu Abstürzen führten und durch Einbau/Änderung von Funktionen in letzter Zeit auftraten behoben.
   -- Angefangern weitere Lese/Schreibeprüfungen einzubauen um so die zukünftige Modifizierbarkeit zu erhöhen.
   -- System zur Überprüfung und Konsequenzermittlung für belegte und besiegte Spezies erweitert.
   -- Der Kartengenerator berücksichtigt jetzt wieder die Kartenarteinstellung des Nutzers.
   -- Planetenvernichtung eingebaut.
   -- Angefangen die Maussteuerung von Einheiten besser an die SFML anzupassen und zu erweitern.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.03.8600 => 0.03.8725 (08.09.2022):
   
   -- Stadtbefehle existieren jetzt als auswählbare Texte.
   -- Erstkontakt mit einer Spezies wird jetzt auch hergesetllt wenn man Land in ihren Grenzen sieht.
   -- Texteingaben können jetzt auch mit der rechten Muastaste abgebrochen werden.
   -- Fehler behoben der dazu führen konnte das beim Entfernen einer Einheit es zu einem Absturz kam.
   -- Fehler behoben der beim bauen einer Farm auf Küstengrund zu einem Absturz führte.
   -- Veralteten Code gelöscht.
   -- Code zusammengeführt.
   -- Verkaufsmenü eingebaut.
   -- Neue Beispielbilder erstellt.
   -- Interne Struktur überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/optimiert.
   
   

   -- Version 0.03.8435 => 0.03.8600 (07.09.2022):
   
   -- Textanzeige und Skalierung des Baumenüs verbessert.
   -- Textanzeige und Skalierung des Diplomatiemenüs verbessert.
   -- Bei mehreren menschlichen Spielern wird die Spezies jetzt korrekt auf KI gesetzt oder entfernt wenn einer das Spiel verlässt.
   -- Alle Textanzeige und -skalierungssysteme überarbeitet und an den variablen Abstand angepasst.
   -- Steuerungsmenü überarbeitet.
   -- Farbfestlegung der Texte überarbeitet.
   -- Neues Zeilenumbruchsystem eingebaut.
   -- Versionsnummer wird jetzt nur noch im Hauptmenü angezeigt.
   -- Variable Spaltenbreite eingebaut.
   -- Introbild und Introabbruchmöglichkeit eingebaut.
   -- Angefangen Befehlsknöpfe für das Stadtsystem einzubauen.
   -- Unnötigen Code gelöscht.
   -- Code zusammengeführt.
   -- Performance optimiert.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst/optimiert.
   
   

   -- Version 0.03.8335 => 0.03.8435 (06.09.2022):
   
   -- gprbuild von Debian 2022.0.0-9 auf Debian 2023~20220801-3 aktualisiert.
   -- Angefangen die GitHub Projektliste zu überarbeiten.
   -- Karten- und Einheitenbewegung überarbeitet.
   -- Einfache Abspann/Gewonnenanzeige eingebaut.
   -- Das Menürückgabesystem leicht verbessert.
   -- Menüanzeige und Skalierung verbessert.
   -- Textanzeige und Skalierung der Seitenleiste verbessert.
   -- Textanzeige und Skalierung des Forschungsmenüs verbessert.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.03.8245 => 0.03.8335 (05.09.2022):
   
   -- Speziesspezifische Hintergrund-, Einheiten- und Gebäudetexturen sind jetzt möglich.
   -- Forschungserfolganzeige eingebaut.
   -- Ladezeitenanzeige leicht verbessert.
   -- Code zusammengefasst und aufgeteilt.
   -- Grafikteil der Eingabesysteme aufgeteilt.
   -- Logikteil der Eingabesysteme aufgeteilt.
   -- Zahleneingabe überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.03.8160 => 0.03.8245 (04.09.2022):
   
   -- Portierbarkeits- und Leistungstest durchgeführt.
   -- Die Ladezeitenberechnungen leicht überarbeitet.
   -- Angefangen den Kartengenerator erneut zu überarbeiten.
   -- Angefangen eine Anzeige für die erfolgreich erforschte Technologie einzubauen.
   -- Interne Struktur überarbeitet.
   -- Interne Benennung überarbeitet.
   -- Unnötigen Code gelöscht.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.03.8090 => 0.03.8160 (03.09.2022):
   
   -- Das Scrollsystem überarbeitet, es sollte jetzt immer der Kartenform entsprechend funktionieren.
   -- Kartenanzeige wird bei Spielstart und beim Zoomen entsprechend der aktuellen Koordinaten und der Kartenform angepasst.
   -- Debug wieder aktiviert damit die Contracts wieder funktionieren.
   -- Fehler behoben die durch die reatkivierten Contracts sichtbar wurden.
   -- Angefangen die Ladezeitenfortschritte zu überarbeiten.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet.
   
   

   -- Version 0.03.8000 => 0.03.8090 (02.09.2022):
   
   -- Einheitenkoordinaten werden jetzt für die am tiefsten verschachtelte Einheit auf der Weltkarte gespeichert um die Grafikanzeige auch bei vielen Einheiten noch schnell erfolgen zu lassen.
   -- Fehler im Bewegungssystem korrigiert, welcher dafür sorgen konnte dass die Ladung, aber nicht der Transporter auf die Zielkoordinaten verschoben wurde.
   -- Fehler bei der Auswahl von Einheiten in einem Transporter behoben, welcher zu Abstürzen führen konnt.
   -- Fehler behoben der verhinderte dass die Zoomeinstellungen korrekt zurückgesetzt wurden.
   -- Unnötigen Code gelöscht.
   -- Scrollverzögerung eingebaut.
   -- Das Scrollsystem in das neue Viewsystem eingebaut.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.03.7935 => 0.03.8000 (01.09.2022):
   
   -- Felderbewertung optimiert.
   -- Kartenkoordinatenberechnungssystem optimiert.
   -- Versucht die Einheitenkoordinaten in den WeltkarteRecord zu basteln.
   -- Interne Struktur überarbeitet.
   -- Erneut angefangen die Einheitenkoordinaten in den WeltkarteRecord zu basteln.
   -- Kommentare und Kleinigkeiten korrigiert/entfernt.

end ChangelogSeptember2022;
