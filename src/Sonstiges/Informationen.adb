package body Informationen is

   procedure Informationen is
   begin
      
      Put_Line (Item => "Aktuelle Version:");
      Put_Line (Item => Versionsnummer);
      New_Line;

      -- Notizen:
      -- -1 = Spiel beenden, 0 = Hauptmenü, -2 = Zurück, -3 = Ja, -4 = Nein, 2 = Speichern, 3 = Laden
      -- Gebäude haben immer die Nummer 1_000 + ihren Datenbankwert, Einheiten haben immer die Nummer 10_000 + ihren Datenbankwert.
      -- In der Übergabe immer StadtNummer oder EinheitNummer verwenden.
      -- Nicht über das Array selbst loopen, da bei Aufteilung es zu Problemen kommen kann.
      -- Für Rassen im Spiel gilt: 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI.
      
      Put_Line (Item => "Taste drücken um zurück ins Hauptmenü zu kommen.");
      Get_Immediate (Item => Taste);
      
   end Informationen;

end Informationen;
