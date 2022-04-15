pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with GlobaleTexte;

package EinlesenText is
   
   procedure EinlesenDateien;
   
private
   
   EinlesenMöglich : Boolean;
   
   LeereZeilenAbzieher : Natural;
      
   TextdateienEinlesen : GlobaleTexte.TexteArray (1 .. 41);

   DateiTextEinlesen : File_Type;
   
   function VorzeitigesZeilenende
     (AktuelleZeileExtern : in Positive)
      return Boolean;
   
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
   procedure Debugmenü;
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
   procedure Editoren;
   procedure Wege;
   procedure Kartenflüsse;
   procedure Kartenressourcen;
   procedure Einstellungen;
   
end EinlesenText;
