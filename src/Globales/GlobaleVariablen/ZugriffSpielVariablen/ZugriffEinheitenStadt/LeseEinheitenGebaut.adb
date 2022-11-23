with GebautVariablen;

with LeseEinheitenDatenbank;

with Fehlermeldungssystem;

package body LeseEinheitenGebaut is

   function ID
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.EinheitenIDMitNullWert
   is
      use type RassenDatentypen.Rassen_Enum;
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      if
        EinheitRasseNummerExtern.Rasse = RassenDatentypen.Keine_Rasse_Enum
        or
          EinheitRasseNummerExtern.Nummer = EinheitenKonstanten.LeerNummer
      then
         return EinheitenKonstanten.LeerID;
         
      else
         return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID;
      end if;
      
   end ID;
   
  
   
   function Koordinaten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KoordinatenAktuell;
      
   end Koordinaten;
   
   
   
   function Heimatstadt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Heimatstadt;
      
   end Heimatstadt;
   
   
   
   function Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.Lebenspunkte
   is
      use type EinheitenDatentypen.Lebenspunkte;
   begin
      
      -- Solche Prüfungen hier noch überall einbauen, da jetzt ja auch der Grafiktask hierauf zugreift. äöü
      -- Eventuell sollte ich das dann auch nicht mehr in eine Variable überführen. äöü
      -- Leider muss ich diese Informationen in eine Variable überführen, da sonst die Grafikanzeige Probleme bekommt. äöü
      -- Entweder was besseres ausdenken oder auf geschützt setzen oder wieder Arrays verwenden. äöü
      EinheitID := GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID;
      
      case
        EinheitID
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenKonstanten.LeerLebenspunkte;
            
         when others =>
            ErlaubteLebenspunkte := LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                 IDExtern    => EinheitID);
      end case;
      
      if
        GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte > ErlaubteLebenspunkte
      then
         GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte := ErlaubteLebenspunkte;
         -- Warnmeldungen hier überall mal erweitern. äöü
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseEinheitenGebaut.Lebenspunkte: Vorhandene Lebenspunkte > Erlaubte Lebenspunkte.");
         
      else
         null;
      end if;
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte;
      
   end Lebenspunkte;
   
   
   
   function Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte;
      
   end Bewegungspunkte;
   
   
   
   function Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.Erfahrungspunkte
   is
      use type KampfDatentypen.Erfahrungspunkte;
   begin
      
      Beförderungsgrenze := LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                         IDExtern    => ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      if
        GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte > Beförderungsgrenze
      then
         GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte := Beförderungsgrenze;
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseEinheitenGebaut.Erfahrungspunkte: Mehr Erfahrungspunkte als erlaubt.");

      else
         null;
      end if;
        
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte;
      
   end Erfahrungspunkte;
   
   
   
   function Rang
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.Rang
   is
      use type KampfDatentypen.Erfahrungspunkte;
   begin
      
      MaximalerRang := LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                             IDExtern    => ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      if
        GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Rang > MaximalerRang
      then
         GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Rang := MaximalerRang;
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "LeseEinheitenGebaut.Rang: Höherer Rang als erlaubt.");
      else
         null;
      end if;

      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Rang;
      
   end Rang;
      
   
   
   function Beschäftigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
   is begin

      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Aufgabe;
      
   end Beschäftigung;
   
   
   
   function BeschäftigungNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Aufgabe;
      
   end BeschäftigungNachfolger;
   
   
      
   function Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return ProduktionDatentypen.Arbeitszeit
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit;
      
   end Beschäftigungszeit;
   
   
   
   function BeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return ProduktionDatentypen.Arbeitszeit
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit;
      
   end BeschäftigungszeitNachfolger;
   
   
      
   function KIZielKoordinaten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIZielKoordinaten;
      
   end KIZielKoordinaten;
   
   
   
   function KIBeschäftigt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIBeschäftigt;
      
   end KIBeschäftigt;
   
   
      
   function KIZielKoordinatenNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIZielKoordinatenNachfolger;
      
   end KIZielKoordinatenNachfolger;
   
   
   
   function KIBeschäftigtNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIBeschäftigtNachfolger;
      
   end KIBeschäftigtNachfolger;
   
   
   
   function KIVerbesserung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIVerbesserung;
      
   end KIVerbesserung;
   
   
   
   function KIBewegungPlan
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PlanschrittExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIBewegungPlan (PlanschrittExtern);
      
   end KIBewegungPlan;
   
   
      
   function Transportiert
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PlatzExtern : in EinheitenDatentypen.Transportplätze)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Transportiert (PlatzExtern);
      
   end Transportiert;
   
   
   
   function WirdTransportiert
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).WirdTransportiert;
      
   end WirdTransportiert;
      
   
   
   function Meldungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      WelcheMeldungExtern : in EinheitenDatentypen.Einheit_Meldung_Art_Enum)
      return EinheitenDatentypen.Einheit_Meldung_Enum
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Meldungen (WelcheMeldungExtern);
      
   end Meldungen;
   
   
   
   function GanzerEintrag
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenRecords.EinheitenGebautRecord
   is begin
      
      return GebautVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer);
      
   end GanzerEintrag;

end LeseEinheitenGebaut;
