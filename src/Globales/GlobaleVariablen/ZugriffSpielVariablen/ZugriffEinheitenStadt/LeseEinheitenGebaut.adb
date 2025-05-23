with GebautVariablen;
with SpeziesKonstanten;

with LeseEinheitenDatenbank;

with MeldungssystemHTSEB;
with FehlermeldungssystemZusatzinformationen;

package body LeseEinheitenGebaut is

   function ID
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.EinheitenID
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      if
        EinheitSpeziesNummerExtern.Spezies = SpeziesKonstanten.LeerSpezies
        or
          EinheitSpeziesNummerExtern.Nummer = EinheitenKonstanten.LeerNummer
      then
         return EinheitenKonstanten.LeerID;
         
      else
         return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).ID;
      end if;
      
   end ID;
   
  
   
   function Koordinaten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.KartenfeldNaturalRecord
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Koordinaten;
      
   end Koordinaten;
   
   
   
   function Heimatstadt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return StadtDatentypen.Städtebereich
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Heimatstadt;
      
   end Heimatstadt;
   
   
   
   function Lebenspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KampfDatentypen.Lebenspunkte
   is
      use type KampfDatentypen.Lebenspunkte;
   begin
      
      -- Solche Prüfungen hier noch überall einbauen, da jetzt ja auch der Grafiktask hierauf zugreift. äöü
      -- Eventuell sollte ich das dann auch nicht mehr in eine Variable überführen. äöü
      -- Leider muss ich diese Informationen in eine Variable überführen, da sonst die Grafikanzeige Probleme bekommt. äöü
      -- Entweder was besseres ausdenken oder auf geschützt setzen oder wieder Logik/Grafik Arrays verrwenden. äöü
      EinheitID := GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).ID;
      
      case
        EinheitID
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenKonstanten.LeerLebenspunkte;
            
         when others =>
            ErlaubteLebenspunkte := LeseEinheitenDatenbank.MaximaleLebenspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                 IDExtern      => EinheitID);
      end case;
      
      if
        GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Lebenspunkte > ErlaubteLebenspunkte
      then
         MeldungssystemHTSEB.Logik (MeldungExtern => "LeseEinheitenGebaut.Lebenspunkte: Vorhandene Lebenspunkte > Erlaubte Lebenspunkte, "
                                     & FehlermeldungssystemZusatzinformationen.SpeziesID (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                          IDExtern      => EinheitID));
         GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Lebenspunkte := ErlaubteLebenspunkte;
         
      else
         null;
      end if;
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Lebenspunkte;
      
   end Lebenspunkte;
   
   
   
   function Bewegungspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.BewegungspunkteVorhanden
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Bewegungspunkte;
      
   end Bewegungspunkte;
   
   
   
   function Erfahrungspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KampfDatentypen.Erfahrungspunkte
   is
      use type KampfDatentypen.Erfahrungspunkte;
   begin
      
      EinheitID := GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).ID;
      
      case
        EinheitID
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenKonstanten.LeerErfahrungspunkte;
            
         when others =>
            Beförderungsgrenze := LeseEinheitenDatenbank.Beförderungsgrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                               IDExtern    => EinheitID);
      end case;
      
      if
        GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Erfahrungspunkte > Beförderungsgrenze
      then
         MeldungssystemHTSEB.Logik (MeldungExtern => "LeseEinheitenGebaut.Erfahrungspunkte: Mehr Erfahrungspunkte als erlaubt, "
                                     & FehlermeldungssystemZusatzinformationen.SpeziesID (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                          IDExtern      => EinheitID));
         GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Erfahrungspunkte := Beförderungsgrenze;

      else
         null;
      end if;
        
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Erfahrungspunkte;
      
   end Erfahrungspunkte;
   
   
   
   function Rang
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KampfDatentypen.Rang
   is
      use type KampfDatentypen.Erfahrungspunkte;
   begin
      
      EinheitID := GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).ID;
      
      case
        EinheitID
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenKonstanten.LeerRang;
            
         when others =>
            MaximalerRang := LeseEinheitenDatenbank.MaximalerRang (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                   IDExtern    => EinheitID);
      end case;
      
      if
        GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Rang > MaximalerRang
      then
         MeldungssystemHTSEB.Logik (MeldungExtern => "LeseEinheitenGebaut.Rang: Rang höher als erlaubt, "
                                     & FehlermeldungssystemZusatzinformationen.SpeziesID (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                          IDExtern      => EinheitID));
         GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Rang := MaximalerRang;
      else
         null;
      end if;

      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Rang;
      
   end Rang;
      
   
   
   function Beschäftigung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
   is begin

      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Beschäftigung.Aufgabe;
      
   end Beschäftigung;
   
   
   
   function BeschäftigungNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).BeschäftigungNachfolger.Aufgabe;
      
   end BeschäftigungNachfolger;
   
   
      
   function Beschäftigungszeit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return ProduktionDatentypen.Arbeitszeit
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Beschäftigung.Arbeitszeit;
      
   end Beschäftigungszeit;
   
   
   
   function BeschäftigungszeitNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return ProduktionDatentypen.Arbeitszeit
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit;
      
   end BeschäftigungszeitNachfolger;
   
   
   
   function BeschäftigungSpeichern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      return (Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern), Beschäftigungszeit (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
   end BeschäftigungSpeichern;
   
   
   
   function BeschäftigungNachfolgerSpeichern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenRecords.ArbeitRecord
   is begin
      
      return (BeschäftigungNachfolger (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern), BeschäftigungszeitNachfolger (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
   end BeschäftigungNachfolgerSpeichern;
   
   
      
   function KIZielKoordinaten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.KartenfeldNaturalRecord
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).KIZielKoordinaten;
      
   end KIZielKoordinaten;
   
   
   
   function KIBeschäftigt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).KIBeschäftigt;
      
   end KIBeschäftigt;
   
   
      
   function KIZielKoordinatenNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.KartenfeldNaturalRecord
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).KIZielKoordinatenNachfolger;
      
   end KIZielKoordinatenNachfolger;
   
   
   
   function KIBeschäftigtNachfolger
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).KIBeschäftigtNachfolger;
      
   end KIBeschäftigtNachfolger;
   
   
   
   function KIVerbesserung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).KIVerbesserung;
      
   end KIVerbesserung;
   
   
   
   function KIBewegungPlan
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PlanschrittExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return KartenRecords.KartenfeldNaturalRecord
   is begin
      
      return GebautVariablen.EinheitenBewegungsplan (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer) (PlanschrittExtern);
      
   end KIBewegungPlan;
   
   
      
   function Transportiert
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PlatzExtern : in EinheitenDatentypen.Transportplätze)
      return EinheitenDatentypen.Einheitenbereich
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Transportiert (PlatzExtern);
      
   end Transportiert;
   
   
   
   function WirdTransportiert
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.Einheitenbereich
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).WirdTransportiert;
      
   end WirdTransportiert;
      
   
   
   function Meldungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      WelcheMeldungExtern : in EinheitenDatentypen.Einheit_Meldung_Art_Enum)
      return EinheitenDatentypen.Einheit_Meldung_Enum
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Meldungen (WelcheMeldungExtern);
      
   end Meldungen;
   
   
   
   function AlleMeldungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenRecords.EinheitMeldungenArray
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer).Meldungen;
      
   end AlleMeldungen;
   
   
   
   function GanzerEintrag
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenRecords.EinheitenGebautRecord
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitSpeziesNummerExtern.Spezies, EinheitSpeziesNummerExtern.Nummer);
      
   end GanzerEintrag;

end LeseEinheitenGebaut;
