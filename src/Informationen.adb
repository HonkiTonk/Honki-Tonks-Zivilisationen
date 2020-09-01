package body Informationen is

   procedure Informationen is
   begin
      
      Put_Line ("Aktuelle Version:");
      Put_Line (Versionsnummer);
      New_Line;

      Put_Line ("Wichtiges/Notizen:");
      Put_Line ("-1 = Spiel beenden, 0 = Hauptmenü, -2 = Zurück, -3 = Ja, -4 = Nein, 2 = Speichern, 3 = Laden");
      New_Line;

      Put_Line ("Das nächste Mal zu tun:");
      Put_Line ("Befehle eine Nummer zuweisen, so dass eine Befehlsänderung nicht immer 1000 weitere Änderungen mit sich zieht und es möglich ist mehr Befehle zusammenzufassen.");
      Put_Line ("Stadtsystem.");
      Put_Line ("Forschungssystem?");
      New_Line;

      Put_Line ("GlobaleVariablen:");
      Put_Line ("Verteidigungsbonus der Städte mit in die GlobalenVeriablen schieben?");
      New_Line;

      Put_Line ("Verbesserungen/Flüsse:");
      Put_Line ("Logik zur Verbindung angrenzender Straßen/Flüsse einbauen/verbessern.");
      New_Line;
      
      Put_Line ("BefehleImSpiel:");
      Put_Line ("Informationsaufruf einbauen.");
      Put_Line ("Befehl und System für automatisches bewegen einbauen.");
      New_Line;
      
      Put_Line ("Kartengenerator:");
      Put_Line ("Generator für nur Land einbauen.");
      Put_Line ("Generator für Chaos einbauen.");
      Put_Line ("Generator für Oberfläche einbauen!");
      Put_Line ("Generatorwerte optimieren.");

      Put_Line ("Für Hitze ein System ähnlich wie für Inselns/Kontinente einbauen!");
      Put_Line ("Generell den Generator so umschreiben das auch die Wahrscheinlichkeit für Land/Wasser komplett so funktioniert!");
      Put_Line ("Das System auch für Flüsse einbauen!");
      Put_Line ("Zwischen Küsten und Seen unterscheiden?");
      New_Line;

      Put_Line ("SpielEinstellungen;");
      Put_Line ("Die Festlegung der Starteinheiten in die EinheitenDatenbank verschieben?");
      New_Line;

      Put_Line ("Karte:");
      Put_Line ("Für das aktuelle Bauprojekt noch ein System zur Namensanzeige korrekt einbauen.");
      New_Line;
      
      Put_Line ("Bewegungssystem:");
      New_Line;

      Put_Line ("Einheiten:");
      Put_Line ("Eigenschaften/Funktionen einbauen!");
      Put_Line ("Die Sortierfunktion Stichpunktartig prüfen ob normal oder reverse geloopt werden soll?");
      New_Line;
      
      Put_Line ("Einheiten/VerbesserungenDatenbank:");
      Put_Line ("Bei Einheiten die Beschreibung und bei Verbesserungen die Befehlssetzung?");
      New_Line;
      
      Put_Line ("Stadtsystem:");
      Put_Line ("Einbauen.");
      Put_Line ("Anzeige des Cursors in der Stadt korrekt einbauen.");
      New_Line;
      
      Put_Line ("Forschungssystem:");
      Put_Line ("Einbauen.");
      Put_Line ("Für jede Rasse einen eigenen Forschungsbaum?");
      New_Line;
      
      Put_Line ("Kampfsystem:");
      Put_Line ("Einbauen.");
      Put_Line ("Zwischen Nahkampf und Fernkampf unterscheiden.");
      New_Line;
      
      Put_Line ("Diverses:");
      Put_Line ("Bei Sichtbarkeit/Karte/Einheitenbewegung/Eventuell Weiteren die Loops für die XAchse zusammenführen? Ist das überhaupt möglich ohne eine Schalterchaos einzubauen?");
      New_Line;
      
      Put_Line ("Einlesen:");
      Put_Line ("Alle Werte auch aus Dateien einlesen? Wenn man die wieder über eine WasEinzulesenIst Datei einlädt, dann könnte man die Werte einfach austauschen ohne in den Hauptdateien rumpfuschen zu müssen.");
      New_Line;

      Put_Line ("Auswahl:");
      New_Line;

      Put_Line ("AllesAufAnfangSetzen:");
      Put_Line ("Entsprechende Aktualisierung nicht vergessen.");
      New_Line;
      
      Put_Line ("Speichern/Laden:");
      Put_Line ("Einbauen.");
      New_Line;

      Put_Line ("KI:");
      Put_Line ("Einbauen! Wird bestimmt einfach und lustig.");
      New_Line;
      
      Get_Immediate (Taste);
      
   end Informationen;

end Informationen;
