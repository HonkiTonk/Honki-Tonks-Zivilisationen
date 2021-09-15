pragma SPARK_Mode (On);

with GlobaleDatentypen;

package EinheitenBeschreibungen is

   procedure Beschreibung
     (IDExtern : in GlobaleDatentypen.EinheitenID);
   
   procedure Beschäftigung
     (ArbeitExtern : in GlobaleDatentypen.Tastenbelegung_Enum);
   
   
   
   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen
     (WelcheAuswahlExtern : in Natural)
      return Boolean;

end EinheitenBeschreibungen;
