pragma SPARK_Mode (On);

package body LeseEinheitenDatenbank is

   EinheitenGrafik : Wide_Wide_Character;
      
   EinheitArt : GlobaleDatentypen.Einheit_Art_Enum;
   PreisGeld : GlobaleDatentypen.KostenLager;
   PreisRessourcen : GlobaleDatentypen.KostenLager;
   PermanenteKosten : GlobaleDatentypen.PermanenteKostenArray;
   Anforderungen : GlobaleDatentypen.ForschungIDMitNullWert;

   Passierbarkeit : PassierbarkeitArray;
      
   MaximaleLebenspunkte : GlobaleDatentypen.MaximaleEinheiten;
   MaximaleBewegungspunkte : Float;
   WirdVerbessertZu : GlobaleDatentypen.EinheitenIDMitNullWert;

   Beförderungsgrenze : GlobaleDatentypen.MaximaleStädte;
   MaximalerRang : GlobaleDatentypen.MaximaleStädteMitNullWert;
   Reichweite : GlobaleDatentypen.ProduktionFeld;
   Angriff : GlobaleDatentypen.ProduktionFeld;
   Verteidigung : GlobaleDatentypen.ProduktionFeld;

   KannTransportieren : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   KannTransportiertWerden : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   Transportkapazität : GlobaleDatentypen.MaximaleEinheitenMitNullWert;

end LeseEinheitenDatenbank;
