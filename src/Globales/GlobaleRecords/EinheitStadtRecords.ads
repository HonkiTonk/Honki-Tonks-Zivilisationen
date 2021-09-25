pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, KartenRecords;

with KIDatentypen;

package EinheitStadtRecords is

   type RassePlatznummerRecord is tagged record
      
      Rasse : GlobaleDatentypen.Rassen_Enum;
      Platznummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      
   end record;
   
   
   
   type KIBewegungPlanArray is array (GlobaleDatentypen.Stadtfeld'Range) of KartenRecords.AchsenKartenfeldPositivRecord;
   type TransporterArray is array (GlobaleDatentypen.MaximaleStädte'First .. 5) of GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   type EinheitMeldungenArray is array (GlobaleDatentypen.Einheit_Meldung_Art_Enum'Range) of GlobaleDatentypen.Einheit_Meldung_Enum;

   type EinheitenGebautRecord is record
      
      ID : GlobaleDatentypen.EinheitenIDMitNullWert;
      Position : KartenRecords.AchsenKartenfeldPositivRecord;
      Heimatstadt : GlobaleDatentypen.MaximaleStädteMitNullWert;
      
      Lebenspunkte : GlobaleDatentypen.MaximaleStädteMitNullWert;
      Bewegungspunkte : GlobaleDatentypen.BewegungFloat;
      Erfahrungspunkte : GlobaleDatentypen.MaximaleStädteMitNullWert;
      Rang : GlobaleDatentypen.MaximaleStädteMitNullWert;
      
      Beschäftigung : GlobaleDatentypen.Tastenbelegung_Enum;
      BeschäftigungNachfolger : GlobaleDatentypen.Tastenbelegung_Enum;
      
      Beschäftigungszeit : GlobaleDatentypen.MaximaleStädteMitNullWert;
      BeschäftigungszeitNachfolger : GlobaleDatentypen.MaximaleStädteMitNullWert;
      
      KIZielKoordinaten : KartenRecords.AchsenKartenfeldPositivRecord;
      KIBeschäftigt : KIDatentypen.Einheit_Aufgabe_Enum;
      KIBewegungPlan : KIBewegungPlanArray;
      
      Transportiert : TransporterArray;
      WirdTransportiert : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      
      Meldungen : EinheitMeldungenArray;
      
   end record;
   
   
   
   type KampfwerteRecord is record
      
      Angriff : GlobaleDatentypen.ProduktionFeld;
      Verteidigung : GlobaleDatentypen.ProduktionFeld;
      
   end record;



   type EinwohnerArbeiterArray is array (1 .. 2) of GlobaleDatentypen.ProduktionFeld;
   type GebäudeVorhandenArray is array (GlobaleDatentypen.GebäudeID'Range) of Boolean;
   type StadtMeldungenArray is array (GlobaleDatentypen.Stadt_Meldung_Art_Enum'Range) of GlobaleDatentypen.Stadt_Meldung_Enum;
   type UmgebungBewirtschaftungArray is array (GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range, GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range) of Boolean;
   type PermanenteKostenArray is array (GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum'Range) of GlobaleDatentypen.GesamtePermanenteKosten;

   type StadtGebautRecord is record
      
      ID : GlobaleDatentypen.Karten_Verbesserung_Stadt_ID_Enum;
      Position : KartenRecords.AchsenKartenfeldPositivRecord;
      EinwohnerArbeiter : EinwohnerArbeiterArray;
      
      Nahrungsmittel : GlobaleDatentypen.GesamtproduktionStadt;
      Nahrungsproduktion : GlobaleDatentypen.GesamtproduktionStadt;
      Ressourcen : GlobaleDatentypen.KostenLager;
      Produktionrate : GlobaleDatentypen.GesamtproduktionStadt;
      Geldgewinnung : GlobaleDatentypen.GesamtproduktionStadt;
      PermanenteKostenPosten : PermanenteKostenArray;
      
      Forschungsrate : GlobaleDatentypen.GesamtproduktionStadt;
      Bauprojekt : Natural;
      Bauzeit : GlobaleDatentypen.KostenLager;

      Korruption : GlobaleDatentypen.GesamtproduktionStadt;
      GebäudeVorhanden : GebäudeVorhandenArray;
      Name : Unbounded_Wide_Wide_String;

      UmgebungBewirtschaftung : UmgebungBewirtschaftungArray;
      UmgebungGröße : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;
      
      Meldungen : StadtMeldungenArray;
      
      KIBeschäftigung : KIDatentypen.Stadt_Aufgabe_Enum;
      
   end record;

end EinheitStadtRecords;
