package body Informationen is

   procedure Informationen is
   begin
      
      Put_Line (Item => "Aktuelle Version:");
      Put_Line (Item => Versionsnummer);
      New_Line;

      Put_Line (Item => "Wichtiges/Notizen:");
      Put_Line (Item => "-1 = Spiel beenden, 0 = Hauptmenü, -2 = Zurück, -3 = Ja, -4 = Nein, 2 = Speichern, 3 = Laden");
      Put_Line (Item => "Gebäude haben immer die Nummer 1_000 + ihren Datenbankwert, Einheiten haben immer die Nummer 10_000 + ihren Datenbankwert.");
      New_Line;

      Put_Line (Item => "Das nächste Mal zu tun:");
      Put_Line (Item => "Die Steigerung der vorhandenen Ressource nach Wachstum verschieben und bei Bauen nur noch auf Fertigstellung prüfen.");
      Put_Line (Item => "Zeug in die Textdatei auslagern.");
      Put_Line (Item => "Überprüfung des Geldwachstums/Forschungswachstum direkt nach Bau einer Stadt prüfen lassen.");
      Put_Line (Item => "Aufdeckung prüfen, Siedler deckt gar nichts auf und andere Einheiten nur manchmal. Vermutlich ein Fehler im geänderten, mehrzügigen Bewegungssystem.");
      Put_Line (Item => "Durch Eingabe von Koordinaten auf der Karte ein Goto ermöglichen.");
      Put_Line (Item => "Prüfung der Umgebung vereinheitlichen, z. B. durch procedure in die die loop Range und der Befehl reingegeben werden? Ist das praktikabel möglich?");
      Put_Line (Item => "Forschungssystem.");
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
      Put_Line (Item => "Nochmal überarbeiten damit es nicht mehr so ein Wust ist.");
      Put_Line (Item => "Befehl und System für automatisches bewegen einbauen.");
      New_Line;

      Put_Line (Item => "Einheiten:");
      Put_Line (Item => "Eigenschaften/Funktionen einbauen!");
      Put_Line (Item => "Die Sortierfunktion Stichpunktartig prüfen ob normal oder reverse geloopt werden soll?");
      New_Line;
      
      Put_Line (Item => "Einheiten/VerbesserungenDatenbank:");
      Put_Line (Item => "Bei Einheiten die Beschreibung und bei Verbesserungen die Befehlssetzung?");
      New_Line;
      
      Put_Line (Item => "Stadtsystem:");
      Put_Line (Item => "Einbauen.");
      New_Line;
      
      Put_Line (Item => "Forschungssystem:");
      Put_Line (Item => "Einbauen.");
      Put_Line (Item => "Für jede Rasse einen eigenen Forschungsbaum?");
      New_Line;
      
      Put_Line (Item => "Kampfsystem:");
      Put_Line (Item => "Einbauen.");
      Put_Line (Item => "Zwischen Nahkampf und Fernkampf unterscheiden.");
      New_Line;
      
      Put_Line (Item => "Diverses:");
      Put_Line (Item => "Bei Hügel mit Grund werden die Werte für den Grund genommen und die Werte für Hügel ignoriert. Das nochmal überdenken.");
      Put_Line (Item => "Bei Sichtbarkeit/Karte/Einheitenbewegung/Eventuell Weiteren die Loops für die XAchse zusammenführen? Ist das überhaupt möglich ohne eine Schalterchaos einzubauen?");
      Put_Line (Item => "Generatorzuweisung nochmal schauen was die richtigen Standardzuweisungen sind.");
      New_Line;
      
      Put_Line (Item => "Einlesen:");
      Put_Line (Item => "Alle Werte auch aus Dateien einlesen? Wenn man die wieder über eine WasEinzulesenIst Datei einlädt, dann könnte man die Werte einfach austauschen ohne in den Hauptdateien rumpfuschen zu müssen.");
      New_Line;

      Put_Line (Item => "Auswahl:");
      Put_Line (Item => "Noch q als Verlassentaste in die Systeme mit einbauen?");
      New_Line;

      Put_Line (Item => "AllesAufAnfangSetzen:");
      Put_Line (Item => "Entsprechende Aktualisierung nicht vergessen.");
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
