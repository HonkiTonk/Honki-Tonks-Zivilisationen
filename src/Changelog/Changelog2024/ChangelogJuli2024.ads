package ChangelogJuli2024 is
   pragma Pure;
   
   -- Version 0.05.8745 => 0.05.8770. (31.07.2024):
   
   -- Weiter die Senkrechte und Waagerechte in zwei verschiedene Datentypen aufgeteilt.
   -- Contracts und Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.8720 => 0.05.8745 (30.07.2024):
   
   -- Angefangen Programmteile in eigene Bibliotheken auszulagern.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.8695 => 0.05.8720 (29.07.2024):
   
   -- GNAT aktualisiert.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.8680 => 0.05.8695 (28.07.2024):
   
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.8630 => 0.05.8680 (27.07.2024):
   
   -- Unnötigen Code gelöscht.
   -- Angefangen Senkrechte und Waagerechte in zwei verschiedene Datentypen aufzuteilen.
   -- Interne Benennung überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.05.8605 => 0.05.8630 (26.07.2024):
   
   -- Die Übersetzungen an die letzten Änderungen angepasst.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.8545 => 0.05.8605 (25.07.2024):
   
   -- Texturnamen geändert, da Windows Probleme mit Sonderzeichen hat.
   -- Angefangen die Auswahl für verschiedene Texturenpacks einzubauen.
   -- Es ist jetzt möglich zwischen verschiedenen Texturen zu wechseln.
   -- Memoryleak bei der Texturenauswahl entfernt.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet.
   
   

   -- Version 0.05.8520 => 0.05.8545 (24.07.2024):
   
   -- Standardprojekteinstellungen auf alle Projekteinstellungsvarianten erweitert. 
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.8425 => 0.05.8520 (23.07.2024):
   
   -- Projekteinstellungen erweitert.
   -- Neue Grafiken für den Hintergrund erstellt.
   -- Alte Grafiken überarbeitet.
   -- Weiter am neuen Texturenanzeigesystem gearbeitet.
   -- Code zusammengeführt.
   -- Unnötigen Code gelöscht.
   -- Fehler korrigiert der dafür sorgte das in einer Stadt die Umgebung keine Flüsse anzeigte.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/überarbeitet/erweitert.
   
   

   -- Version 0.05.8400 => 0.05.8425 (22.07.2024):
   
   -- Interne Struktur vereinheitlicht.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.8375 => 0.05.8400 (21.07.2024):
   
   -- Weiter am neuen Anzeigesystem für die Texturen gearbeitet.
   -- Kommentare und Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.8340 => 0.05.8375 (20.07.2024):
   
   -- Weiter das Einlese- und Dateinamenumwandlungssystem gearbeitet in der Hoffnung Sonderzeichen auch unter Windows korrekt benutzen zu können.
   -- Weiter am neuen Anzeigesystem für die Texturen gearbeitet.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.05.8315 => 0.05.8340 (19.07.2024):
   
   -- GNAT aktualisiert.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.8280 => 0.05.8315 (18.07.2024):
   
   -- gpr Dateien überarbeitet.
   -- Die Spielverzeichnisse für Linux und Windows zusammengeführt.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.8220 => 0.05.8280 (17.07.2024):
   
   -- MeldungssystemHTSEB überarbeitet.
   -- Unnötigen Code gelöscht.
   -- Code zusammengefasst.
   -- Weiter an einem Einlesesystem für verschiedene Betriebssysteme gearbeitet.
   -- Contracts, Kommenate und Kleinigkeiten korrigiert/erweitert.
   
   

   -- Version 0.05.8195 => 0.05.8220 (16.07.2024):
   
   -- GNAT aktualisiert.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.8145 => 0.05.8195 (15.07.2024):
   
   -- Angefangen eine Lösung für das Sonderzeichenproblem unter Windows zu bauen.
   -- Eigene Version von Decode angelegt und überall eingebaut um Texte Betriebssystemabhängig konvertieren zu können.
   -- Eigene Version von Encode angelegt und überall eingebaut um Texte Betriebssystemabhängig konvertieren zu können.
   -- Kommentare und Kleinigkeiten korrigiert/überarbeitet/angepasst.
   
   

   -- Version 0.05.8120 => 0.05.8145 (14.07.2024):
   
   -- Alire Pragmas an die Standard Pragmas angepasst.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.8075 => 0.05.8120 (13.07.2024):
   
   -- GNAT Studio wieder auf Version 2021 zurückgesetzt.
   -- Windowsversion von GNAT Studio aktualisiert.
   -- Windows GNAT aktualisiert.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.8040 => 0.05.8075 (12.07.2024):
   
   -- GNAT Studio aktualisiert.
   -- Ada 2022 als neuen Standard festgelegt.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.8010 => 0.05.8040 (11.07.2024):
   
   -- Die korrekten ISO Codes für die Standardsprachen eingefügt.
   -- Wenn die Systemsprache einer der Standardsprachen entspricht, dann sollte jetzt automatisch die Systemsprache beim ersten Start als Sprache ausgewählt werden.
   
   

   -- Version 0.05.7965 => 0.05.8010 (10.07.2024):
   
   -- Diagnosesystem erweitert.
   -- Angefangen Ada.Locale für die Erstauswahl der Sprache einzubauen.
   -- Angefangen Standardwerte für die Standardsprachen einzubauen.
   -- Kommentare und Kleinigkeiten korrigiert/angepasst.
   
   

   -- Version 0.05.7940 => 0.05.7965 (09.07.2024):
   
   -- GNAT aktualisiert.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.7915 => 0.05.7940 (08.07.2024):
   
   -- GNAT aktualisiert.
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.7855 => 0.05.7915 (07.07.2024):
   
   -- Unnötigen Code gelöscht.
   -- Code zusammengeführt.
   -- Weiter am neuen Texturberechnungs- und Anzeigesystem gearbeitet.
   -- Texturen überarbeitet.
   -- Contracts, Kommentare und Kleinigkeiten korrigiert/angepasst/erweitert.
   
   

   -- Version 0.05.7840 => 0.05.7855 (06.07.2024):
   
   -- Kleinigkeiten korrigiert.
   
   

   -- Version 0.05.7840 => 0.05.7840 (05.07.2024):
   
   -- null.
   
   

   -- Version 0.05.7840 => 0.05.7840 (04.07.2024):
   
   -- null.
   
   

   -- Version 0.05.7840 => 0.05.7840 (03.07.2024):
   
   -- null.
   
   

   -- Version 0.05.7840 => 0.05.7840 (02.07.2024):
   
   -- null.
   
   

   -- Version 0.05.7840 => 0.05.7840 (01.07.2024):
   
   -- null.

end ChangelogJuli2024;
