pragma SPARK_Mode (On);

with EinheitStadtDatentypen, GlobaleDatentypen;

package EinheitenBeschreibungen is

   procedure BeschreibungKurz
     (IDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert);
   
   procedure Beschäftigung
     (ArbeitExtern : in GlobaleDatentypen.Tastenbelegung_Enum);
   
   procedure BeschreibungLang
     (IDExtern : in EinheitStadtDatentypen.EinheitenIDMitNullWert);
   
   
   
   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen
     (WelcheAuswahlExtern : in Natural)
      return Boolean;

end EinheitenBeschreibungen;
