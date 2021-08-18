pragma SPARK_Mode (On);

package body LeseStadtGebaut is

   ID : GlobaleDatentypen.Karten_Verbesserung_Stadt_ID_Enum;
   Position : AchsenKartenfeldPositivRecord;
   EinwohnerArbeiter : EinwohnerArbeiterArray;
      
   Nahrungsmittel : GlobaleDatentypen.GesamtproduktionStadt;
   Nahrungsproduktion : GlobaleDatentypen.GesamtproduktionStadt;
   Ressourcen : GlobaleDatentypen.KostenLager;
   Produktionrate : GlobaleDatentypen.GesamtproduktionStadt;
   Geldgewinnung : GlobaleDatentypen.GesamtproduktionStadt;
   PermanenteKostenPosten : GlobaleDatentypen.PermanenteKostenArray;
      
   Forschungsrate : GlobaleDatentypen.GesamtproduktionStadt;
   Bauprojekt : Natural;
   Bauzeit : GlobaleDatentypen.KostenLager;

   Korruption : GlobaleDatentypen.GesamtproduktionStadt;
   GebäudeVorhanden : GebäudeVorhandenArray;
   Name : Unbounded_Wide_Wide_String;

   UmgebungBewirtschaftung : GlobaleDatentypen.UmgebungBewirtschaftungArray;
   UmgebungGröße : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;
      
   Meldungen : StadtMeldungenArray;
      
   KIBeschäftigung : KIDatentypen.Stadt_Aufgabe_Enum;

end LeseStadtGebaut;
