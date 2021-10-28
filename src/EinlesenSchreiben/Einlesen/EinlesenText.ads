pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with GlobaleTexte;

package EinlesenText is
   
   procedure EinlesenDateien;
   
private
   
   LeereZeilenAbzieher : Natural;
   
   TextdateienEinlesen : GlobaleTexte.TexteArray (1 .. 37);

   DateiTextEinlesen : File_Type;
   
   procedure DateiPrüfenZeileSetzen
     (AktuelleZeileExtern : in Positive);
   
   procedure EinlesenTexte;
   procedure Hauptmenü;
   procedure Spielmenü;
   procedure Optionsmenü;
   procedure Grafikmenü;
   procedure Soundmenü;
   procedure Steuerungmenü;
   procedure Sonstigesmenü;
   procedure Kartengröße;
   procedure Kartenart;
   procedure Kartentemperatur;
   procedure Spieleranzahl;
   procedure Rassenauswahl;
   procedure Schwierigkeitsgrad;
   procedure Kartenform;
   procedure Ressourcenmenge;
   procedure JaNein;
   procedure Rassen;
   procedure Kartenfelder;
   procedure Einheiten;
   procedure Verbesserungen;
   procedure Gebäude;
   procedure Forschungen;
   procedure Beschäftigungen;
   procedure StädtenamenKI;
   procedure Cheatmenü;
   procedure AllgemeineInformationen;
   procedure Würdigung;
   procedure Diplomatiemenü;
   procedure DiplomatieKI;
   procedure Endmeldungen;
   procedure Handelsmenü;
   procedure DiplomatieStatus;
   procedure Angebot;
   procedure Fehlermeldung;
   procedure Ladezeit;
   procedure Frage;
   procedure ZeugSachen;

end EinlesenText;
