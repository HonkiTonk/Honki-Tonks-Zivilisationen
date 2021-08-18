pragma SPARK_Mode (On);

package body SchreibeEinheitenGebaut is

   procedure ID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.EinheitenID)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID := IDExtern;
      
   end ID;
   
   
   
   procedure Position
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position := PositionExtern;
      
   end Position;
   
   
   
   procedure Heimatstadt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      HeimatstadtExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Heimatstadt := HeimatstadtExtern;
      
   end Heimatstadt;
   
   
   
   procedure Lebenspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      LebenspunkteExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      SetzenÄndernExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      case
        SetzenÄndernExtern
      is
         when 0 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte := LebenspunkteExtern;
            
         when others =>
            if
              Natural (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte) + Integer (SetzenÄndernExtern) * Natural (LebenspunkteExtern)
              > Positive (GlobaleDatentypen.MaximaleStädteMitNullWert'Last)
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte := GlobaleDatentypen.MaximaleStädteMitNullWert'Last;
               
            elsif
              Natural (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte) + Integer (SetzenÄndernExtern) * Natural (LebenspunkteExtern)
              < Natural (GlobaleDatentypen.MaximaleStädteMitNullWert'First)
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte := GlobaleDatentypen.MaximaleStädteMitNullWert'First;
               
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
                 := GlobaleDatentypen.MaximaleStädteMitNullWert (Natural (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte)
                                                                  + Integer (SetzenÄndernExtern) * Natural (LebenspunkteExtern));
            end if;
      end case;
      
   end Lebenspunkte;
   
   
   
   procedure Bewegungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BewegungspunkteExtern : in Float;
      SetzenÄndernExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      case
        SetzenÄndernExtern
      is
         when 0 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := BewegungspunkteExtern;
            
         when others =>
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte + Float (SetzenÄndernExtern) * BewegungspunkteExtern
              > Float'Last
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := Float'Last;
               
            elsif
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte + Float (SetzenÄndernExtern) * BewegungspunkteExtern
              < Float'First
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := Float'First;
               
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := BewegungspunkteExtern + Float (SetzenÄndernExtern) * BewegungspunkteExtern;
            end if;
      end case;
      
   end Bewegungspunkte;
   
   
   
   procedure Erfahrungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ErfahrungspunkteExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      SetzenÄndernExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      case
        SetzenÄndernExtern
      is
         when 0 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte := ErfahrungspunkteExtern;
            
         when others =>
            if
              Natural (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte) + Integer (SetzenÄndernExtern) * Natural (ErfahrungspunkteExtern)
              > Positive (GlobaleDatentypen.MaximaleStädteMitNullWert'Last)
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte := GlobaleDatentypen.MaximaleStädteMitNullWert'Last;
               
            elsif
              Natural (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte) + Integer (SetzenÄndernExtern) * Natural (ErfahrungspunkteExtern)
              < Natural (GlobaleDatentypen.MaximaleStädteMitNullWert'First)
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte := GlobaleDatentypen.MaximaleStädteMitNullWert'First;
               
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte :=
                 GlobaleDatentypen.MaximaleStädteMitNullWert (Natural (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte)
                                                               + Integer (SetzenÄndernExtern) * Natural (ErfahrungspunkteExtern));
            end if;
      end case;
      
   end Erfahrungspunkte;
   
   
   
   procedure Rang
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      RangExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      SetzenÄndernExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      case
        SetzenÄndernExtern
      is
         when 0 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang := RangExtern;
            
         when others =>
            if
              Natural (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang) + Integer (SetzenÄndernExtern) * Natural (RangExtern)
              > Positive (GlobaleDatentypen.MaximaleStädteMitNullWert'Last)
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang := GlobaleDatentypen.MaximaleStädteMitNullWert'Last;
               
            elsif
              Natural (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang) + Integer (SetzenÄndernExtern) * Natural (RangExtern)
              < Natural (GlobaleDatentypen.MaximaleStädteMitNullWert'First)
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang := GlobaleDatentypen.MaximaleStädteMitNullWert'First;
               
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang :=
                 GlobaleDatentypen.MaximaleStädteMitNullWert (Natural (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang)
                                                               + Integer (SetzenÄndernExtern) * Natural (RangExtern));
            end if;
      end case;
      
   end Rang;
      
   
   
   procedure Beschäftigung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BeschäftigungExtern : in GlobaleDatentypen.Tastenbelegung_Enum)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := BeschäftigungExtern;
      
   end Beschäftigung;
   
   
   
   procedure BeschäftigungNachfolger
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BeschäftigungExtern : in GlobaleDatentypen.Tastenbelegung_Enum)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger := BeschäftigungExtern;
      
   end BeschäftigungNachfolger;
      
   
   
   procedure Beschäftigungszeit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ZeitExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      SetzenÄndernExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      case
        SetzenÄndernExtern
      is
         when 0 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := ZeitExtern;
            
         when others =>
            if
              Natural (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit) + Integer (SetzenÄndernExtern) * Natural (ZeitExtern)
              > Positive (GlobaleDatentypen.MaximaleStädteMitNullWert'Last)
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := GlobaleDatentypen.MaximaleStädteMitNullWert'Last;
               
            elsif
              Natural (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit) + Integer (SetzenÄndernExtern) * Natural (ZeitExtern)
              < Natural (GlobaleDatentypen.MaximaleStädteMitNullWert'First)
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := GlobaleDatentypen.MaximaleStädteMitNullWert'First;
               
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit :=
                 GlobaleDatentypen.MaximaleStädteMitNullWert (Natural (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit)
                                                               + Integer (SetzenÄndernExtern) * Natural (ZeitExtern));
            end if;
      end case;
      
   end Beschäftigungszeit;
   
   
   
   procedure BeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ZeitExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      SetzenÄndernExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      case
        SetzenÄndernExtern
      is
         when 0 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger := ZeitExtern;
            
         when others =>
            if
              Natural (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger) + Integer (SetzenÄndernExtern) * Natural (ZeitExtern)
              > Positive (GlobaleDatentypen.MaximaleStädteMitNullWert'Last)
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger := GlobaleDatentypen.MaximaleStädteMitNullWert'Last;
               
            elsif
              Natural (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger) + Integer (SetzenÄndernExtern) * Natural (ZeitExtern)
              < Natural (GlobaleDatentypen.MaximaleStädteMitNullWert'First)
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger := GlobaleDatentypen.MaximaleStädteMitNullWert'First;
               
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger :=
                 GlobaleDatentypen.MaximaleStädteMitNullWert (Natural (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger)
                                                               + Integer (SetzenÄndernExtern) * Natural (ZeitExtern));
            end if;
      end case;
      
   end BeschäftigungszeitNachfolger;
      
   
   
   procedure KIZielKoordinaten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten := KoordinatenExtern;
      
   end KIZielKoordinaten;
   
   
   
   procedure KIBeschäftigt
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := AufgabeExtern;
      
   end KIBeschäftigt;
   
   
   
   procedure KIBewegungPlan
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      PlanpositionExtern : in GlobaleDatentypen.Stadtfeld)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (PlanpositionExtern) := PositionExtern;
      
   end KIBewegungPlan;
   
   
      
   procedure Transportiert
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      LadungExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      LadungspositionExtern : in GlobaleDatentypen.MaximaleStädte)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (LadungspositionExtern) := LadungExtern;
      
   end Transportiert;
   
   
   
   procedure WirdTransportiert
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      TransporterExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).WirdTransportiert := TransporterExtern;
      
   end WirdTransportiert;
   
   
      
   procedure Meldungen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      MeldungExtern : in GlobaleDatentypen.Einheit_Meldung_Enum;
      WelcheMeldungExtern : in GlobaleDatentypen.Einheit_Meldung_Art_Enum)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Meldungen (WelcheMeldungExtern) := MeldungExtern;
      
   end Meldungen;

end SchreibeEinheitenGebaut;
