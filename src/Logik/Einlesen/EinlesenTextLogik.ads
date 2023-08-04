with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Directories; use Ada.Directories;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package EinlesenTextLogik is
   pragma Elaborate_Body;
   
   procedure EinlesenDateien
     (EinsprachigExtern : in Boolean);
   
private
   
   AnzahlTextdateien : constant Positive := 34;
   Trennzeile : constant Positive := 1;
   EinzulesendeZeile : Positive;
   AktuelleZeile : Positive;
   AktuellesMenü : Positive;
      
   DateiVerzeichnisse : File_Type;
   DateiText : File_Type;
   
   Suche : Search_Type;
   
   Verzeichnis : Directory_Entry_Type;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;
   
   procedure Einlesen
     (VerzeichnisExtern : in Wide_Wide_String;
      EinsprachigExtern : in Boolean)
     with
   -- Den Contracts später mal noch um die Länge des Sprachenordners und /0 erweitern. äöü
     Pre => (
               VerzeichnisExtern'Length > 0
            );
   
   procedure EinlesenAufteilen
     (WelcheDateiExtern : in Positive;
      VerzeichnisExtern : in Wide_Wide_String;
      EinsprachigExtern : in Boolean)
     with
       Pre => (
                 WelcheDateiExtern <= AnzahlTextdateien
               and
                 VerzeichnisExtern'Length > 0
              );
   
   procedure Menüs
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Steuerungmenü
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Kartengröße
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Kartenart
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Kartentemperatur
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Speziesauswahl
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Schwierigkeitsgrad
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Kartenform
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Ressourcenmenge
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Basisgrund
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Verbesserungen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Beschäftigungen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Würdigung
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Diplomatiemenü
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure DiplomatieKI
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Handelsmenü
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure DiplomatieStatus
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Angebot
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Fehlermeldung
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Ladezeit
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Frage
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure ZeugSachen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Editoren
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Wege
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Kartenflüsse
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Kartenressourcen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Einstellungen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Kartenpole
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Stadtbefehle
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Spielstandmenü
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Intro
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Outro
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Zusatzgrund
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   procedure Feldeffekte
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
   
   
   function Einsprachig
     (EinsprachigExtern : in Boolean;
      EingelesenerTextExtern : in Unbounded_Wide_Wide_String;
      VorhandenerTextExtern : in Unbounded_Wide_Wide_String)
      return Unbounded_Wide_Wide_String;
   
end EinlesenTextLogik;
