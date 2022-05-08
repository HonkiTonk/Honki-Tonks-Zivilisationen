pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;
with EinheitStadtDatentypen;
with KartenRecords;
with AufgabenDatentypen;
with KartenDatentypen;

with KIDatentypen;

package EinheitenRecords is

   type RasseEinheitnummerRecord is record
      
      Rasse : RassenDatentypen.Rassen_Enum;
      Nummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
      
   end record;
   
   
   
   type KIBewegungPlanArray is array (KartenDatentypen.Stadtfeld'Range) of KartenRecords.AchsenKartenfeldPositivRecord;
   type TransporterArray is array (EinheitStadtDatentypen.TransportplätzeVorhanden'Range) of EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   type EinheitMeldungenArray is array (EinheitStadtDatentypen.Einheit_Meldung_Art_Enum'Range) of EinheitStadtDatentypen.Einheit_Meldung_Enum;

   type EinheitenGebautRecord is record
      
      ID : EinheitStadtDatentypen.EinheitenIDMitNullWert;
      KoordinatenAktuell : KartenRecords.AchsenKartenfeldPositivRecord;
      Heimatstadt : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      
      Lebenspunkte : EinheitStadtDatentypen.Lebenspunkte;
      Bewegungspunkte : EinheitStadtDatentypen.VorhandeneBewegungspunkte;
      Erfahrungspunkte : EinheitStadtDatentypen.Kampfwerte;
      Rang : EinheitStadtDatentypen.Kampfwerte;
      
      ---------------------------- Beschäftigung und Zeit zusammenführen.
      Beschäftigung : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      BeschäftigungNachfolger : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      
      -- Besseren Datentypen für die Beschäftigungszeit einbauen? Z. B. für Arbeiten die niemals fertig werden?
      Beschäftigungszeit : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      BeschäftigungszeitNachfolger : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      
      KIZielKoordinaten : KartenRecords.AchsenKartenfeldPositivRecord;
      KIBeschäftigt : KIDatentypen.Einheit_Aufgabe_Enum;
      KIBewegungPlan : KIBewegungPlanArray;
      
      Transportiert : TransporterArray;
      WirdTransportiert : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
      
      Meldungen : EinheitMeldungenArray;
      
   end record;
   
   
   
   type ArbeitRecord is record
      
      WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      Arbeitszeit : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      
   end record;

end EinheitenRecords;
