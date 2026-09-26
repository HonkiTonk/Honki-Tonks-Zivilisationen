with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

private with Ada.Strings.Wide_Wide_Unbounded;

with SpeziesDatentypen;

private with Speziestexte;

package EinlesenTextSpeziesLogik is
   pragma Elaborate_Body;
   
   procedure Spezies
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum);
   
private
   use Ada.Strings.Wide_Wide_Unbounded;
   
   NameBeschreibung : constant Positive := Speziestexte.NameBeschreibungArray'Last (2);
   Städtenamen : constant Positive := NameBeschreibung + Speziestexte.StädtenamenArray'Length (2);
   Forschungen : constant Positive := Städtenamen + Speziestexte.ForschungenArray'Length (2) * Speziestexte.ForschungenArray'Last (3);
   Einheiten : constant Positive := Forschungen + Speziestexte.EinheitenArray'Length (2) * Speziestexte.EinheitenArray'Last (3);
   Gebäude : constant Positive := Einheiten + Speziestexte.GebäudeArray'Length (2) * Speziestexte.GebäudeArray'Last (3);
   
   EinzulesendeZeile : Positive;
   AktuelleZeile : Positive;
   ZeilenumwandlungForschungen : Positive;
   ZeilenumwandlungEinheiten : Positive;
   ZeilenumwandlungGebäude : Positive;
   
   ZeilenumwandlungsabzugForschungen : Natural;
   ZeilenumwandlungsabzugEinheiten : Natural;
   ZeilenumwandlungsabzugGebäude : Natural;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;

end EinlesenTextSpeziesLogik;
