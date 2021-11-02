pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with KartenRecords;
with EinheitStadtDatentypen;
with KartenDatentypen;

with KIDatentypen;

package EinheitStadtRecords is

   type RassePlatznummerRecord is tagged record
      
      Rasse : SystemDatentypen.Rassen_Enum;
      Platznummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
      
   end record;
   
   
   
   type KIBewegungPlanArray is array (KartenDatentypen.Stadtfeld'Range) of KartenRecords.AchsenKartenfeldPositivRecord;
   type TransporterArray is array (EinheitStadtDatentypen.MaximaleStädte'First .. 5) of EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   type EinheitMeldungenArray is array (EinheitStadtDatentypen.Einheit_Meldung_Art_Enum'Range) of EinheitStadtDatentypen.Einheit_Meldung_Enum;

   type EinheitenGebautRecord is record
      
      ID : EinheitStadtDatentypen.EinheitenIDMitNullWert;
      Position : KartenRecords.AchsenKartenfeldPositivRecord;
      Heimatstadt : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      
      Lebenspunkte : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      Bewegungspunkte : EinheitStadtDatentypen.BewegungFloat;
      Erfahrungspunkte : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      Rang : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      
      Beschäftigung : SystemDatentypen.Tastenbelegung_Enum;
      BeschäftigungNachfolger : SystemDatentypen.Tastenbelegung_Enum;
      
      Beschäftigungszeit : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      BeschäftigungszeitNachfolger : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      
      KIZielKoordinaten : KartenRecords.AchsenKartenfeldPositivRecord;
      KIBeschäftigt : KIDatentypen.Einheit_Aufgabe_Enum;
      KIBewegungPlan : KIBewegungPlanArray;
      
      Transportiert : TransporterArray;
      WirdTransportiert : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
      
      Meldungen : EinheitMeldungenArray;
      
   end record;
   
   
   
   type KampfwerteRecord is record
      
      Angriff : EinheitStadtDatentypen.ProduktionFeld;
      Verteidigung : EinheitStadtDatentypen.ProduktionFeld;
      
   end record;



   type EinwohnerArbeiterArray is array (1 .. 2) of EinheitStadtDatentypen.ProduktionFeld;
   type GebäudeVorhandenArray is array (EinheitStadtDatentypen.GebäudeID'Range) of Boolean;
   type StadtMeldungenArray is array (EinheitStadtDatentypen.Stadt_Meldung_Art_Enum'Range) of EinheitStadtDatentypen.Stadt_Meldung_Enum;
   type UmgebungBewirtschaftungArray is array (KartenDatentypen.LoopRangeMinusDreiZuDrei'Range, KartenDatentypen.LoopRangeMinusDreiZuDrei'Range) of Boolean;
   type PermanenteKostenArray is array (EinheitStadtDatentypen.Permanente_Kosten_Verwendet_Enum'Range) of EinheitStadtDatentypen.GesamtePermanenteKosten;

   type StadtGebautRecord is record
      
      ID : KartenDatentypen.Karten_Verbesserung_Stadt_ID_Enum;
      Position : KartenRecords.AchsenKartenfeldPositivRecord;
      EinwohnerArbeiter : EinwohnerArbeiterArray;
      
      Nahrungsmittel : EinheitStadtDatentypen.GesamtproduktionStadt;
      Nahrungsproduktion : EinheitStadtDatentypen.GesamtproduktionStadt;
      Ressourcen : EinheitStadtDatentypen.KostenLager;
      Produktionrate : EinheitStadtDatentypen.GesamtproduktionStadt;
      Geldgewinnung : EinheitStadtDatentypen.GesamtproduktionStadt;
      PermanenteKostenPosten : PermanenteKostenArray;
      
      Forschungsrate : EinheitStadtDatentypen.GesamtproduktionStadt;
      Bauprojekt : Natural;
      Bauzeit : EinheitStadtDatentypen.KostenLager;

      Korruption : EinheitStadtDatentypen.GesamtproduktionStadt;
      GebäudeVorhanden : GebäudeVorhandenArray;
      Name : Unbounded_Wide_Wide_String;

      UmgebungBewirtschaftung : UmgebungBewirtschaftungArray;
      UmgebungGröße : KartenDatentypen.LoopRangeMinusDreiZuDrei;
      
      Meldungen : StadtMeldungenArray;
      
      KIBeschäftigung : KIDatentypen.Stadt_Aufgabe_Enum;
      
   end record;

end EinheitStadtRecords;
