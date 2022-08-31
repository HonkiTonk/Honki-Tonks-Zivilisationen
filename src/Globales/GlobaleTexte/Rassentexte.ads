pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextKonstanten;
with RassenDatentypen;
with ForschungenDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;

package Rassentexte is
   
   -- Brauche ich das hier wirklich? Wahrscheinlich nicht. äöü
   type NameBeschreibungZeilen is range 1 .. 2;

   type NameBeschreibungArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, NameBeschreibungZeilen'Range) of Unbounded_Wide_Wide_String;
   NameBeschreibung : NameBeschreibungArray := (others => (others => TextKonstanten.FehlenderText));
   
   type StädtenamenArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, StadtDatentypen.MaximaleStädte'Range) of Unbounded_Wide_Wide_String;
   Städtenamen : StädtenamenArray := (others => (others => TextKonstanten.FehlenderText));
   
   type ForschungenZeilen is range 1 .. 2;
   
   type ForschungenArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, ForschungenDatentypen.ForschungID'Range, ForschungenZeilen'Range) of Unbounded_Wide_Wide_String;
   Forschungen : ForschungenArray := (others => (others => (others => TextKonstanten.FehlenderText)));
   
   type EinheitenZeilen is range 1 .. 2;
   
   type EinheitenArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, EinheitenDatentypen.EinheitenID'Range, EinheitenZeilen'Range) of Unbounded_Wide_Wide_String;
   Einheiten : EinheitenArray := (others => (others => (others => TextKonstanten.FehlenderText)));
   
   type GebäudeZeilen is range 1 .. 2;
   
   type GebäudeArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, StadtDatentypen.GebäudeID'Range, GebäudeZeilen'Range) of Unbounded_Wide_Wide_String;
   Gebäude : GebäudeArray := (others => (others => (others => TextKonstanten.FehlenderText)));
   
end Rassentexte;