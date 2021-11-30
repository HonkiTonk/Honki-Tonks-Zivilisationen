pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with EinheitStadtDatentypen;
with SystemDatentypen;

package EinheitenBeschreibungen is
   
   procedure BeschreibungLang
     (IDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert);
   
   
   
   function Beschäftigung
     (ArbeitExtern : in SystemDatentypen.Tastenbelegung_Enum)
      return Wide_Wide_String;
   
   function BeschreibungKurz
     (IDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert)
      return Wide_Wide_String;
   
   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen
     (WelcheAuswahlExtern : in Natural)
      return Boolean;
   
private
   
   Textnummer : Positive;
   
   Text : Unbounded_Wide_Wide_String;

end EinheitenBeschreibungen;
