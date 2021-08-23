pragma SPARK_Mode (On);

package body LeseEinheitenGebaut is

   function ID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.EinheitenIDMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID;
      
   end ID;
   
  
   
   function Position
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position;
      
   end Position;
   
   
   
   function Heimatstadt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Heimatstadt;
      
   end Heimatstadt;
   
   
      
   function Lebenspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte;
      
   end Lebenspunkte;
   
   
   
   function Bewegungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.BewegungFloat
   is begin
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte < 0.00
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := 0.00;
         
      else
         null;
      end if;
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte;
      
   end Bewegungspunkte;
   
   
   
   function Erfahrungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte;
      
   end Erfahrungspunkte;
   
   
   
   function Rang
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang;
      
   end Rang;
      
   
   
   function Beschäftigung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.Tastenbelegung_Enum
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung;
      
   end Beschäftigung;
   
   
   
   function BeschäftigungNachfolger
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.Tastenbelegung_Enum
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger;
      
   end BeschäftigungNachfolger;
   
   
      
   function Beschäftigungszeit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit;
      
   end Beschäftigungszeit;
   
   
   
   function BeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger;
      
   end BeschäftigungszeitNachfolger;
   
   
      
   function KIZielKoordinaten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten;
      
   end KIZielKoordinaten;
   
   
   
   function KIBeschäftigt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt;
      
   end KIBeschäftigt;
   
   
   
   function KIBewegungPlan
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PlanschrittExtern : in GlobaleDatentypen.Stadtfeld)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (PlanschrittExtern);
      
   end KIBewegungPlan;
   
   
      
   function Transportiert
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PlatzExtern : in GlobaleDatentypen.MaximaleEinheiten)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (PlatzExtern);
      
   end Transportiert;
   
   
   
   function WirdTransportiert
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).WirdTransportiert;
      
   end WirdTransportiert;
      
   
   
   function Meldungen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      WelcheMeldungExtern : in GlobaleDatentypen.Einheit_Meldung_Art_Enum)
      return GlobaleDatentypen.Einheit_Meldung_Enum
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Meldungen (WelcheMeldungExtern);
      
   end Meldungen;
   
   
   
   function GanzerEintrag
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.EinheitenGebautRecord
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer);
      
   end GanzerEintrag;

end LeseEinheitenGebaut;
