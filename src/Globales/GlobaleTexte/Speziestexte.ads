with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextKonstantenHTSEB;

with SpeziesDatentypen;
with ForschungenDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with TextnummernKonstanten;

package Speziestexte is
   pragma Elaborate_Body;

   type NameBeschreibungArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, TextnummernKonstanten.Beschreibungen'Range) of Unbounded_Wide_Wide_String;
   NameBeschreibung : NameBeschreibungArray := (others => (others => TextKonstantenHTSEB.FehlenderText));
   
   
   
   type StädtenamenArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, StadtDatentypen.StädtebereichVorhanden'Range) of Unbounded_Wide_Wide_String;
   Städtenamen : StädtenamenArray := (others => (others => TextKonstantenHTSEB.FehlenderText));
   
   
   
   type ForschungenArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, ForschungenDatentypen.ForschungIDVorhanden'Range, TextnummernKonstanten.Beschreibungen'Range) of Unbounded_Wide_Wide_String;
   Forschungen : ForschungenArray := (others => (others => (others => TextKonstantenHTSEB.FehlenderText)));
   
   
   
   type EinheitenArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, EinheitenDatentypen.EinheitenIDVorhanden'Range, TextnummernKonstanten.Beschreibungen'Range) of Unbounded_Wide_Wide_String;
   Einheiten : EinheitenArray := (others => (others => (others => TextKonstantenHTSEB.FehlenderText)));
   
   
   
   type GebäudeArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range, StadtDatentypen.GebäudeIDVorhanden'Range, TextnummernKonstanten.Beschreibungen'Range) of Unbounded_Wide_Wide_String;
   Gebäude : GebäudeArray := (others => (others => (others => TextKonstantenHTSEB.FehlenderText)));
   
end Speziestexte;
