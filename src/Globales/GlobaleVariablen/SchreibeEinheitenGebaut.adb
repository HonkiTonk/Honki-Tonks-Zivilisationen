pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KampfDatentypen; use KampfDatentypen;
with StadtDatentypen; use StadtDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with EinheitenKonstanten;
with KartenRecordKonstanten;
with EinheitenRecordKonstanten;

with LeseEinheitenDatenbank;

package body SchreibeEinheitenGebaut is

   procedure ID
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID := IDExtern;
      
   end ID;
   
   
   
   procedure Koordinaten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KoordinatenAktuell := KoordinatenExtern;
      
   end Koordinaten;
   
   
   
   procedure Heimatstadt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      HeimatstadtExtern : in StadtDatentypen.MaximaleStädteMitNullWert)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Heimatstadt := HeimatstadtExtern;
      
   end Heimatstadt;
   
   
   
   procedure Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LebenspunkteExtern : in EinheitenDatentypen.Lebenspunkte;
      RechnenSetzenExtern : in KartenDatentypen.UmgebungsbereichEins)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when 1 =>
            MaximaleLebenspunkte := LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                 IDExtern    => SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID);
            
            if
              SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte + LebenspunkteExtern >= MaximaleLebenspunkte
            then
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte := MaximaleLebenspunkte;
               
               ------------------------------------- Wäre es sinnvoll das auszulagern? Scheint eher nicht der Fall zu sein.
               case
                 SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Aufgabe
               is
                  when AufgabenDatentypen.Heilen_Enum =>
                     Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BeschäftigungExtern     => EinheitenKonstanten.LeerBeschäftigung);
                     Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                          ZeitExtern               => EinheitenKonstanten.LeerBeschäftigungszeit,
                                          RechnenSetzenExtern      => 0);
                  
                  when others =>
                     null;
               end case;
               
            else
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte
                 := SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte + LebenspunkteExtern;
            end if;
               
         when -1 =>
            if
              SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte - LebenspunkteExtern < EinheitenKonstanten.LeerLebenspunkte
            then
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte := EinheitenKonstanten.LeerLebenspunkte;
               
            else
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte
                 := SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte - LebenspunkteExtern;
            end if;
            
         when 0 =>
            SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte := LebenspunkteExtern;
      end case;
      
   end Lebenspunkte;
   
   
   
   procedure Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BewegungspunkteExtern : in EinheitenDatentypen.BewegungFloat;
      RechnenSetzenExtern : in KartenDatentypen.UmgebungsbereichEins)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when 1 =>
            MaximaleBewegungspunkte := LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                       IDExtern    => SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID);
            
            if
              SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte + BewegungspunkteExtern >= MaximaleBewegungspunkte
            then
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte := MaximaleBewegungspunkte;
                 
            else
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte
                 := SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte + BewegungspunkteExtern;
            end if;
            
         when -1 =>
            if
              SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte - BewegungspunkteExtern < EinheitenKonstanten.LeerBewegungspunkte
            then
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte := EinheitenKonstanten.LeerBewegungspunkte;
                 
            else
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte
                 := SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte - BewegungspunkteExtern;
            end if;
            
         when 0 =>
            SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte := BewegungspunkteExtern;
      end case;
      
   end Bewegungspunkte;
   
   
   
   procedure Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ErfahrungspunkteExtern : in KampfDatentypen.Kampfwerte;
      AddierenSetzenExtern : in Boolean)
   is begin
      
      case
        AddierenSetzenExtern
      is
         when True =>
            Beförderungsgrenze := LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                               IDExtern    => SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID);
            
            if
              SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte + ErfahrungspunkteExtern >= Beförderungsgrenze
            then
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte
                 := SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte + ErfahrungspunkteExtern - Beförderungsgrenze;
               
               Rang (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
            else
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte :=
                 SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte + ErfahrungspunkteExtern;
            end if;
            
         when False =>
            SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte := ErfahrungspunkteExtern;
      end case;
      
   end Erfahrungspunkte;
   
   
   
   procedure Rang
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      if
        SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Rang + 1
        > LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                IDExtern    => SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID)
      then
         null;
                           
      else
         SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Rang := SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Rang + 1;
      end if;
      
   end Rang;
      
   
   
   procedure Beschäftigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BeschäftigungExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Aufgabe := BeschäftigungExtern;
      
   end Beschäftigung;
   
   
   
   procedure BeschäftigungNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BeschäftigungExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Aufgabe := BeschäftigungExtern;
      
   end BeschäftigungNachfolger;
      
   
   
   procedure Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ZeitExtern : in ProduktionDatentypen.ArbeitszeitVorhanden;
      RechnenSetzenExtern : in KartenDatentypen.UmgebungsbereichEins)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when 1 =>
            if
              SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit + ZeitExtern >= ProduktionDatentypen.ArbeitszeitVorhanden'Last
            then
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit := ProduktionDatentypen.ArbeitszeitVorhanden'Last;
               
            else
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit :=
                 SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit + ZeitExtern;
            end if;
            
         when -1 =>
            if
              SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit - ZeitExtern <= EinheitenKonstanten.LeerBeschäftigungszeit
            then
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit := EinheitenKonstanten.LeerBeschäftigungszeit;
               
            else
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit :=
                 SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit - ZeitExtern;
            end if;
            
         when 0 =>
            SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit := ZeitExtern;
      end case;
      
   end Beschäftigungszeit;
   
   
   
   procedure BeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ZeitExtern : in ProduktionDatentypen.ArbeitszeitVorhanden;
      RechnenSetzenExtern : in KartenDatentypen.UmgebungsbereichEins)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when 1 =>
            if
              SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit + ZeitExtern >= ProduktionDatentypen.ArbeitszeitVorhanden'Last
            then
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit := ProduktionDatentypen.ArbeitszeitVorhanden'Last;
               
            else
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit :=
                 SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit + ZeitExtern;
            end if;
            
         when -1 =>
            if
              SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit - ZeitExtern <= EinheitenKonstanten.LeerBeschäftigungszeit
            then
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit := EinheitenKonstanten.LeerBeschäftigungszeit;
               
            else
               SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit :=
                 SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit - ZeitExtern;
            end if;
            
         when 0 =>
            SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit := ZeitExtern;
      end case;
      
   end BeschäftigungszeitNachfolger;
      
   
   
   procedure KIZielKoordinaten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIZielKoordinaten := KoordinatenExtern;
      
   end KIZielKoordinaten;
   
   
   
   procedure KIBeschäftigt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIBeschäftigt := AufgabeExtern;
      
   end KIBeschäftigt;
   
   
      
   procedure KIZielKoordinatenNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIZielKoordinatenNachfolger := KoordinatenExtern;
      
   end KIZielKoordinatenNachfolger;
   
   
   
   procedure KIBeschäftigtNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIBeschäftigtNachfolger := AufgabeExtern;
      
   end KIBeschäftigtNachfolger;
   
   
   
   procedure KIVerbesserung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BeschäftigungExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIVerbesserung := BeschäftigungExtern;
      
   end KIVerbesserung;
   
   
   
   procedure KIBewegungPlan
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PlanplatzExtern : in KartenDatentypen.Stadtfeld)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIBewegungPlan (PlanplatzExtern) := KoordinatenExtern;
      
   end KIBewegungPlan;
   
   
   
   procedure KIBewegungsplanLeeren
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIBewegungPlan := (others => KartenRecordKonstanten.LeerKoordinate);
      
   end KIBewegungsplanLeeren;
   
   
   
   procedure Transportiert
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      LadungsplatzExtern : in EinheitenDatentypen.Transportplätze)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Transportiert (LadungsplatzExtern) := LadungExtern;
      
   end Transportiert;
   
   
   
   procedure WirdTransportiert
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      TransporterExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).WirdTransportiert := TransporterExtern;
      
   end WirdTransportiert;
   
   
      
   procedure Meldungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      MeldungExtern : in EinheitenDatentypen.Einheit_Meldung_Enum;
      WelcheMeldungExtern : in EinheitenDatentypen.Einheit_Meldung_Art_Enum)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Meldungen (WelcheMeldungExtern) := MeldungExtern;
      
   end Meldungen;
   
   
   
   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
                                           
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer) := EinheitenRecordKonstanten.LeerEinheit;
      
   end Nullsetzung;
   
   
   
   procedure Standardwerte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StadtNummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert)
   is begin
      
      Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
          IDExtern                 => IDExtern);
      
      Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                   KoordinatenExtern        => KoordinatenExtern);
      
      Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                   HeimatstadtExtern        => StadtNummerExtern);
      
      Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                    LebenspunkteExtern       => LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                             IDExtern    => IDExtern),
                    RechnenSetzenExtern      => 0);
      
      Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                       BewegungspunkteExtern    => LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                   IDExtern    => IDExtern),
                       RechnenSetzenExtern      => 0);
      
   end Standardwerte;
   
   
   
   procedure GanzerEintrag
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      EintragExtern : in EinheitenRecords.EinheitenGebautRecord)
   is begin
      
      SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer) := EintragExtern;
      
   end GanzerEintrag;

end SchreibeEinheitenGebaut;
