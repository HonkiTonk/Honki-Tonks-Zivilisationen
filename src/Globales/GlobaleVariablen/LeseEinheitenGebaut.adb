pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KampfDatentypen; use KampfDatentypen;

with LeseEinheitenDatenbank;

with Warnung;

-- Noch mehr Prüfungen durch Contracts ersetzen? Theoretisch sollten all diese Dinge ja niemals auftreten wenn alles richtig funktioniert. äöü
package body LeseEinheitenGebaut is

   function ID
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.EinheitenIDMitNullWert
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID;
      
   end ID;
   
  
   
   function Koordinaten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KoordinatenAktuell;
      
   end Koordinaten;
   
   
   
   function Heimatstadt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Heimatstadt;
      
   end Heimatstadt;
   
   
      
   function Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.Lebenspunkte
   is begin
      
      ErlaubteLebenspunkte := LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                           IDExtern    => SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID);
      
      if
        SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte > ErlaubteLebenspunkte
      then
         SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte := ErlaubteLebenspunkte;
         Warnung.LogikWarnung (WarnmeldungExtern => "LeseEinheitenGebaut.Lebenspunkte - Vorhandene Lebenspunkte > Erlaubte Lebenspunkte.");
         
      else
         null;
      end if;
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Lebenspunkte;
      
   end Lebenspunkte;
   
   
   
   -- Hier sollte keine Prüfung notwendig sein ob die Bewegungspunkte < sind als die Leerkonstante der Bewegungspunkte, da dann der Rückgabewert auch kleiner sein müsste als der erlaubte Rückgabebereich.
   function Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Bewegungspunkte;
      
   end Bewegungspunkte;
   
   
   
   function Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.Kampfwerte
   is begin
      
      Beförderungsgrenze := LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                         IDExtern    => SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID);
        
      if
        SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte > Beförderungsgrenze
      then
         SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte := Beförderungsgrenze;
         Warnung.LogikWarnung (WarnmeldungExtern => "LeseEinheitenGebaut.Erfahrungspunkte - Mehr Erfahrungspunkte als erlaubt.");

      else
         null;
      end if;
        
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Erfahrungspunkte;
      
   end Erfahrungspunkte;
   
   
   
   function Rang
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.Kampfwerte
   is begin
      
      MaximalerRang := LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                             IDExtern    => SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).ID);
      
      if
        SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Rang > MaximalerRang
      then
         SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Rang := MaximalerRang;
         Warnung.LogikWarnung (WarnmeldungExtern => "LeseEinheitenGebaut.Rang - Höherer Rang als erlaubt.");
      else
         null;
      end if;

      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Rang;
      
   end Rang;
      
   
   
   function Beschäftigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
   is begin

      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Aufgabe;
      
   end Beschäftigung;
   
   
   
   function BeschäftigungNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Aufgabe;
      
   end BeschäftigungNachfolger;
   
   
      
   function Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return ProduktionDatentypen.ArbeitszeitVorhanden
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Beschäftigung.Arbeitszeit;
      
   end Beschäftigungszeit;
   
   
   
   function BeschäftigungszeitNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return ProduktionDatentypen.ArbeitszeitVorhanden
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).BeschäftigungNachfolger.Arbeitszeit;
      
   end BeschäftigungszeitNachfolger;
   
   
      
   function KIZielKoordinaten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIZielKoordinaten;
      
   end KIZielKoordinaten;
   
   
   
   function KIBeschäftigt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIBeschäftigt;
      
   end KIBeschäftigt;
   
   
      
   function KIZielKoordinatenNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIZielKoordinatenNachfolger;
      
   end KIZielKoordinatenNachfolger;
   
   
   
   function KIBeschäftigtNachfolger
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.Einheit_Aufgabe_Enum
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIBeschäftigtNachfolger;
      
   end KIBeschäftigtNachfolger;
   
   
   
   function KIVerbesserung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return AufgabenDatentypen.Einheiten_Aufgaben_Enum
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIVerbesserung;
      
   end KIVerbesserung;
   
   
   
   function KIBewegungPlan
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PlanschrittExtern : in KartenDatentypen.Stadtfeld)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIBewegungPlan (PlanschrittExtern);
      
   end KIBewegungPlan;
   
   
      
   function Transportiert
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PlatzExtern : in EinheitenDatentypen.Transportplätze)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Transportiert (PlatzExtern);
      
   end Transportiert;
   
   
   
   function WirdTransportiert
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).WirdTransportiert;
      
   end WirdTransportiert;
      
   
   
   function Meldungen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      WelcheMeldungExtern : in EinheitenDatentypen.Einheit_Meldung_Art_Enum)
      return EinheitenDatentypen.Einheit_Meldung_Enum
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).Meldungen (WelcheMeldungExtern);
      
   end Meldungen;
   
   
   
   function GanzerEintrag
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenRecords.EinheitenGebautRecord
   is begin
      
      return SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer);
      
   end GanzerEintrag;

end LeseEinheitenGebaut;
