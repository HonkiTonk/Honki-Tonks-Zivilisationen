pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with EinheitStadtDatentypen;
with TastenbelegungDatentypen;

package EinheitenBeschreibungen is
   
   function BeschreibungLang
     (IDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert)
      return Wide_Wide_String;
   
   function Beschäftigung
     (ArbeitExtern : in TastenbelegungDatentypen.Tastenbelegung_Enum)
      return Wide_Wide_String;
   
   function BeschreibungKurz
     (IDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert)
      return Wide_Wide_String;
   
   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen
     (WelcheAuswahlExtern : in Natural)
      return Boolean;
   
private
   
   Textnummer : Positive;
   
   BeschreibungText : Unbounded_Wide_Wide_String;
   BeschäftigungText : Unbounded_Wide_Wide_String;

end EinheitenBeschreibungen;
