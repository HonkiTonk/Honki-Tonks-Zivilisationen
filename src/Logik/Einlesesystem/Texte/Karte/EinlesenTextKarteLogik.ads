with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

private with Ada.Strings.Wide_Wide_Unbounded;

private with Kartentexte;

package EinlesenTextKarteLogik is
   pragma Elaborate_Body;

   procedure Karte
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
private
   use Ada.Strings.Wide_Wide_Unbounded;
   
   Basisgrund : constant Positive := Kartentexte.Basisgrund'Last;
   Zusatzgrund : constant Positive := Basisgrund + Kartentexte.Zusatzgrund'Last;
   Flüsse : constant Positive := Zusatzgrund + Kartentexte.Flüsse'Last;
   Feldeffekte : constant Positive := Flüsse + Kartentexte.Feldeffekte'Last;
   Verbesserungen : constant Positive := Feldeffekte + Kartentexte.Verbesserungen'Last;
   Wege : constant Positive := Verbesserungen + Kartentexte.Wege'Last;
   
   EinzulesendeZeile : Positive;
   AktuelleZeile : Positive;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;

end EinlesenTextKarteLogik;
