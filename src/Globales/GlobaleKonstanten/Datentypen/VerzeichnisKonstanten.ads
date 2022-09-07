pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package VerzeichnisKonstanten is

   Spielstand : constant String (1 .. 10) := "Spielstand";
   SpielstandStrich : constant String (1 .. 11) := Spielstand & "/";
   
   Datenbanken : constant String (1 .. 11) := "Datenbanken";
   EinheitenDatenbank : constant String (1 .. 30) := Datenbanken & "/EinheitenDatenbank";
   ForschungenDatenbank : constant String (1 .. 32) := Datenbanken & "/ForschungenDatenbank";
   GebaeudeDatenbank : constant String (1 .. 29) := Datenbanken & "/GebaeudeDatenbank";
   KartenGrundDatenbank : constant String (1 .. 32) := Datenbanken & "/KartenGrundDatenbank";
   KartenFlussDatenbank : constant String (1 .. 32) := Datenbanken & "/KartenFlussDatenbank";
   KartenRessourcenDatenbank : constant String (1 .. 37) := Datenbanken & "/KartenRessourcenDatenbank";
   VerbesserungenDatenbank : constant String (1 .. 35) := Datenbanken & "/VerbesserungenDatenbank";
   WegeDatenbank : constant String (1 .. 25) := Datenbanken & "/WegeDatenbank";
   RassenDatenbank : constant String (1 .. 27) := Datenbanken & "/RassenDatenbank";
   
   Einstellungen : constant String (1 .. 13) := "Einstellungen";
   Tastenbelegung : constant String (1 .. 14) := "Tastenbelegung";
   Sprachen : constant String (1 .. 8) := "Sprachen";
   SprachenStrich : constant String (1 .. 9) := Sprachen & "/";
   Schriftart : constant String (1 .. 10) := "Schriftart";
   
   NullDatei : constant String (1 .. 2) := "/0";
   Grafik : constant String (1 .. 6) := "Grafik";
   Audio : constant String (1 .. 5) := "Audio";
   Musik : constant String (1 .. 6) := "/Musik";
   Sound : constant String (1 .. 6) := "/Sound";
   
   Hintergrund : constant String (1 .. 12) := "/Hintergrund";
   Kartenfelder : constant String (1 .. 13) := "/Kartenfelder";
   Kartenfluss : constant String (1 .. 12) := "/Kartenfluss";
   Kartenressourcen : constant String (1 .. 17) := "/Kartenressourcen";
   Kartenverbesserungen : constant String (1 .. 15) := "/Verbesserungen";
   Kartenwege : constant String (1 .. 5) := "/Wege";
   Einheiten : constant String (1 .. 10) := "/Einheiten";
   Bauwerke : constant String (1 .. 9) := "/Bauwerke";
   Rassen : constant String (1 .. 7) := "/Rassen";

end VerzeichnisKonstanten;
