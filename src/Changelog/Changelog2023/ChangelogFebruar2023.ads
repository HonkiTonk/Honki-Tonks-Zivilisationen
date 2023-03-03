package ChangelogVorlage is
  
   -- Version 0.04.8090 => 0.04.8190 (28.02.2023):
   
   -- Einfachen Menüklicksound eingebaut.
   -- Soundsystem erweitert um die Wiedergabe von Sounds besser zu koordinieren und zu verwalten.
   -- Einfachen Bewegungssound eingebaut.
   -- Starteinstellungen für Sound und Musik eingebaut.
   -- Die Einstellungen für den Sound und die Musik werden jetzt erst vorgenommen nachdem alle Dateien entsprechend eingelesen wurden.
   -- Angefangen das Optionsmenü für die Toneinstellungen zu erweitern.
   -- Fehler im Grafikmenü korrigiert, welcher die Änderung der Bildrate unmöglich machte.
   -- Es ist jetzt möglich die Sound- und Musiklautstärke im Menü zu ändern.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/erweitert.
   
   

   -- Version 0.04.8065 => 0.04.8090 (27.02.2023):
   
   -- Fehler korrigiert der zu überlappenden Text bei der Sprachauswahl führte.
   -- Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.8065 => 0.04.8065 (26.02.2023):
   
   -- null.
   
   

   -- Version 0.04.8065 => 0.04.8065 (25.02.2023):
   
   -- null.
   
   

   -- Version 0.04.8065 => 0.04.8065 (24.02.2023):
   
   -- null.
   
   

   -- Version 0.04.8065 => 0.04.8065 (23.02.2023):
   
   -- null.
   
   

   -- Version 0.04.8040 => 0.04.8065 (22.02.2023):
   
   -- Soundordner hinzugefügt.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.8005 => 0.04.8040 (21.02.2023):
   
   -- Soundsystem erweitert um endlich Sounds verwenden zu können.
   -- Das Festlegen der Sounds und Soundaccesse überarbeitet und erweitert.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.7890 => 0.04.8005 (20.02.2023):
   
   -- Bei der Sprachauswahl werden jetzt keine Verzeichnisse mehr angezeigt bei denen die 0-Datei fehlt.
   -- Fehlermeldungen erweitert.
   -- Diagnosesystem erweitert.
   -- Dateien die kleiner sind als die kleinstmögliche Speicherdatei werden jetzt nicht mehr als ladbarere Spielstände angezeigt.
   -- Dateien die größer sind als die größtmögliche Speicherdatei werden jetzt nicht mehr als ladbarere Spielstände angezeigt.
   -- Variable Berechnung für die Ermittlung eines bestimmten Bereiches einer Textur eingebaut.
   -- Konstante Berechnung für die Ermittlung eines bestimmten Bereiches einer Textur, welche aus 32x32 großen Feldern besteht, eingebaut.
   -- Diverse weitere Texturberechnung eingebaut.
   -- Die Anzeige der vorhandenen Spielstandliste skaliert die Namen der Spielstände jetzt einzeln anstatt alle auf einmal.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/verschoben.
   
   

   -- Version 0.04.7890 => 0.04.7890 (19.02.2023):
   
   -- null.
   
   

   -- Version 0.04.7815 => 0.04.7890 (18.02.2023):
   
   -- Einlesen der Datenbanken überarbeitet, so dass veraltete/fehlerhafte Werte nicht mehr eingelesen werden und zu einem Programmstopp führen, sondern einfach die Standardwerte verwendet werden.
   -- Fehler in den Verzeichnispfaden korrigiert, welcher zum falschen Überschreiben von Daten führen konnte.
   -- Schreiben der Datenbanken an das Einlesen angepasst.
   -- Fehlermeldungen erweitert.
   -- Fehler beim Einlesen der Musik korrigiert.
   -- Bei der Auswahl der Sprachen werden jetzt keine leeren Verzeichnisse mehr angezeigt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.7745 => 0.04.7815 (17.02.2023):
   
   -- Fehler korrigiert der zu einem Stopp führen konnte wenn man das Mausrad außerhalb der Weltkarte drehte.
   -- Weitere Zugriffsdateien erstellt, um den Zugriff auf diverse Variablen durch diese zu beschränken.
   -- Direkten Variablenzugriff durch die Zugriffsdateien ausgetauscht.
   -- Einlesen der Tastenbelegung überarbeitet, so dass veraltete/fehlerhafte Werte nicht mehr eingelesen werden und zu einem Programmstopp führen, sondern einfach die Standardwerte verwendet werden.
   -- Angefangen das Einlesen der Datenbanken zu überarbeiten.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.7610 => 0.04.7745 (16.02.2023):
   
   -- Weitere Zugriffsdateien erstellt, um den Zugriff auf diverse Variablen durch diese zu beschränken.
   -- Einlesen der Nutzereinstellungen überarbeitet, so dass veraltete/fehlerhafte Werte nicht mehr eingelesen werden und zu einem Programmstopp führen, sondern einfach die Standardwerte verwendet werden.
   -- Fehlermeldungen werden jetzt nur noch im Terminal ausgegeben wenn die Debugvariable FehlerWarnung auf True steht.
   -- Einlesen aller gespeicherten Einstellungen überarbeitet, so dass veraltete/fehlerhafte Werte nicht mehr eingelesen werden und zu einem Programmstopp führen, sondern einfach die Standardwerte verwendet werden.
   -- Direkten Variablenzugriff durch die Zugriffsdateien ausgetauscht.
   -- Bereiche sinnvoller aufgeteilt.
   -- Hintergund mit beliebiger Anzeigeposition eingebaut.
   -- Alle Stadtnamen werden jetzt auf einen durchsichtigen Hintergrund geschrieben und sollte so unabhängig vom Grund lesebar sein.
   -- Fehler korrigiert wodurch man von der maximale erlaubten Zahleneingabe auf die Null springen konnte.
   -- Code zusammengefasst.
   -- Sinnvolle Grenzwerte für die Auflösung und Bildrate eingebaut.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/zusammengefasst.
   
   

   -- Version 0.04.7585 => 0.04.7610 (15.02.2023):
   
   -- Städtenamen sollten jetzt immer korrekt über oder unter einer Stadt angezeigt werden.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.7540 => 0.04.7585 (14.02.2023):
   
   -- Einfaches Textskalierungssystem eingebaut.
   -- Anzeige der Städtenamen auf der Weltkarte überarbeitet.
   -- Code zusammengeführt.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.7540 => 0.04.7540 (13.02.2023):
   
   -- null.
   
   

   -- Version 0.04.7475 => 0.04.7540 (12.02.2023):
   
   -- Interne Struktur der Spielstandliste überarbeitet.
   -- Sprachenauswahl überarbeitet.
   -- Konvexverwaltungssystem eingebaut.
   -- Stadtkartenanzeigesystem überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/überarbeitet/getestet/angepasst.
   
   

   -- Version 0.04.7475 => 0.04.7475 (11.02.2023):
   
   -- null.
   
   

   -- Version 0.04.7415 => 0.04.7475 (10.02.2023):
   
   -- Berechnung der Kartenkoordinaten überarbeitet.
   -- Es werden jetzt keine Spielstände mehr angezeigt die einen ungültigen Namen haben.
   -- Fehler korrigiert wodurch es möglich war zu lange Spielstandsnamen einzugeben.
   -- Texte können jetzt variable aber konstante Abstände zwischen den Zeilen haben.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/erweitert/zusammengeführt.
   
   

   -- Version 0.04.7415 => 0.04.7415 (09.02.2023):
   
   -- null.
   
   

   -- Version 0.04.7405 => 0.04.7415 (08.02.2023):
   
   -- Kompilerfehler? gesucht und gefunden?
   
   

   -- Version 0.04.7380 => 0.04.7405 (07.02.2023):
   
   -- Zusätzliche Prüfungen für Spielstandnamen eingebaut.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.7380 => 0.04.7380 (06.02.2023):
   
   -- nuĺl.
   
   

   -- Version 0.04.7320 => 0.04.7380 (05.02.2023):
   
   -- Informationsfeld für die Stadtkarte eingebaut.
   -- Allgemeine Berechnung für Viewbereiche eingebaut.
   -- Angefangen das Stadtkarteninformationsfeld zu erweitern.
   -- Es ist jetzt auch möglich Gebäude über die Stadtkarte zu verkaufen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/erweitert/angepasst.
   
   

   -- Version 0.04.7320 => 0.04.7320 (04.02.2023):
   
   -- null.
   
   

   -- Version 0.04.7275 => 0.04.7320 (03.02.2023):
   
   -- Feldeffekte haben jetzt auch Auswirkungen auf die Arbeitszeit von Siedlern.
   -- Code zusammengeführt.
   -- Angefangen Zusatzinformationen für die Stadtkarte einzubauen.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.04.7230 => 0.04.7275 (02.02.2023):
   
   -- Codeformatierung leicht überarbeitet.
   -- Neue Versionen für GitHub erstellt.
   -- Neue Version bei Alire hinzugefügt.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.04.7120 => 0.04.7230 (01.02.2023):
   
   -- Arbeiterplatzierungssystem überarbeitet.
   -- Anzeigesystem der Stadtumgebung überarbeitet.
   -- Fehler korrigiert der zu einer falschen Skalierung der Feldproduktionstexte führen konnte.
   -- Spritesverwaltungssystem eingebaut um ähnlich dem Textaccessverwaltungssystem eine bessere Zusammenführung gleicher Tätigkeiten zu erreichen.
   -- Tests für ein besseres Speichersystem durchgeführt.
   -- Kartengrößen sind jetzt Brüche der maximal möglichen Kartengröße.
   -- Einheiten können jetzt nicht nur verschiedene Effekte erzeugen, es ist jetzt auch möglich verschiedene Bereiche für die jeweiligen Effekte festzulegen.
   -- Effektbereiche der PZB sind jetzt Bruchteile der maximalen Kartengröße anstatt von festgelegten Zahlenwerten.
   -- Diverse Zahlen durch benannte Konstante ersetzt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.

end ChangelogVorlage;
