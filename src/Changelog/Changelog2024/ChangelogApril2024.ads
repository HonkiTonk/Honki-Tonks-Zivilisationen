package ChangelogApril2024 is

   -- Version 0.05.6965 => 0.05.7000 (30.04.2024):
   
   -- Verzeichnisstruktur der Sounds angepasst um später leichter nutzererstellte Sounds hinzufügen zu können.
   -- Zu Testzwecken die Standardsounds ein zweites Mal eingefügt.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.6930 => 0.05.6965 (29.04.2024):
   
   -- Verzeichnisstruktur der Texturen angepasst um später leichter nutzererstellte Texturen hinzufügen zu können.
   -- Zu Testzwecken die Standardtexturen ein zweites Mal eingefügt.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.6830 => 0.05.6930 (28.04.2024):
   
   -- Weiter an Verzeichnisnamen- und Dateinamentests gearbeitet um Fehler unter verschiedenen Betriebssystemen auszuschließen.
   -- Es sollten jetzt keine Sprachen mehr zum Einlesen kommen, die die maximale Zeichenanzahl überschreiten.
   -- Datenbanken werden jetzt auch auf erlaubte Zeichenlänge geprüft.
   -- Code zusammengeführt.
   -- Sound- und Musikdateien sollten jetzt auch nicht mehr eingelesen werden, wenn der Datei/Verzeichnisname zu lang ist.
   -- Texturdateien sollten jetzt auch nicht mehr eingelesen werden, wenn der Datei/Verzeichnisname zu lang ist.
   -- Spielereinstellungen sollten jetzt auch nicht mehr eingelesen werden, wenn der Datei/Verzeichnisname zu lang ist.
   -- Festgestellt dass die Datei/Verzeichnisprüfung Müll ist.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.05.6785 => 0.05.6830 (27.04.2024):
   
   -- Fehler korrigiert der es ermöglichte Texturen über dem maximalen Texturenlimit einzulesen.
   -- Weiter an Verzeichnisnamen- und Dateinamentests gearbeitet um Fehler unter verschiedenen Betriebssystemen auszuschließen.
   -- Es sollten jetzt keine Sprachdateien mit einem zu langen Namen/Verzeichnis mehr eingelesen werden.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.6705 => 0.05.6785 (26.04.2024):
   
   -- gpr-Dateien angepasst.
   -- Diagnosesystem erweitert.
   -- Projekteinstellungen überarbeitet damit es später leichter sein sollte weitere Betriebssysteme hinzuzufügen.
   -- Angefangen Verzeichnisnamen- und Dateinamentests zu überarbeiten um Fehler unter verschiedenen Betriebssystemen auszuschließen.
   -- Unnötige Dateien gelöscht.
   -- Code zusammengeführt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/erweitert.
   
   

   -- Version 0.05.6680 => 0.05.6705 (25.04.2024):
   
   -- GNAT 13 aktualisiert.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.6590 => 0.05.6680 (24.04.2024):
   
   -- Angefangen die Textverwaltung so umzubauen das die Standardwerte für alle Texte schon beim Starten des Spiels gesetzt werden.
   -- Fehler korrigiert, der bei der Verwendung von mehreren Fonts zu extremen Speicherverbrauch führen konnte.
   -- Unnötigen Code gelöscht.
   -- Code zusammengeführt.
   -- Fehler korrigiert der zur fehlerhaften Anzeige der Spezienbeschreibungen führte.
   -- Fehler korrigiert der bei der Kartenformauswahl zu Abstürzen führte.
   -- Fehler in den Sprachdateien korrigiert.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.05.6565 => 0.05.6590 (23.04.2024):
   
   -- Unifont hinzugefügt um Sprachen anzeigen zu können, die wqy-microhei nicht darstellen kann.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.6540 => 0.05.6565 (22.04.2024):
   
   -- Alte und unnötig gewordene Dateien aussortiert.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.6480 => 0.05.6540 (21.04.2024):
   
   -- Weiter am Baumenü gearbeitet.
   -- Man kann jetzt in beide Richtungen durch das Einheitenbaumenü blättern.
   -- Man kann jetzt in beide Richtungen durch das Gebäudebaumenü blättern.
   -- Diverse Zahlen in Konstante umgewandelt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.05.6410 => 0.05.6480 (20.04.2024):
   
   -- Weiter am Baumenü gearbeitet.
   -- Die Einheitenauswahl im Baumenü ist jetzt mehrseitig.
   -- Es sollte jetzt einfacher möglich sein weitere Kategorien zum Baumenü hinzuzufügen.
   -- Code zusammengeführt.
   -- Festlegen der Textaccesse erweitert.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.05.6385 => 0.05.6410 (19.04.2024):
   
   -- Zu Testzwecken Arabisch als Sprache hinzugefügt.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.6335 => 0.05.6385 (18.04.2024):
   
   -- Weiter am mehrseitigen Baumenü gearbeitet.
   -- Festlegen der Textaccesse erweitert.
   -- Die Gebäudeauswahl im Baumenü hat jetzt mehrere Seiten.
   -- Contracts, Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.05.6300 => 0.05.6335 (17.04.2024):
   
   -- Wieder einmal mit Fonts herumexperimentiert.
   -- Unifont scheint mit dem Rahmen um den Text ordentlich lesbar zu sein und kann auch mehr Sprachen, sieht aber nicht so gut aus.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.6260 => 0.05.6300 (16.04.2024):
   
   -- Die Bauprojektart in ein Enum gepackt und alles daran angepasst.
   -- Weiter am mehrseitigen Baumenü gearbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.05.6235 => 0.05.6260 (15.04.2024):
   
   -- Sprachdateien erweitert.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.6200 => 0.05.6235 (14.04.2024):
   
   -- Anpassungen vorgenommen um den Code bei Veränderungen flexibler zu halten.
   -- Angefangen die Menüsystem auf Mehrseitigkeit umzubauen.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.05.6120 => 0.05.6200 (13.04.2024):
   
   -- Das neue Baumenü fertiggestellt.
   -- Getestet ob man verschiedene Views zusammenführen kann, scheint zu funktionieren stellt sich nur die Frage ob das auch sinnvoll ist.
   -- Fehlerhafte Anzeige im Verkaufsmenü behoben.
   -- Code zusammengefüht.
   -- Die Anzeige in der Stadtkartenkarte entspricht jetzt der Anzeige im Bau- und Verkaufsmenü.
   -- Angefangen die Anzahl an Auswahlmöglichkeiten in Menüs, beim Überschreiten einer bestimmten Anzahl von Elementen, auf mehrere Seiten zu verteilen.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.05.6120 => 0.05.6120 (12.04.2024):
   
   -- null.
   
   

   -- Version 0.05.6100 => 0.05.6120 (11.04.2024):
   
   -- Mit dem Erstellen eines Debianpakets herumexperimentiert.
   
   

   -- Version 0.05.6070 => 0.05.6100 (10.04.2024):
   
   -- VMs neu installiert und weitere Testumgebungen hinzugefügt.
   -- Backupsystem endlich automatisiert.
   
   

   -- Version 0.05.6070 => 0.05.6070 (09.04.2024):
   
   -- null.
   
   

   -- Version 0.05.6070 => 0.05.6070 (08.04.2024):
   
   -- null.
   
   

   -- Version 0.05.6015 => 0.05.6070 (07.04.2024):
   
   -- ASFML auf die stabile Version 2.5.5 aktualisiert.
   -- Lokale SFML Version 2.5.1 auf Version 2.6.1 aktualisiert.
   -- Lokale CSFML Version 2.5-1.1 auf Version 2.6.0-3 aktualisiert.
   -- Nach diversen Tests scheint alles mit Version 2.5 und mit Version 2.6 zu funktionieren.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.5980 => 0.05.6015 (06.04.2024):
   
   -- Das Baumenü angefangen zu überarbeiten.
   -- Code zusammengeführt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.5980 => 0.05.5980 (05.04.2024):
   
   -- Warum will GNAT-14 denn nicht?
   
   

   -- Version 0.05.5980 => 0.05.5980 (04.04.2024):
   
   -- null.
   
   

   -- Version 0.05.5980 => 0.05.5980 (03.04.2024):
   
   -- null.
   
   

   -- Version 0.05.5980 => 0.05.5980 (02.04.2024):
   
   -- null.
   
   

   -- Version 0.05.5930 => 0.05.5980 (01.04.2024):
   
   -- Tastatureingabesystem leicht überarbeitet.
   -- Angefangen eine Einstellung einzubauen mit denen man Sicherheitsabfragen deaktivieren kann.
   -- Übersetzung überarbeitet.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.

end ChangelogApril2024;
