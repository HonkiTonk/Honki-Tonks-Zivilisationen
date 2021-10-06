pragma SPARK_Mode (On);

with EinheitStadtDatentypen;
with SystemDatentypen;

package EinheitenBeschreibungen is

   procedure BeschreibungKurz
     (IDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert);
   
   procedure Beschäftigung
     (ArbeitExtern : in SystemDatentypen.Tastenbelegung_Enum);
   
   procedure BeschreibungLang
     (IDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert);
   
   
   
   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen
     (WelcheAuswahlExtern : in Natural)
      return Boolean;

end EinheitenBeschreibungen;
