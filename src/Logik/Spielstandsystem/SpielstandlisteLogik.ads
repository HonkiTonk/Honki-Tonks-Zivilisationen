with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Ada.Directories;

package SpielstandlisteLogik is
   pragma Elaborate_Body;

   function Spielstandliste
     (SpeichernLadenExtern : in Boolean)
      return Unbounded_Wide_Wide_String;

private
   use Ada.Directories;

   LöschenAktiv : Boolean;

   Schleifenanfang : Positive;
   AktuellerSpielstand : Positive;

   AktuelleAuswahl : Integer;
   Ausgewählt : Integer;
   Löschauswahl : Integer;

   Zwischenspeicher : Unbounded_Wide_Wide_String;
   RückgabeWert : Unbounded_Wide_Wide_String;
   Spielstandname : Unbounded_Wide_Wide_String;

   Suche : Search_Type;

   Spielstanddatei : Directory_Entry_Type;



   function Mausauswahl
     (SpeichernLadenExtern : in Boolean)
      return Integer;

   function NameNutzer
     return Unbounded_Wide_Wide_String;

end SpielstandlisteLogik;
