package VerzeichnisKonstanten is
   pragma Pure;
   
   -- Da das hier nicht nur Verzeichnisse sondern auch Dateien enthält sollte ich es mal umbenennen oder aufteilen. äöü
   -- Wird für Windows benötigt da die 255 Zeichen sich auf den ganzen Pfad und nicht nur den Dateinamen beziehen.
   VerzeichnisSpielstand : constant String (1 .. 20) := "/Spielstand/Manuell/";
   ExtrazeichenSpielstand : constant Positive := VerzeichnisSpielstand'Length;
   
   Spielstand : constant String (1 .. 10) := "Spielstand";
   SpielstandStrich : constant String (1 .. 11) := Spielstand & "/";
   SpielstandSpieler : constant String (1 .. 7) := "Manuell";
   SpielstandAuto : constant String (1 .. 4) := "Auto";
   SpielstandSpielerStrich : constant Wide_Wide_String (1 .. 8) := "Manuell/";
   SpielstandAutoStrich : constant Wide_Wide_String (1 .. 5) := "Auto/";
   
   -- Einen besseren Namen dafür finden? äöü
   Notfallspeichern : constant Wide_Wide_String (1 .. 13) := "Programmstopp";
   
   
   
   Datenbanken : constant String (1 .. 11) := "Datenbanken";
   EinheitenDatenbank : constant String (1 .. 30) := Datenbanken & "/EinheitenDatenbank";
   ForschungenDatenbank : constant String (1 .. 32) := Datenbanken & "/ForschungenDatenbank";
   GebaeudeDatenbank : constant String (1 .. 29) := Datenbanken & "/GebaeudeDatenbank";
   KartenDatenbank : constant String (1 .. 27) := Datenbanken & "/KartenDatenbank";
   VerbesserungenDatenbank : constant String (1 .. 35) := Datenbanken & "/VerbesserungenDatenbank";
   SpeziesDatenbank : constant String (1 .. 28) := Datenbanken & "/SpeziesDatenbank";
   EffekteDatenbank : constant String (1 .. 28) := Datenbanken & "/EffekteDatenbank";
   
   
   
   Einstellungen : constant String (1 .. 13) := "Einstellungen";
   Spieleinstellungen : constant String (1 .. 32) := Einstellungen & "/Spieleinstellungen";
   Grafikeinstellungen : constant String (1 .. 33) := Einstellungen & "/Grafikeinstellungen";
   Toneinstellungen : constant String (1 .. 30) := Einstellungen & "/Toneinstellungen";
   Tastatureinstellungen : constant String (1 .. 35) := Einstellungen & "/Tastatureinstellungen";
   SpielendeEinstellungen : constant String (1 .. 36) := Einstellungen & "/SpielendeEinstellungen";
   
   
   
   NullDatei : constant String (1 .. 2) := "/0";
   FontDatei : constant String (1 .. 2) := "/1";
   
   
   
   Grafik : constant String (1 .. 15) := "Grafik/Standard";
   Audio : constant String (1 .. 14) := "Audio/Standard";
   Musik : constant String (1 .. 6) := "/Musik";
   Sound : constant String (1 .. 6) := "/Sound";
   
   
   
   -- Statt einzelner Teile einfach nur die Gesamtpfade erstellen? äöü
   -- Wäre wahrscheinlich übersichtlicher und weniger Konstanten. äöü
   -- Oder die Nulldateien in den Hauptordner schieben und von da alles einlesen? äöü Das hier dürfte vermutlich das Sinnvollste sein, ähnlich wie bei den Textdateien? äöü
   System : constant String (1 .. 7) := "/System";
   Hintergrund : constant String (1 .. 12) := "/Hintergrund";
   Basisgrund : constant String (1 .. 11) := "/Basisgrund";
   Zusatzgrund : constant String (1 .. 12) := "/Zusatzgrund";
   Feldeffekte : constant String (1 .. 12) := "/Feldeffekte";
   Kartenfluss : constant String (1 .. 12) := "/Kartenfluss";
   Kartenressourcen : constant String (1 .. 17) := "/Kartenressourcen";
   Kartenverbesserungen : constant String (1 .. 15) := "/Verbesserungen";
   Kartenwege : constant String (1 .. 5) := "/Wege";
   Einheiten : constant String (1 .. 10) := "/Einheiten";
   Bauwerke : constant String (1 .. 9) := "/Bauwerke";
   Spezies : constant String (1 .. 8) := "/Spezies";
   
      
   
   Sprachenordner : constant Wide_Wide_String (1 .. 9) := "Sprachen/";
   Sprachen : constant String (1 .. 8) := "Sprachen";
   SprachenStrich : constant String (1 .. 9) := Sprachen & "/";
   FontOrdner : constant String (1 .. 15) := SprachenStrich & "Fonts/";
   SchriftartStandard : constant String (1 .. 16) := "wqy-microhei.ttc";
         
end VerzeichnisKonstanten;
