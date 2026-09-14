-- Das mal teilweise oder ganz auslagern? äöü
-- Das alles als Wide_Wide_String anlegen und an den entsprechenden Stellen dann einfach umwandeln? äöü
-- Muss ja teilweise eh umwandeln und es würde die Doppelvarianten entfernen. äöü
package VerzeichnisKonstanten is
   pragma Pure;
   
   -- Da das hier nicht nur Verzeichnisse sondern auch Dateien enthält sollte ich es mal umbenennen oder aufteilen. äöü
   -- Wird für Windows benötigt da die 255 Zeichen sich auf den ganzen Pfad und nicht nur den Dateinamen beziehen.
   VerzeichnisSpielstand : constant String (1 .. 20) := "/Spielstand/Manuell/";
   
   Spielstand : constant String (1 .. 10) := "Spielstand";
   SpielstandStrich : constant String (1 .. 11) := Spielstand & "/";
   SpielstandSpieler : constant String (1 .. 7) := "Manuell";
   SpielstandAuto : constant String (1 .. 4) := "Auto";
   SpielstandSpielerStrich : constant Wide_Wide_String (1 .. 8) := "Manuell/";
   SpielstandAutoStrich : constant Wide_Wide_String (1 .. 5) := "Auto/";
   
   Notfallspeichern : constant Wide_Wide_String (1 .. 16) := "Notfallspeichern";
   
   
   
   -- Die Datenbanken weiter aufteilen? Beispielsweise eine eigene Datenbank für Rohstoffe/Verarbeitung? äöü
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
   NullDateiWideWide : constant Wide_Wide_String (NullDatei'Range) := "/0";
   FontDatei : constant String (1 .. 2) := "/1";
   
   
   
   GrafikOhneStrich : constant String (1 .. 6) := "Grafik";
   GrafikEinfach : constant String (1 .. 7) := "Grafik/";
   Grafik : constant Wide_Wide_String (GrafikEinfach'Range) := "Grafik/";
   
   MusikOhneStrich : constant String (1 .. 5) := "Musik";
   MusikEinfach : constant String (1 .. 6) := "Musik/";
   Musik : constant Wide_Wide_String (MusikEinfach'Range) := "Musik/";
   
   SoundOhneStrich : constant String (1 .. 5) := "Sound";
   SoundEinfach : constant String (1 .. 6) := "Sound/";
   Sound : constant Wide_Wide_String (1 .. 6) := "Sound/";
   
      
   
   Sprachenordner : constant Wide_Wide_String (1 .. 9) := "Sprachen/";
   Sprachen : constant String (1 .. 8) := "Sprachen";
   SprachenStrich : constant String (1 .. 9) := Sprachen & "/";
   FontOrdner : constant String (1 .. 15) := SprachenStrich & "Fonts/";
   SchriftartStandard : constant String (1 .. 16) := "wqy-microhei.ttc";
   FontsOrdner : constant String (1 .. 5) := "Fonts";
         
end VerzeichnisKonstanten;
