with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Directories; use Ada.Directories;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package EinlesenTextLogik is
   pragma Elaborate_Body;
   
   procedure EinlesenDateien;
   
private
   
   AnzahlTextdateien : constant Positive := 39;
      
   DateiVerzeichnisse : File_Type;
   DateiText : File_Type;
   
   Suche : Search_Type;
   
   Verzeichnis : Directory_Entry_Type;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;
   
   procedure Einlesen
     (VerzeichnisExtern : Wide_Wide_String)
     with
       -- Den Contracts später mal noch um die Länge des Sprachenordners und /0 erweitern. äöü
       Pre => (
                 VerzeichnisExtern'Length > 0
              );
         
   procedure Hauptmenü
     (DateiExtern : in File_Type);
   
   procedure Spielmenü
     (DateiExtern : in File_Type);
   
   procedure Optionsmenü
     (DateiExtern : in File_Type);
   
   procedure Grafikmenü
     (DateiExtern : in File_Type);
   
   procedure Soundmenü
     (DateiExtern : in File_Type);
   
   procedure Steuerungmenü
     (DateiExtern : in File_Type);
   
   procedure Sonstigesmenü
     (DateiExtern : in File_Type);
   
   procedure Kartengröße
     (DateiExtern : in File_Type);
   
   procedure Kartenart
     (DateiExtern : in File_Type);
   
   procedure Kartentemperatur
     (DateiExtern : in File_Type);
   
   procedure Speziesauswahl
     (DateiExtern : in File_Type);
   
   procedure Schwierigkeitsgrad
     (DateiExtern : in File_Type);
   
   procedure Kartenform
     (DateiExtern : in File_Type);
   
   procedure Ressourcenmenge
     (DateiExtern : in File_Type);
   
   procedure Basisgrund
     (DateiExtern : in File_Type);
   
   procedure Verbesserungen
     (DateiExtern : in File_Type);
   
   procedure Beschäftigungen
     (DateiExtern : in File_Type);
   
   procedure Würdigung
     (DateiExtern : in File_Type);
   
   procedure Diplomatiemenü
     (DateiExtern : in File_Type);
   
   procedure DiplomatieKI
     (DateiExtern : in File_Type);
   
   procedure Handelsmenü
     (DateiExtern : in File_Type);
   
   procedure DiplomatieStatus
     (DateiExtern : in File_Type);
   
   procedure Angebot
     (DateiExtern : in File_Type);
   
   procedure Fehlermeldung
     (DateiExtern : in File_Type);
   
   procedure Ladezeit
     (DateiExtern : in File_Type);
   
   procedure Frage
     (DateiExtern : in File_Type);
   
   procedure ZeugSachen
     (DateiExtern : in File_Type);
   
   procedure Editoren
     (DateiExtern : in File_Type);
   
   procedure Wege
     (DateiExtern : in File_Type);
   
   procedure Kartenflüsse
     (DateiExtern : in File_Type);
   
   procedure Kartenressourcen
     (DateiExtern : in File_Type);
   
   procedure Einstellungen
     (DateiExtern : in File_Type);
   
   procedure Kartenpole
     (DateiExtern : in File_Type);
   
   procedure Stadtbefehle
     (DateiExtern : in File_Type);
   
   procedure Spielstandmenü
     (DateiExtern : in File_Type);
   
   procedure Intro
     (DateiExtern : in File_Type);
   
   procedure Outro
     (DateiExtern : in File_Type);
   
   procedure Zusatzgrund
     (DateiExtern : in File_Type);
   
   procedure Feldeffekte
     (DateiExtern : in File_Type);
   
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
