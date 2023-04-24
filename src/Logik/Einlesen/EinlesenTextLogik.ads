with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

package EinlesenTextLogik is
   pragma Elaborate_Body;
   
   procedure EinlesenDateien;
   
private
   
   AnzahlTextdateien : constant Positive := 39;
      
   DateiVerzeichnisse : File_Type;
   DateiText : File_Type;
   
   Nullpfad : Unbounded_Wide_Wide_String;
   Dateienpfad : Unbounded_Wide_Wide_String;
   
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
   procedure Speziesauswahl;
   procedure Schwierigkeitsgrad;
   procedure Kartenform;
   procedure Ressourcenmenge;
   procedure Basisgrund;
   procedure Verbesserungen;
   procedure Beschäftigungen;
   procedure Würdigung;
   procedure Diplomatiemenü;
   procedure DiplomatieKI;
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
   procedure Intro;
   procedure Outro;
   procedure Zusatzgrund;
   procedure Feldeffekte;
   
   procedure EinlesenAufteilen
     (WelcheDateiExtern : in Positive;
      VerzeichnisExtern : in Wide_Wide_String)
     with
       Pre => (
                 WelcheDateiExtern <= AnzahlTextdateien
               and
                 VerzeichnisExtern'Length > 0
              );
   
end EinlesenTextLogik;
