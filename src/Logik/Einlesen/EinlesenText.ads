pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

package EinlesenText is
   
   procedure EinlesenDateien;
   
private
      
   DateiVerzeichnisse : File_Type;
   DateiText : File_Type;
   
   Verzeichnisse : Unbounded_Wide_Wide_String;
      
   type TextdateienEinlesenArray is array (1 .. 38) of Unbounded_Wide_Wide_String;
   TextdateienEinlesen : TextdateienEinlesenArray;
   
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
   procedure Kartenfelder;
   procedure Verbesserungen;
   procedure Beschäftigungen;
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
   procedure Kartenpole;
   procedure Stadtbefehle;
   procedure Spielstandmenü;
   
   procedure EinlesenAufteilen
     (WelcheDateiExtern : in Positive;
      VerzeichnisExtern : in Wide_Wide_String)
     with
       Pre => (
                 WelcheDateiExtern <= TextdateienEinlesen'Last
               and
                 VerzeichnisExtern'Length > 0
              );
   
end EinlesenText;
