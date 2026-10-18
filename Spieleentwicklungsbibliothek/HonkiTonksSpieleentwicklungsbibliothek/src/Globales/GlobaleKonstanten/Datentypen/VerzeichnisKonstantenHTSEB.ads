package VerzeichnisKonstantenHTSEB is
   pragma Pure;
      
   Spielstand : constant Wide_Wide_String (1 .. 10) := "Spielstand";
   Spielstandordner : constant Wide_Wide_String (1 .. 11) := Spielstand & "/";
   SpielstandSpieler : constant Wide_Wide_String (1 .. 7) := "Manuell";
   SpielstandAuto : constant Wide_Wide_String (1 .. 4) := "Auto";
   SpielstandSpielerordner : constant Wide_Wide_String (1 .. 8) := SpielstandSpieler & "/";
   SpielstandAutoordner : constant Wide_Wide_String (1 .. 5) := SpielstandAuto & "/";
   
   Notfallspeichern : constant Wide_Wide_String (1 .. 16) := "Notfallspeichern";
   
   -- Wird für Windows benötigt da die 255 Zeichen sich auf den ganzen Pfad und nicht nur den Dateinamen beziehen.
   VerzeichnisSpielstand : constant Wide_Wide_String (1 .. 1 + Spielstandordner'Length + SpielstandSpielerordner'Length) := "/" & Spielstandordner & SpielstandSpielerordner;
   
   
   
   Datenbanken : constant Wide_Wide_String (1 .. 11) := "Datenbanken";
   Datenbankenordner : constant Wide_Wide_String (1 .. 12) := Datenbanken & "/";
   
   
   
   Einstellungen : constant Wide_Wide_String (1 .. 13) := "Einstellungen";
   Einstellungenordner : constant Wide_Wide_String (1 .. 14) := Einstellungen & "/";
   
   Spieleinstellungen : constant Wide_Wide_String (1 .. 32) := Einstellungenordner & "Spieleinstellungen";
   Grafikeinstellungen : constant Wide_Wide_String (1 .. 33) := Einstellungenordner & "Grafikeinstellungen";
   Toneinstellungen : constant Wide_Wide_String (1 .. 30) := Einstellungenordner & "Toneinstellungen";
   Tastatureinstellungen : constant Wide_Wide_String (1 .. 35) := Einstellungenordner & "Tastatureinstellungen";
   SpielendeEinstellungen : constant Wide_Wide_String (1 .. 36) := Einstellungenordner & "SpielendeEinstellungen";
      
   
   
   Nulldatei : constant Wide_Wide_String (1 .. 2) := "/0";
   Fontdatei : constant Wide_Wide_String (Nulldatei'Range) := "/1";
   
   
   
   Grafik : constant Wide_Wide_String (1 .. 6) := "Grafik";
   Grafikordner : constant Wide_Wide_String (1 .. 7) := Grafik & "/";
   
   Musik : constant Wide_Wide_String (1 .. 5) := "Musik";
   Musikordner : constant Wide_Wide_String (1 .. 6) := Musik & "/";
   
   Sound : constant Wide_Wide_String (1 .. 5) := "Sound";
   Soundordner : constant Wide_Wide_String (1 .. 6) := Sound & "/";
   
      
   
   Sprachen : constant Wide_Wide_String (1 .. 8) := "Sprachen";
   Sprachenordner : constant Wide_Wide_String (1 .. 9) := Sprachen & "/";
   Fonts : constant Wide_Wide_String (1 .. 5) := "Fonts";
   Fontsordner : constant Wide_Wide_String (1 .. 6) := Fonts & "/";
   
   Microhei : constant Wide_Wide_String (1 .. 16) := "wqy-microhei.ttc";
   Unifont : constant Wide_Wide_String (1 .. 11) := "unifont.otf";
         
end VerzeichnisKonstantenHTSEB;
