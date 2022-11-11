with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Directories; use Ada.Directories;

with TextKonstanten;

package SpielstandlisteLogik is
   pragma Elaborate_Body;

   -- Das auch mal in irgendwas Globales verschieben? äöü
   type SpielstandArray is array (1 .. 11) of Unbounded_Wide_Wide_String;
   Spielstand : SpielstandArray := (others => TextKonstanten.LeerUnboundedString);



   function Spielstandliste
     (SpeichernLadenExtern : in Boolean)
      return Unbounded_Wide_Wide_String;

private

   SpielstandlisteAnfang : constant Positive := 1;
   SpielstandlisteEnde : constant Positive := 10;
   MehrAnzeigen : constant Positive := 11;
   NeuerSpielstand : constant Positive := 12;
   Löschen : constant Positive := 13;
   Zurück : constant Positive := 14;
   Schleifenanfang : Positive;

   AktuelleAuswahl : Natural;
   Ausgewählt : Natural;

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

end SpielstandlisteLogik;
