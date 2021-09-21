pragma SPARK_Mode (On);

with GlobaleDatentypen;

package EinheitenBeschreibungen is

   procedure BeschreibungKurz
     (IDExtern : in GlobaleDatentypen.EinheitenIDMitNullWert);
   
   procedure Beschäftigung
     (ArbeitExtern : in GlobaleDatentypen.Tastenbelegung_Enum);
   
   procedure BeschreibungLang
     (IDExtern : in GlobaleDatentypen.EinheitenIDMitNullWert);
   
   
   
   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen
     (WelcheAuswahlExtern : in Natural)
      return Boolean;

end EinheitenBeschreibungen;
