package VerzeichnisKonstantenHTSEB is
   pragma Pure;
   
   Spielstandordner : constant Wide_Wide_String (1 .. 10) := "Spielstand";
   Spielstandverzeichnis : constant Wide_Wide_String (1 .. 11) := Spielstandordner & "/";
   
   SpielstandordnerManuell : constant Wide_Wide_String (1 .. 7) := "Manuell";
   SpielstandordnerAuto : constant Wide_Wide_String (1 .. 4) := "Auto";
   
   SpielstandverzeichnisManuell : constant Wide_Wide_String (1 .. 8) := SpielstandordnerManuell & "/";
   SpielstandverzeichnisAuto : constant Wide_Wide_String (1 .. 5) := SpielstandordnerAuto & "/";
   
   -- Wird für Windows benötigt da die 255 Zeichen sich auf den ganzen Pfad und nicht nur den Dateinamen beziehen.
   VerzeichnisSpielstand : constant Wide_Wide_String (1 .. 20) := "/" & Spielstandverzeichnis & SpielstandverzeichnisManuell;
   
   Notfallspeicherdatei : constant Wide_Wide_String (1 .. 13) := "Programmstopp";
   
   
   
   Datenbankenordner : constant Wide_Wide_String (1 .. 11) := "Datenbanken";
   Datenbankenverzeichnis : constant Wide_Wide_String (1 .. 12) := Datenbankenordner & "/";
   
   
   
   Einstellungenordner : constant Wide_Wide_String (1 .. 13) := "Einstellungen";
   Einstellungenverzeichnis : constant Wide_Wide_String (1 .. 14) := Einstellungenordner & "/";
   
   Spieleinstellungen : constant Wide_Wide_String (1 .. 32) := Einstellungenverzeichnis & "Spieleinstellungen";
   Grafikeinstellungen : constant Wide_Wide_String (1 .. 33) := Einstellungenverzeichnis & "Grafikeinstellungen";
   Toneinstellungen : constant Wide_Wide_String (1 .. 30) := Einstellungenverzeichnis & "Toneinstellungen";
   Tastatureinstellungen : constant Wide_Wide_String (1 .. 35) := Einstellungenverzeichnis & "Tastatureinstellungen";
   SpielendeEinstellungen : constant Wide_Wide_String (1 .. 36) := Einstellungenverzeichnis & "SpielendeEinstellungen";
   
   
   
   Nulldatei : constant Wide_Wide_String (1 .. 2) := "/0";
   Fontdatei : constant Wide_Wide_String (Nulldatei'Range) := "/1";
   
   
   
   Grafikordner : constant Wide_Wide_String (1 .. 6) := "Grafik";
   Grafikverzeichnis : constant Wide_Wide_String (1 .. 7) := Grafikordner & "/";
   
   Musikordner : constant Wide_Wide_String (1 .. 5) := "Musik";
   Musikverzeichnis : constant Wide_Wide_String (1 .. 6) := Musikordner & "/";
   
   Soundordner : constant Wide_Wide_String (1 .. 5) := "Sound";
   Soundverzeichnis : constant Wide_Wide_String (1 .. 6) := Soundordner & "/";
   
      
   
   Sprachenordner : constant Wide_Wide_String (1 .. 8) := "Sprachen";
   Sprachenverzeichnis : constant Wide_Wide_String (1 .. 9) := Sprachenordner & "/";
   
   Fontordner : constant Wide_Wide_String (1 .. 5) := "Fonts";
   Fontverzeichnis : constant Wide_Wide_String (1 .. 15) := Sprachenverzeichnis & "Fonts/";
   SchriftartStandard : constant Wide_Wide_String (1 .. 16) := "wqy-microhei.ttc";
         
end VerzeichnisKonstantenHTSEB;
