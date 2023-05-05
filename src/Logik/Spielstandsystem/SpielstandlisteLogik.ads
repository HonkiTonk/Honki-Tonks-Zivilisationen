with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Directories; use Ada.Directories;

package SpielstandlisteLogik is
   pragma Elaborate_Body;

   function Spielstandliste
     (SpeichernLadenExtern : in Boolean)
      return Unbounded_Wide_Wide_String;

   function NamePrüfen
     (NameExtern : in Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 NameExtern'Length > 0
              );

private

   SpielstandlisteAnfang : constant Positive := 1;
   SpielstandlisteEnde : constant Positive := 10;
   MehrAnzeigen : constant Positive := 11;
   NeuerSpielstand : constant Positive := 12;
   Löschen : constant Positive := 13;
   Zurück : constant Positive := 14;
   Schleifenanfang : Positive;
   AktuellerSpielstand : Positive;

   AktuelleAuswahl : Natural;
   Ausgewählt : Natural;

   KleinsteSpeicherdateigröße : constant File_Size := 127 * 1_024;
   GrößteSpeicherdateigröße : constant File_Size := 159 * 1_024 * 1_024;

   Zwischenspeicher : Unbounded_Wide_Wide_String;
   RückgabeWert : Unbounded_Wide_Wide_String;
   Spielstandname : Unbounded_Wide_Wide_String;

   Suche : Search_Type;

   Spielstanddatei : Directory_Entry_Type;



   function Mausauswahl
     (SpeichernLadenExtern : in Boolean)
      return Natural;

   function NameNutzer
     return Unbounded_Wide_Wide_String;

   function NamePrüfenLinux
     (NameExtern : in Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 NameExtern'Length > 0
              );

   function NamePrüfenWindows
     (NameExtern : in Wide_Wide_String)
      return Boolean
     with
       Pre => (
                 NameExtern'Length > 0
              );

end SpielstandlisteLogik;
