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
      New_Line;

      Put_Line (Item => "Das nächste Mal zu tun:");
      Put_Line (Item => "Kartengenerator verbessern und erweitern!");
      Put_Line (Item => "StraßenBerechnung endlich ansehbar machen.");
      Put_Line (Item => "Speichern/Laden einbauen.");
      Put_Line (Item => "Gebäuden und Forschungen eine Bedeutung geben.");
      Put_Line (Item => "Grundlegende Systeme (z. B. Anzeige von Texten) verbessern.");
      New_Line;

      Put_Line (Item => "Zeug:");
      Put_Line (Item => "Legt erst eine Runde später die neuen Werte fest, prüfen warum (siehe auch Wachstum.WachstumBeiStadtGründung).");
      Put_line (Item => "Nicht über das Array selbst loopen, da bei Aufteilung es zu Problemen kommen kann.");
      Put_Line (Item => "Bessere Lösung für Sortieren finden. Funktioniert die reverse Loop Idee doch, wenn im Bewegungssystem die Gewonnenprüfung am Anfang drin ist?");
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
      Put_Line (Item => "Logik zur Verbindung angrenzender Straßen/Flüsse einbauen/verbessern.");
      New_Line;
      
      Put_Line (Item => "BefehleImSpiel:");
      Put_Line (Item => "Informationsaufruf einbauen.");
      New_Line;
      
      Put_Line (Item => "Kartengenerator:");
      Put_Line (Item => "Warum geht der KartenGenerator kaputt wenn ich meine Verallgemeinerung aus SchleifenPruefungen einbaue?");
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
      Put_Line (Item => "Bei Karte.AnzeigeKarte was mit der Sichtweite und SchleifenPruefungen basteln?");
      New_Line;
      
      Put_Line (Item => "Bewegungssystem:");
      Put_Line (Item => "Nochmal überarbeiten damit es nicht mehr so ein Wust ist.");
      Put_Line (Item => "Befehl und System für automatisches bewegen einbauen.");
      Put_Line (Item => "Tauschen für eigenen Einheiten einbauen, wenn beide genügend Bewegungspunkte haben?");
      New_Line;

      Put_Line (Item => "Einheiten:");
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
      Put_Line (Item => "Für jede Rasse einen eigenen Forschungsbaum?");
      New_Line;
      
      Put_Line (Item => "Kampfsystem:");
      Put_Line (Item => "Einbauen.");
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
      Put_Line (Item => "Einbauen.");
      New_Line;

      Put_Line (Item => "KI:");
      Put_Line (Item => "Einbauen! Wird bestimmt einfach und lustig.");
      New_Line;
      
      Get_Immediate (Item => Taste);
      
   end Informationen;

end Informationen;
