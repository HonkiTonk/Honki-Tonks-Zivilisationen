with KartenRecordKonstanten;
with EinheitenRecordKonstanten;
with GebautVariablen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with SchreibeWeltkarte;

package body SchreibeEinheitenGebaut is

   procedure ID
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID := IDExtern;
      
   end ID;
   
   
   
   procedure Koordinaten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitentauschExtern : in Boolean)
   is begin
      
      case
        LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern).EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            null;
            
         when others =>
            SchreibeWeltkarte.EinheitEntfernen (KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KoordinatenAktuell := KoordinatenExtern;
      
      SchreibeWeltkarte.EinheitSchreiben (KoordinatenExtern        => KoordinatenExtern,
                                          EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                          EinheitentauschExtern    => EinheitentauschExtern);
      
   end Koordinaten;
   
   
   
   procedure Heimatstadt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      HeimatstadtExtern : in StadtDatentypen.MaximaleStädteMitNullWert)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Heimatstadt := HeimatstadtExtern;
      
   end Heimatstadt;
   
   
   
   procedure Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LebenspunkteExtern : in EinheitenDatentypen.Lebenspunkte;
      RechnenSetzenExtern : in Boolean)
   is
      use type EinheitenDatentypen.Lebenspunkte;
   begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            MaximaleLebenspunkte := LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                 IDExtern    => GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID);
            
            if
              GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte + LebenspunkteExtern >= MaximaleLebenspunkte
            then
               GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte := MaximaleLebenspunkte;
               
               -- Wäre es sinnvoll das auszulagern? Scheint eher nicht der Fall zu sein. äöü
               case
                 GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Aufgabe
               is
                  when AufgabenDatentypen.Heilen_Enum =>
                     Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BeschäftigungExtern     => EinheitenKonstanten.LeerBeschäftigung);
                     Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                          ZeitExtern               => EinheitenKonstanten.LeerBeschäftigungszeit,
                                          RechnenSetzenExtern      => False);
                  
                  when others =>
                     null;
               end case;
               
            elsif
              GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte + LebenspunkteExtern <= EinheitenKonstanten.LeerLebenspunkte
            then
               GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte := EinheitenKonstanten.LeerLebenspunkte;
               
            else
               GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte
                 := GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte + LebenspunkteExtern;
            end if;
            
         when False =>
            GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte := LebenspunkteExtern;
      end case;
      
   end Lebenspunkte;
   
   
   
   procedure Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BewegungspunkteExtern : in EinheitenDatentypen.Bewegungspunkte;
      RechnenSetzenExtern : in Boolean)
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            MaximaleBewegungspunkte := LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                       IDExtern    => GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID);
            
            if
              GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte + BewegungspunkteExtern >= MaximaleBewegungspunkte
            then
               GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte := MaximaleBewegungspunkte;
               
            elsif
              GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte + BewegungspunkteExtern <= EinheitenKonstanten.LeerBewegungspunkte
            then
               GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte := EinheitenKonstanten.LeerBewegungspunkte;
                 
            else
               GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte
                 := GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte + BewegungspunkteExtern;
            end if;
            
         when False =>
            GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte := BewegungspunkteExtern;
      end case;
      
   end Bewegungspunkte;
   
   
   
   procedure Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ErfahrungspunkteExtern : in KampfDatentypen.ErfahrungspunkteVorhanden;
      AddierenSetzenExtern : in Boolean)
   is
      use type KampfDatentypen.Erfahrungspunkte;
   begin
      
      case
        AddierenSetzenExtern
      is
         when True =>
            Beförderungsgrenze := LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                               IDExtern    => GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID);
            
            if
              GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte + ErfahrungspunkteExtern >= Beförderungsgrenze
            then
               GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte
                 := GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte + ErfahrungspunkteExtern - Beförderungsgrenze;
               
               Rang (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
            else
               GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte :=
                 GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte + ErfahrungspunkteExtern;
            end if;
            
         when False =>
            GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte := ErfahrungspunkteExtern;
      end case;
      
   end Erfahrungspunkte;
   
   
   
   procedure Rang
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type KampfDatentypen.Erfahrungspunkte;
   begin
      
      if
        GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Rang + 1
        > LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                IDExtern    => GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID)
      then
         null;
                           
      else
         GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Rang := GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Rang + 1;
      end if;
      
   end Rang;
      
   
   
   procedure Beschäftigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BeschäftigungExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Aufgabe := BeschäftigungExtern;
      
   end Beschäftigung;
   
   
   
   procedure BeschäftigungNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BeschäftigungExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Aufgabe := BeschäftigungExtern;
      
   end BeschäftigungNachfolger;
      
   
   
   procedure Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ZeitExtern : in ProduktionDatentypen.Arbeitszeit;
      RechnenSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Arbeitszeit;
   begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit + ZeitExtern >= ProduktionDatentypen.Arbeitszeit'Last
            then
               GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit := ProduktionDatentypen.Arbeitszeit'Last;
               
            elsif
              GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit + ZeitExtern <= EinheitenKonstanten.LeerBeschäftigungszeit
            then
               GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit := EinheitenKonstanten.LeerBeschäftigungszeit;
               
            else
               GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit :=
                 GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit + ZeitExtern;
            end if;
            
         when False =>
            GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit := ZeitExtern;
      end case;
      
   end Beschäftigungszeit;
   
   
   
   procedure BeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ZeitExtern : in ProduktionDatentypen.Arbeitszeit;
      RechnenSetzenExtern : in Boolean)
   is
      use type ProduktionDatentypen.Arbeitszeit;
   begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            if
              GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit + ZeitExtern >= ProduktionDatentypen.Arbeitszeit'Last
            then
               GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit := ProduktionDatentypen.Arbeitszeit'Last;
               
            elsif
              GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit + ZeitExtern <= EinheitenKonstanten.LeerBeschäftigungszeit
            then
               GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit := EinheitenKonstanten.LeerBeschäftigungszeit;
               
            else
               GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit :=
                 GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit + ZeitExtern;
            end if;
            
         when False =>
            GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit := ZeitExtern;
      end case;
      
   end BeschäftigungszeitNachfolger;
      
   
   
   procedure KIZielKoordinaten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIZielKoordinaten := KoordinatenExtern;
      
   end KIZielKoordinaten;
   
   
   
   procedure KIBeschäftigt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIBeschäftigt := AufgabeExtern;
      
   end KIBeschäftigt;
   
   
      
   procedure KIZielKoordinatenNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIZielKoordinatenNachfolger := KoordinatenExtern;
      
   end KIZielKoordinatenNachfolger;
   
   
   
   procedure KIBeschäftigtNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIBeschäftigtNachfolger := AufgabeExtern;
      
   end KIBeschäftigtNachfolger;
   
   
   
   procedure KIVerbesserung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BeschäftigungExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIVerbesserung := BeschäftigungExtern;
      
   end KIVerbesserung;
   
   
   
   procedure KIBewegungPlan
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PlanplatzExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
   is begin
      
      GebautVariablen.EinheitenBewegungsplan (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer) (PlanplatzExtern) := KoordinatenExtern;
      
   end KIBewegungPlan;
   
   
   
   procedure KIBewegungsplanLeeren
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      GebautVariablen.EinheitenBewegungsplan (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer) := (others => KartenRecordKonstanten.LeerKoordinate);
      
   end KIBewegungsplanLeeren;
   
   
   
   procedure Transportiert
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      LadungsplatzExtern : in EinheitenDatentypen.Transportplätze)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Transportiert (LadungsplatzExtern) := LadungExtern;
      
   end Transportiert;
   
   
   
   procedure WirdTransportiert
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      TransporterExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).WirdTransportiert := TransporterExtern;
      
   end WirdTransportiert;
   
   
      
   procedure Meldungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      MeldungExtern : in EinheitenDatentypen.Einheit_Meldung_Enum;
      WelcheMeldungExtern : in EinheitenDatentypen.Einheit_Meldung_Art_Enum)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Meldungen (WelcheMeldungExtern) := MeldungExtern;
      
   end Meldungen;
   
   
      
   procedure LeerMeldungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Meldungen := (others => EinheitenDatentypen.Leer_Einheit_Meldung_Enum);
      
   end LeerMeldungen;
   
   
   
   procedure Nullsetzung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
              
      SchreibeWeltkarte.EinheitEntfernen (KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                          EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                                           
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer) := EinheitenRecordKonstanten.LeerEinheit;
      
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
                   KoordinatenExtern        => KoordinatenExtern,
                   EinheitentauschExtern    => False);
      
      Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                   HeimatstadtExtern        => StadtNummerExtern);
      
      Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                    LebenspunkteExtern       => LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                             IDExtern    => IDExtern),
                    RechnenSetzenExtern      => False);
      
      Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                       BewegungspunkteExtern    => LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                   IDExtern    => IDExtern),
                       RechnenSetzenExtern      => False);
      
   end Standardwerte;
   
   
   
   procedure GanzerEintrag
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      EintragExtern : in EinheitenRecords.EinheitenGebautRecord)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer) := EintragExtern;
      
      GebautVariablen.EinheitenBewegungsplan (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer) := (others => KartenRecordKonstanten.LeerKoordinate);
      
   end GanzerEintrag;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      GebautVariablen.EinheitenGebaut := (others => (others => EinheitenRecordKonstanten.LeerEinheit));
      
   end Standardeinstellungen;

end SchreibeEinheitenGebaut;
