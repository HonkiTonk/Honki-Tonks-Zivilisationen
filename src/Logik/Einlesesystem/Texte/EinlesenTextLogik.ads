private with Ada.Wide_Wide_Text_IO;
private with Ada.Directories;
private with Ada.Strings.Wide_Wide_Unbounded;

package EinlesenTextLogik is
   pragma Elaborate_Body;
   
   procedure EinlesenDateien
     (EinsprachigExtern : in Boolean);
   
private
   use Ada.Wide_Wide_Text_IO;
   use Ada.Directories;
   use Ada.Strings.Wide_Wide_Unbounded;
   
   AnzahlTextdateien : constant Positive := 24;
   
   DateiErsetzungen : constant Positive := 1;
   DateiMenüs : constant Positive := DateiErsetzungen + 1;
   DateiAllgemeineTexte : constant Positive := DateiMenüs + 1;
   DateiSequenzen : constant Positive := DateiAllgemeineTexte + 1;
   DateiKarte : constant Positive := DateiSequenzen + 1;
   DateiRohstoffe : constant Positive := DateiKarte + 1;
   DateiSpezies : constant Positive := DateiRohstoffe;
           
      
   EinzulesendeZeile : Positive;
   AktuelleZeile : Positive;
   EinzulesendeDateizeile : Positive;
   AktuelleDateizeile : Positive;
   
   DateiVerzeichnisse : File_Type;
   DateiText : File_Type;
   
   Suche : Search_Type;
   
   Verzeichnis : Directory_Entry_Type;
   
   Dateiname : Unbounded_Wide_Wide_String;
   GesamterPfad : Unbounded_Wide_Wide_String;
   
   procedure Einlesen
     (VerzeichnisExtern : in Wide_Wide_String;
      EinsprachigExtern : in Boolean)
     with
   -- Den Contract später mal noch um die Länge des Sprachenordners und /0 erweitern. äöü
     Pre => (
               VerzeichnisExtern'Length > 0
            );
   
   procedure EinlesenAufteilen
     (WelcheDateiExtern : in Positive;
      DateipfadExtern : in Wide_Wide_String;
      EinsprachigExtern : in Boolean)
     with
       Pre => (
                 WelcheDateiExtern <= AnzahlTextdateien
               and
                 DateipfadExtern'Length > 0
              );
   
end EinlesenTextLogik;
