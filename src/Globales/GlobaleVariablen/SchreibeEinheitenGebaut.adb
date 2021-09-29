pragma SPARK_Mode (On);

with EinheitenKonstanten;

with SchreibeWichtiges;
with LeseEinheitenDatenbank;

package body SchreibeEinheitenGebaut is

   procedure ID
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      IDExtern : in GlobaleDatentypen.EinheitenIDMitNullWert)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID := IDExtern;
      
   end ID;
   
   
   
   procedure Position
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position := PositionExtern;
      
   end Position;
   
   
   
   procedure Heimatstadt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      HeimatstadtExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Heimatstadt := HeimatstadtExtern;
      
   end Heimatstadt;
   
   
   
   procedure Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      LebenspunkteExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      RechnenSetzenExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when 1 =>
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte + LebenspunkteExtern
              >= LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                              IDExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID)
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
                 := LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                 IDExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID);
               
               case
                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung
               is
                  when GlobaleDatentypen.Heilen =>
                     Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BeschäftigungExtern     => GlobaleDatentypen.Leer);
                     Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                          ZeitExtern               => EinheitenKonstanten.LeerEinheit.Beschäftigungszeit,
                                          RechnenSetzenExtern      => 0);
                  
                  when others =>
                     null;
               end case;
               
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
                 := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte + LebenspunkteExtern;
            end if;
               
         when -1 =>
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte - LebenspunkteExtern < GlobaleDatentypen.MaximaleStädteMitNullWert'First
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte := GlobaleDatentypen.MaximaleStädteMitNullWert'First;
               
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte
                 := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte - LebenspunkteExtern;
            end if;
            
         when 0 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte := LebenspunkteExtern;
      end case;
      
   end Lebenspunkte;
   
   
   
   procedure Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BewegungspunkteExtern : in GlobaleDatentypen.BewegungFloat;
      RechnenSetzenExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when 1 =>
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte + BewegungspunkteExtern
              > LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                IDExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID)
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte
                 := LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                    IDExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID);
                 
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte
                 := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte + BewegungspunkteExtern;
            end if;
            
         when -1 =>
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte - BewegungspunkteExtern < EinheitenKonstanten.LeerEinheit.Bewegungspunkte
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := EinheitenKonstanten.LeerEinheit.Bewegungspunkte;
                 
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte
                 := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte - BewegungspunkteExtern;
            end if;
            
         when 0 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte := BewegungspunkteExtern;
      end case;
      
   end Bewegungspunkte;
   
   
   
   procedure Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      ErfahrungspunkteExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      AddierenSetzenExtern : in Boolean)
   is begin
      
      case
        AddierenSetzenExtern
      is
         when True =>
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte + ErfahrungspunkteExtern
              > LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                            IDExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID)
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte
                 := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte + ErfahrungspunkteExtern
                 - LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                               IDExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID);
               Rang (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                 
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte :=
                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte + ErfahrungspunkteExtern;
            end if;
            
         when False =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Erfahrungspunkte := ErfahrungspunkteExtern;
      end case;
      
   end Erfahrungspunkte;
   
   
   
   procedure Rang
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang + 1
        > LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                IDExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID)
      then
         null;
                           
      else
         GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang :=
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Rang + 1;
      end if;
      
   end Rang;
      
   
   
   procedure Beschäftigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BeschäftigungExtern : in GlobaleDatentypen.Tastenbelegung_Enum)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := BeschäftigungExtern;
      
   end Beschäftigung;
   
   
   
   procedure BeschäftigungNachfolger
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BeschäftigungExtern : in GlobaleDatentypen.Tastenbelegung_Enum)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungNachfolger := BeschäftigungExtern;
      
   end BeschäftigungNachfolger;
      
   
   
   procedure Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      ZeitExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      RechnenSetzenExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when 1 =>
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit + ZeitExtern > GlobaleDatentypen.MaximaleStädteMitNullWert'Last
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := GlobaleDatentypen.MaximaleStädteMitNullWert'Last;
               
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit :=
                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit + ZeitExtern;
            end if;
            
         when -1 =>
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit - ZeitExtern < EinheitenKonstanten.LeerEinheit.Beschäftigungszeit
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := EinheitenKonstanten.LeerEinheit.Beschäftigungszeit;
               
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit :=
                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit - ZeitExtern;
            end if;
            
         when 0 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigungszeit := ZeitExtern;
      end case;
      
   end Beschäftigungszeit;
   
   
   
   procedure BeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      ZeitExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      RechnenSetzenExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when 1 =>
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger + ZeitExtern > GlobaleDatentypen.MaximaleStädteMitNullWert'Last
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger := GlobaleDatentypen.MaximaleStädteMitNullWert'Last;
               
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger :=
                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger + ZeitExtern;
            end if;
            
         when -1 =>
            if
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger - ZeitExtern
              < EinheitenKonstanten.LeerEinheit.BeschäftigungszeitNachfolger
            then
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger := EinheitenKonstanten.LeerEinheit.BeschäftigungszeitNachfolger;
               
            else
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger :=
                 GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger - ZeitExtern;
            end if;
            
         when 0 =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).BeschäftigungszeitNachfolger := ZeitExtern;
      end case;
      
   end BeschäftigungszeitNachfolger;
      
   
   
   procedure KIZielKoordinaten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten := KoordinatenExtern;
      
   end KIZielKoordinaten;
   
   
   
   procedure KIBeschäftigt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := AufgabeExtern;
      
   end KIBeschäftigt;
   
   
   
   procedure KIBewegungPlan
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PlanpositionExtern : in GlobaleDatentypen.Stadtfeld)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (PlanpositionExtern) := PositionExtern;
      
   end KIBewegungPlan;
   
   
      
   procedure Transportiert
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      LadungExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert;
      LadungspositionExtern : in GlobaleDatentypen.MaximaleStädte)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (LadungspositionExtern) := LadungExtern;
      
   end Transportiert;
   
   
   
   procedure WirdTransportiert
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      TransporterExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).WirdTransportiert := TransporterExtern;
      
   end WirdTransportiert;
   
   
      
   procedure Meldungen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      MeldungExtern : in GlobaleDatentypen.Einheit_Meldung_Enum;
      WelcheMeldungExtern : in GlobaleDatentypen.Einheit_Meldung_Art_Enum)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Meldungen (WelcheMeldungExtern) := MeldungExtern;
      
   end Meldungen;
   
   
   
   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID = EinheitenKonstanten.LeerID
      then
         null;
         
      else
         case
           LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                              IDExtern    => (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID))
         is
            when GlobaleDatentypen.Arbeiter =>
               SchreibeWichtiges.AnzahlArbeiter (RasseExtern     => EinheitRasseNummerExtern.Rasse,
                                                 PlusMinusExtern => False);
            
            when GlobaleDatentypen.Nahkämpfer | GlobaleDatentypen.Fernkämpfer | GlobaleDatentypen.Beides =>
               SchreibeWichtiges.AnzahlKämpfer (RasseExtern     => EinheitRasseNummerExtern.Rasse,
                                                 PlusMinusExtern => False);
            
            when GlobaleDatentypen.Sonstiges =>
               SchreibeWichtiges.AnzahlSonstiges (RasseExtern     => EinheitRasseNummerExtern.Rasse,
                                                  PlusMinusExtern => False);
            
            when others =>
               null;
         end case;
      end if;
                                           
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer) := EinheitenKonstanten.LeerEinheit;
      
   end Nullsetzung;
   
   
   
   procedure GanzerEintrag
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EintragExtern : in EinheitStadtRecords.EinheitenGebautRecord)
   is begin
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer) := EintragExtern;
      
   end GanzerEintrag;

end SchreibeEinheitenGebaut;
