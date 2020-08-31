package body Informationen is

   procedure Informationen is
   begin
      
      Put_Line ("Aktuelle Version:");
      Put_Line (Versionsnummer);
      New_Line;

      Put_Line ("Wichtiges/Notizen:");
      Put_Line ("-1 = Spiel beenden, 0 = Hauptmenü, -2 = Zurück, -3 = Ja, -4 = Nein, 2 = Speichern, 3 = Laden");
      Put_Line ("Kartengenerator endlich neu schreiben/überarbeiten.");
      Put_Line ("Verbesserung ersetzen zeigt auf Beschäftigung abbrechen, korrigieren.");
      Put_Line ("Alle Werte in Dateien auslagern?");
      New_Line;

      Put_Line ("Verbesserungen/Flüsse:");
      Put_Line ("Logik zur Verbindung angrenzender Straßen/Flüsse einbauen.");
      New_Line;
      
      Put_Line ("BefehleImSpiel:");
      Put_Line ("Informationsaufruf einbauen.");
      Put_Line ("Befehl und System für automatisches bewegen einbauen.");
      New_Line;
      
      Put_Line ("Kartengenerator:");
      Put_Line ("");
      Put_Line ("Notizen machen was was ist, sonst verliet man die Übersicht.");
      Put_Line ("Berücksichtigung für Hügel in der Wüste, usw. einbauen.");
      Put_Line ("Generator für nur Land einbauen.");
      Put_Line ("Generator für Chaos einbauen.");
      Put_Line ("Zufallsauswahl einbauen.");
      Put_Line ("Generator für Oberfläche einbauen!");
      Put_Line ("Generatorwerte optimieren.");

      Put_Line ("Für Hitze ein System ähnlich wie für Inselns/Kontinente einbauen!");
      Put_Line ("Generell den Generator so umschreiben das auch die Wahrscheinlichkeit für Land/Wasser komplett so funktioniert!");
      Put_Line ("Das System auch für Flüsse einbauen!");
      Put_Line ("Zwischen Küsten und Seen unterscheiden?");

      New_Line;

      Put_Line ("SpielEinstellungen;");
      Put_Line ("Die Festlegung der Starteinheiten in die EinheitenDatenbank verschieben.");
      New_Line;

      Put_Line ("Karte:");
      Put_Line ("Beschreibungen des Untergrunds/Ressourcen/Verbesserungen anzeigen (ohne langen Text) und den Gesamtwert für die einzelnen Werte ausgeben.");
      Put_Line ("Für das aktuelle Bauprojekt noch ein System zur Namensanzeige einbauen.");
      New_Line;
      
      Put_Line ("Bewegungssystem:");
      Put_Line ("Straße/Schiene berücksichtigen.");
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
      Put_Line ("Stadtname und ob es die Hauptstadt ist anzeigen, wenn der Cursor drüber ist.");
      Put_Line ("Anzeige des Cursors in der Stadt korrekt einbauen.");
      New_Line;
      
      Put_Line ("Forschungssystem:");
      Put_Line ("Einbauen.");
      New_Line;
      
      Put_Line ("Kampfsystem:");
      Put_Line ("Einbauen.");
      Put_Line ("Zwischen Nahkampf und Fernkampf unterscheiden.");
      New_Line;
      
      Put_Line ("Diverses:");
      Put_Line ("Beschreibungen der Einheiten/Gebäude/Verbesserungen an der Sichtbarkeit der Karte prüfen.");
      Put_Line ("Bei Sichtbarkeit/Karte/Einheitenbewegung/Eventuell Weiteren die Loops für die XAchse zusammenführen?");
      New_Line;
      
      Put_Line ("Einlesen:");
      New_Line;

      Put_Line ("Auswahl:");
      Put_Line ("Anzeige für lange Texte noch was gutes überlegen.");
      Put_Line ("Eine leere Zeile als Trennung nutzen und dementsprechend aufteilen?");
      New_Line;

      Put_Line ("AllesAufAnfangSetzen:");
      Put_Line ("Noch Zeug einfügen!");
      New_Line;
      
      Put_Line ("Speichern/Laden:");
      Put_Line ("Einbauen.");
      New_Line;
      
      Get_Immediate (Taste);
      
   end Informationen;

end Informationen;
