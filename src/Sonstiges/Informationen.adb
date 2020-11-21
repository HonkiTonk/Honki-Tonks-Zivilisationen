package body Informationen is

   procedure Informationen is
   begin
      
      Put_Line (Item => "Aktuelle Version:");
      Put_Line (Item => Versionsnummer);
      New_Line;

      Put_Line (Item => "Wichtiges/Notizen:");
      Put_Line (Item => "-1 = Spiel beenden, 0 = Hauptmenü, -2 = Zurück, -3 = Ja, -4 = Nein, 2 = Speichern, 3 = Laden");
      Put_Line (Item => "Gebäude haben immer die Nummer 1_000 + ihren Datenbankwert, Einheiten haben immer die Nummer 10_000 + ihren Datenbankwert.");
      Put_Line (Item => "In der Übergabe immer StadtNummer oder EinheitNummer verwenden.");
      Put_line (Item => "Nicht über das Array selbst loopen, da bei Aufteilung es zu Problemen kommen kann.");
      Put_line (Item => "Für Rassen im Spiel gilt: 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI.");
      New_Line;

      Put_Line (Item => "Das nächste Mal zu tun:");
      Put_Line (Item => "Dingsbums für Prozeduren/Funktionen einbauen.");
      Put_Line (Item => "Mehr eigene Datentypen einbauen.");
      Put_Line (Item => "Textanzeige endlich mal ordentlich umbauen.");
      New_Line;

      Put_Line (Item => "Zeug:");
      Put_Line (Item => "In SpielEinstellungen noch eine Abstandsprüfung zu anderen Rassen einbauen? Schwierig bei kleiner Karte aber großer Spieleranzahl.");
      Put_Line (Item => "Bessere Lösung für Sortieren finden. Funktioniert die reverse Loop Idee doch, wenn im Bewegungssystem die Gewonnenprüfung am Anfang drin ist?");
      Put_Line (Item => "Die Straßenberechnung funktioniert nicht einmal richtig. Außerdem mal über ein Einzelstück nachdenken.");
      Put_Line (Item => "GlobaleVariablen.TexteEinlesen über eigene Procedure aufrufen und immer nur die Nummern übergeben, so muss ich bei einer Änderung immer alles ändern und nicht nur eine Procedure in einer Datei!");
      Put_Line (Item => "Siehe angelegte Procedure in der Ausgabe.adb.");
      Put_Line (Item => "Bei der Festlegung der Startpositionen nochmal nachbessern, vor allem bei einer kleinen Karte ein Problem.");
      Put_Line (Item => "Entfernung einer Rasse in das Kampfsystem schieben. Was ist überhaupt mit dem Angriff von Städten?");
      Put_Line (Item => "Kartengenerator verbessern und erweitern!");
      Put_Line (Item => "Gebäuden und Forschungen eine Bedeutung geben.");
      Put_Line (Item => "Grundlegende Systeme (z. B. Anzeige von Texten) verbessern.");
      Put_Line (Item => "Straßen/FlußBerechnung endlich ansehbar machen.");
      Put_Line (Item => "Datem und Uhrzeit bei der Benennung des Spielstandes nutzen.");
      Put_Line (Item => "Auf eigene Datentypen umschreiben. Verbinden mit dem Einbauen richtiger Grafik?");
      Put_Line (Item => "Speichern/Laden wieder funktionierend einbauen.");
      Put_Line (Item => "Wenn Hardcoded wie die Werte, dann funktioniert es mit einer Sprache ohne die Dateien zum Einlesen");
      New_Line;

      Put_Line (Item => "Mal drüber nachdenken:");
      Put_Line (Item => "Die Anzeigen für Bauen und Forschen zusammenfassen und generell das Anzeigesystem verbessern.");
      Put_Line (Item => "FarbenStadt rauswerfen, nach Sichtbarkeit verschieben? Nutzen um die Gebäudefarben festzulegen?");
      Put_Line (Item => "Ausgabe überall wo möglich einbauen, Cursoranzeige und CSI Leerung auslagern?");
      Put_Line (Item => "Umgebungsgröße einer Stadt mit in meinen Stadtrecord?");
      New_Line;

      Put_Line (Item => "Grafik:");
      Put_Line (Item => "Cursoranzeige in eine eigene Prozedur? Dann müssten auch Farbänderungen für den Untergrund leicht möglich sein.");
      New_Line;

      Put_Line (Item => "Bausystem:");
      Put_Line (Item => "Später noch die Abfrage/Anzeige beim Bauen erweitern, so dass nicht nur Seeeinheiten geprüft werden, sondern auch Gebäude, z. B. Hafen, Flughafen usw..");
      New_Line;

      Put_Line (Item => "GlobaleVariablen:");
      Put_Line (Item => "Verteidigungsbonus der Städte mit in die GlobalenVeriablen schieben?");
      New_Line;

      Put_Line (Item => "Verbesserungen/Flüsse:");
      Put_Line (Item => "Logik zur Verbindung angrenzender Straßen/Flüsse verbessern.");
      New_Line;
      
      Put_Line (Item => "BefehleImSpiel:");
      Put_Line (Item => "Informationsaufruf einbauen.");
      New_Line;
      
      Put_Line (Item => "Kartengenerator:");
      Put_Line (Item => "Bodenart so generieren wie aktuell die Landmassen, nur mit kleinerem Radius.");
      Put_Line (Item => "Generator für nur Land einbauen.");
      Put_Line (Item => "Generator für Chaos einbauen.");
      Put_Line (Item => "Generator für Oberfläche einbauen!");
      Put_Line (Item => "Generatorwerte optimieren.");

      Put_Line (Item => "Für Hitze ein System ähnlich wie für Inselns/Kontinente einbauen!");
      Put_Line (Item => "Generell den Generator so umschreiben das auch die Wahrscheinlichkeit für Land/Wasser komplett so funktioniert!");
      Put_Line (Item => "Das System auch für Flüsse einbauen!");
      Put_Line (Item => "Zwischen Küsten und Seen unterscheiden?");
      New_Line;

      Put_Line (Item => "SpielEinstellungen;");
      Put_Line (Item => "Die Festlegung der Starteinheiten in die EinheitenDatenbank verschieben?");
      New_Line;

      Put_Line (Item => "Karte:");
      New_Line;
      
      Put_Line (Item => "Bewegungssystem:");
      Put_Line (Item => "Befehl und System für automatisches bewegen einbauen.");
      Put_Line (Item => "Tauschen für eigenen Einheiten einbauen, wenn beide genügend Bewegungspunkte haben?");
      New_Line;

      Put_Line (Item => "Einheiten:");
      Put_Line (Item => "Transporteinheiten?");
      Put_Line (Item => "Eigenschaften/Funktionen erweitern.");
      New_Line;
      
      Put_Line (Item => "Einheiten/VerbesserungenDatenbank:");
      Put_Line (Item => "Bei Einheiten die Beschreibung und bei Verbesserungen die Befehlssetzung?");
      New_Line;
      
      Put_Line (Item => "Stadtsystem:");
      Put_Line (Item => "Erweitern.");
      New_Line;
      
      Put_Line (Item => "Forschungssystem:");
      Put_Line (Item => "Erweitern.");
      Put_Line (Item => "Für jede Rasse einen eigenen Forschungsbaum.");
      New_Line;
      
      Put_Line (Item => "Kampfsystem:");
      Put_Line (Item => "Verbessern.");
      Put_Line (Item => "Zwischen Nahkampf und Fernkampf unterscheiden.");
      Put_Line (Item => "Angriff zwischen Boden/See/Lufteinheiten unterscheiden.");
      New_Line;
      
      Put_Line (Item => "Diverses:");
      Put_Line (Item => "Bei Hügel mit Grund werden die Werte für den Grund genommen und die Werte für Hügel ignoriert. Das nochmal überdenken.");
      Put_Line (Item => "Generatorzuweisung nochmal schauen was die richtigen Standardzuweisungen sind.");
      New_Line;
      
      Put_Line (Item => "Einlesen:");
      Put_Line (Item => "Alle Werte auch aus Dateien einlesen? Wenn man die wieder über eine WasEinzulesenIst Datei einlädt, dann könnte man die Werte einfach austauschen ohne in den Hauptdateien rumpfuschen zu müssen.");
      New_Line;

      Put_Line (Item => "Auswahl:");
      Put_Line (Item => "Noch q als Verlassentaste in die Systeme mit einbauen?");
      New_Line;

      Put_Line (Item => "AllesAufAnfangSetzen:");
      Put_Line (Item => "Die einzelnen Bereiche in Tasks einteilen?");
      New_Line;
      
      Put_Line (Item => "Speichern/Laden:");
      Put_Line (Item => "Verbessern.");
      Put_Line (Item => "Sicherheitsabfrage und Anzeige der vorhandenen Spielstände mit einbauen.");
      Put_Line (Item => "Dateien müssen zum überschreiben nicht gelöscht werden.");
      New_Line;

      Put_Line (Item => "KI:");
      Put_Line (Item => "Einbauen! Wird bestimmt einfach und lustig.");
      New_Line;
      
      Put_Line (Item => "Taste drücken um zurück ins Hauptmenü zu kommen.");
      Get_Immediate (Item => Taste);
      
   end Informationen;

end Informationen;
