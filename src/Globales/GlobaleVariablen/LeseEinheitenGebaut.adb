pragma SPARK_Mode (On);

with KartenKonstanten;
with EinheitenKonstanten;

with LeseEinheitenDatenbank;

with Karten;

package body LeseEinheitenGebaut is

   function ID
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.EinheitenIDMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID;
      
   end ID;
   
  
   
   function Position
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
        or
          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position := KartenKonstanten.LeerKartenPosition;

      else
         null;
      end if;
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position;
      
   end Position;
   
   
   
   function Heimatstadt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Heimatstadt;
      
   end Heimatstadt;
   
   
      
   function Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Lebenspunkte
   is begin
      
     -- if
     --   GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
     --   > LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
     --                                                  IDExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID)
     -- then
     --    GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
     --      := LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
     --                                                      IDExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID);
         
    --  else
    --     null;
    --  end if;
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte;
      
   end Lebenspunkte;
   
   
   
   function Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.VorhandeneBewegungspunkte
   is begin
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte < EinheitenKonstanten.LeerEinheit.Bewegungspunkte
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := EinheitenKonstanten.LeerEinheit.Bewegungspunkte;
         
      else
         null;
      end if;
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte;
      
   end Bewegungspunkte;
   
   
   
   function Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte
        > LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                      IDExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID)
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte
           := LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                          IDExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID);

      else
         null;
      end if;
        
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte;
      
   end Erfahrungspunkte;
   
   
   
   function Rang
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang
        > LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                IDExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID)
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang
           := LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                    IDExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID);
      else
         null;
      end if;

      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang;
      
   end Rang;
      
   
   
   function Beschäftigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return SystemDatentypen.Tastenbelegung_Enum
   is begin
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung = SystemKonstanten.LeerTastenbelegungKonstante
        or
          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung in SystemDatentypen.Tastenbelegung_Befehle_Enum
      then
         null;
         
      else
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := SystemKonstanten.LeerTastenbelegungKonstante;
      end if;

      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung;
      
   end Beschäftigung;
   
   
   
   function BeschäftigungNachfolger
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return SystemDatentypen.Tastenbelegung_Enum
   is begin
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger = SystemKonstanten.LeerTastenbelegungKonstante
        or
          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger in SystemDatentypen.Tastenbelegung_Befehle_Enum
      then
         null;
         
      else
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger := SystemKonstanten.LeerTastenbelegungKonstante;
      end if;
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger;
      
   end BeschäftigungNachfolger;
   
   
      
   function Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit;
      
   end Beschäftigungszeit;
   
   
   
   function BeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger;
      
   end BeschäftigungszeitNachfolger;
   
   
      
   function KIZielKoordinaten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
        or
          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position := KartenKonstanten.LeerKartenPosition;

      else
         null;
      end if;
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten;
      
   end KIZielKoordinaten;
   
   
   
   function KIBeschäftigt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt;
      
   end KIBeschäftigt;
   
   
   
   function KIBewegungPlan
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PlanschrittExtern : in KartenDatentypen.Stadtfeld)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (PlanschrittExtern).YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
        or
          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (PlanschrittExtern).XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (PlanschrittExtern) := KartenKonstanten.LeerKartenPosition;

      else
         null;
      end if;
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (PlanschrittExtern);
      
   end KIBewegungPlan;
   
   
      
   function Transportiert
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PlatzExtern : in EinheitStadtDatentypen.Transportplätze)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (PlatzExtern);
      
   end Transportiert;
   
   
   
   function WirdTransportiert
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).WirdTransportiert;
      
   end WirdTransportiert;
      
   
   
   function Meldungen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      WelcheMeldungExtern : in EinheitStadtDatentypen.Einheit_Meldung_Art_Enum)
      return EinheitStadtDatentypen.Einheit_Meldung_Enum
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Meldungen (WelcheMeldungExtern);
      
   end Meldungen;
   
   
   
   function GanzerEintrag
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtRecords.EinheitenGebautRecord
   is begin
      
      return GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer);
      
   end GanzerEintrag;

end LeseEinheitenGebaut;
