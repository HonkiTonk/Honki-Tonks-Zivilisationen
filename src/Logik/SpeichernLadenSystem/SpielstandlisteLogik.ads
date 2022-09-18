pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Directories; use Ada.Directories;

with TextKonstanten;
with RueckgabeDatentypen;

package SpielstandlisteLogik is

   type SpielstandlisteRecord is record

      Auswahl : RueckgabeDatentypen.Speichern_Laden_Enum;
      Dateiname : Unbounded_Wide_Wide_String;

   end record;

   type SpielstandArray is array (1 .. 11) of Unbounded_Wide_Wide_String;
   Spielstand : SpielstandArray := (others => TextKonstanten.LeerUnboundedString);



   function Spielstandliste
     return SpielstandlisteRecord;

private

   MehrereSeiten : Boolean;
   EtwasEingetragen : Boolean;

   AktuelleAuswahl : Natural;

   Zwischenspeicher : Unbounded_Wide_Wide_String;

   Suche : Search_Type;

   Spielstanddatei : Directory_Entry_Type;



   function Mausauswahl
     return Natural;

end SpielstandlisteLogik;
