with KartenRecordKonstanten;
with EinheitenRecordKonstanten;
with GebautVariablen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with SchreibeWeltkarte;

package body SchreibeEinheitenGebaut is

   procedure ID
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).ID := IDExtern;
      
   end ID;
   
   
   
   procedure Koordinaten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitentauschExtern : in Boolean)
   is begin
      
      case
        LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern).EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            null;
            
         when others =>
            SchreibeWeltkarte.EinheitEntfernen (KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end case;
      
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).KoordinatenAktuell := KoordinatenExtern;
      
      SchreibeWeltkarte.EinheitSchreiben (KoordinatenExtern        => KoordinatenExtern,
                                          EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                          EinheitentauschExtern    => EinheitentauschExtern);
      
   end Koordinaten;
   
   
   
   procedure Heimatstadt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      HeimatstadtExtern : in StadtDatentypen.MaximaleStädteMitNullWert)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Heimatstadt := HeimatstadtExtern;
      
   end Heimatstadt;
   
   
   
   procedure Lebenspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LebenspunkteExtern : in EinheitenDatentypen.Lebenspunkte;
      RechnenSetzenExtern : in Boolean)
   is
      use type EinheitenDatentypen.Lebenspunkte;
   begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            MaximaleLebenspunkte := LeseEinheitenDatenbank.MaximaleLebenspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                 IDExtern    => GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).ID);
            
            if
              GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Lebenspunkte + LebenspunkteExtern >= MaximaleLebenspunkte
            then
               GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Lebenspunkte := MaximaleLebenspunkte;
               
               -- Wäre es sinnvoll das auszulagern? Scheint eher nicht der Fall zu sein. äöü
               case
                 GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Beschäftigung.Aufgabe
               is
                  when AufgabenDatentypen.Heilen_Enum =>
                     Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                     BeschäftigungExtern     => EinheitenKonstanten.LeerBeschäftigung);
                     Beschäftigungszeit (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                          ZeitExtern               => EinheitenKonstanten.LeerBeschäftigungszeit,
                                          RechnenSetzenExtern      => False);
                  
                  when others =>
                     null;
               end case;
               
            elsif
              GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Lebenspunkte + LebenspunkteExtern <= EinheitenKonstanten.LeerLebenspunkte
            then
               GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Lebenspunkte := EinheitenKonstanten.LeerLebenspunkte;
               
            else
               GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Lebenspunkte
                 := GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Lebenspunkte + LebenspunkteExtern;
            end if;
            
         when False =>
            GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Lebenspunkte := LebenspunkteExtern;
      end case;
      
   end Lebenspunkte;
   
   
   
   procedure Bewegungspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BewegungspunkteExtern : in EinheitenDatentypen.Bewegungspunkte;
      RechnenSetzenExtern : in Boolean)
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            MaximaleBewegungspunkte := LeseEinheitenDatenbank.MaximaleBewegungspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                       IDExtern    => GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).ID);
            
            if
              GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Bewegungspunkte + BewegungspunkteExtern >= MaximaleBewegungspunkte
            then
               GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Bewegungspunkte := MaximaleBewegungspunkte;
               
            elsif
              GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Bewegungspunkte + BewegungspunkteExtern <= EinheitenKonstanten.LeerBewegungspunkte
            then
               GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Bewegungspunkte := EinheitenKonstanten.LeerBewegungspunkte;
                 
            else
               GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Bewegungspunkte
                 := GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Bewegungspunkte + BewegungspunkteExtern;
            end if;
            
         when False =>
            GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Bewegungspunkte := BewegungspunkteExtern;
      end case;
      
   end Bewegungspunkte;
   
   
   
   procedure Erfahrungspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      ErfahrungspunkteExtern : in KampfDatentypen.ErfahrungspunkteVorhanden;
      AddierenSetzenExtern : in Boolean)
   is
      use type KampfDatentypen.Erfahrungspunkte;
   begin
      
      case
        AddierenSetzenExtern
      is
         when True =>
            Beförderungsgrenze := LeseEinheitenDatenbank.Beförderungsgrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                               IDExtern    => GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).ID);
            
            if
              GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Erfahrungspunkte + ErfahrungspunkteExtern >= Beförderungsgrenze
            then
               GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Erfahrungspunkte
                 := GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Erfahrungspunkte + ErfahrungspunkteExtern - Beförderungsgrenze;
               
               Rang (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               
            else
               GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Erfahrungspunkte :=
                 GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Erfahrungspunkte + ErfahrungspunkteExtern;
            end if;
            
         when False =>
            GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Erfahrungspunkte := ErfahrungspunkteExtern;
      end case;
      
   end Erfahrungspunkte;
   
   
   
   procedure Rang
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type KampfDatentypen.Erfahrungspunkte;
   begin
      
      if
        GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Rang + 1
        > LeseEinheitenDatenbank.MaximalerRang (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                IDExtern    => GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).ID)
      then
         null;
                           
      else
         GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Rang
           := GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Rang + 1;
      end if;
      
   end Rang;
   
   
   
   procedure Beschäftigung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BeschäftigungExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Beschäftigung.Aufgabe := BeschäftigungExtern;
      
   end Beschäftigung;
   
   
   
   procedure BeschäftigungNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BeschäftigungExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).BeschäftigungNachfolger.Aufgabe := BeschäftigungExtern;
      
   end BeschäftigungNachfolger;
      
   
   
   procedure Beschäftigungszeit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
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
              GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Beschäftigung.Arbeitszeit + ZeitExtern >= ProduktionDatentypen.Arbeitszeit'Last
            then
               GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Beschäftigung.Arbeitszeit := ProduktionDatentypen.Arbeitszeit'Last;
               
            elsif
              GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Beschäftigung.Arbeitszeit + ZeitExtern <= EinheitenKonstanten.LeerBeschäftigungszeit
            then
               GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Beschäftigung.Arbeitszeit := EinheitenKonstanten.LeerBeschäftigungszeit;
               
            else
               GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Beschäftigung.Arbeitszeit :=
                 GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Beschäftigung.Arbeitszeit + ZeitExtern;
            end if;
            
         when False =>
            GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Beschäftigung.Arbeitszeit := ZeitExtern;
      end case;
      
   end Beschäftigungszeit;
   
   
   
   procedure BeschäftigungszeitNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
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
              GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit + ZeitExtern >= ProduktionDatentypen.Arbeitszeit'Last
            then
               GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit := ProduktionDatentypen.Arbeitszeit'Last;
               
            elsif
              GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit + ZeitExtern <= EinheitenKonstanten.LeerBeschäftigungszeit
            then
               GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit := EinheitenKonstanten.LeerBeschäftigungszeit;
               
            else
               GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit :=
                 GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit + ZeitExtern;
            end if;
            
         when False =>
            GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit := ZeitExtern;
      end case;
      
   end BeschäftigungszeitNachfolger;
      
   
   
   procedure KIZielKoordinaten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).KIZielKoordinaten := KoordinatenExtern;
      
   end KIZielKoordinaten;
   
   
   
   procedure KIBeschäftigt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).KIBeschäftigt := AufgabeExtern;
      
   end KIBeschäftigt;
   
   
      
   procedure KIZielKoordinatenNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).KIZielKoordinatenNachfolger := KoordinatenExtern;
      
   end KIZielKoordinatenNachfolger;
   
   
   
   procedure KIBeschäftigtNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).KIBeschäftigtNachfolger := AufgabeExtern;
      
   end KIBeschäftigtNachfolger;
   
   
   
   procedure KIVerbesserung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      BeschäftigungExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).KIVerbesserung := BeschäftigungExtern;
      
   end KIVerbesserung;
   
   
   
   procedure KIBewegungPlan
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PlanplatzExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
   is begin
      
      GebautVariablen.EinheitenBewegungsplan (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer) (PlanplatzExtern) := KoordinatenExtern;
      
   end KIBewegungPlan;
   
   
   
   procedure KIBewegungsplanLeeren
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      GebautVariablen.EinheitenBewegungsplan (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer) := (others => KartenRecordKonstanten.LeerKoordinate);
      
   end KIBewegungsplanLeeren;
   
   
   
   procedure Transportiert
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      LadungsplatzExtern : in EinheitenDatentypen.Transportplätze)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Transportiert (LadungsplatzExtern) := LadungExtern;
      
   end Transportiert;
   
   
   
   procedure WirdTransportiert
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TransporterExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).WirdTransportiert := TransporterExtern;
      
   end WirdTransportiert;
   
   
      
   procedure Meldungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      MeldungExtern : in EinheitenDatentypen.Einheit_Meldung_Enum;
      WelcheMeldungExtern : in EinheitenDatentypen.Einheit_Meldung_Art_Enum)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Meldungen (WelcheMeldungExtern) := MeldungExtern;
      
   end Meldungen;
   
   
      
   procedure LeerMeldungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Meldungen := (others => EinheitenDatentypen.Leer_Einheit_Meldung_Enum);
      
   end LeerMeldungen;
   
   
   
   procedure Nullsetzung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
              
      SchreibeWeltkarte.EinheitEntfernen (KoordinatenExtern          => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                          EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
                                           
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer) := EinheitenRecordKonstanten.LeerEinheit;
      
   end Nullsetzung;
   
   
   
   procedure Standardwerte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StadtNummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert)
   is begin
      
      Nullsetzung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
          IDExtern                 => IDExtern);
      
      Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                   KoordinatenExtern        => KoordinatenExtern,
                   EinheitentauschExtern    => False);
      
      Heimatstadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                   HeimatstadtExtern        => StadtNummerExtern);
      
      Lebenspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                    LebenspunkteExtern       => LeseEinheitenDatenbank.MaximaleLebenspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                             IDExtern    => IDExtern),
                    RechnenSetzenExtern      => False);
      
      Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                       BewegungspunkteExtern    => LeseEinheitenDatenbank.MaximaleBewegungspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                   IDExtern    => IDExtern),
                       RechnenSetzenExtern      => False);
      
   end Standardwerte;
   
   
   
   procedure GanzerEintrag
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      EintragExtern : in EinheitenRecords.EinheitenGebautRecord)
   is begin
      
      GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer) := EintragExtern;
      
      GebautVariablen.EinheitenBewegungsplan (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer) := (others => KartenRecordKonstanten.LeerKoordinate);
      
   end GanzerEintrag;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      GebautVariablen.EinheitenGebaut := (others => (others => EinheitenRecordKonstanten.LeerEinheit));
      
   end Standardeinstellungen;
   
   
   
   procedure Standardbewegungsplan
   is begin
      
      GebautVariablen.EinheitenBewegungsplan := (others => (others => (others => KartenRecordKonstanten.LeerKoordinate)));
      
   end Standardbewegungsplan;

end SchreibeEinheitenGebaut;
