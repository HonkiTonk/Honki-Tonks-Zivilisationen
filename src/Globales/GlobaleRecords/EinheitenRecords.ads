pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with KartenRecords;
with AufgabenDatentypen;
with KartenDatentypen;
with KampfDatentypen;

with KIDatentypen;

package EinheitenRecords is

   type RasseEinheitnummerRecord is record
      
      Rasse : RassenDatentypen.Rassen_Enum;
      Nummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      
   end record;
   
   
   
   type KIBewegungPlanArray is array (KartenDatentypen.Stadtfeld'Range) of KartenRecords.AchsenKartenfeldNaturalRecord;
   type TransporterArray is array (EinheitenDatentypen.TransportplätzeVorhanden'Range) of EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   type EinheitMeldungenArray is array (EinheitenDatentypen.Einheit_Meldung_Art_Enum'Range) of EinheitenDatentypen.Einheit_Meldung_Enum;

   type EinheitenGebautRecord is record
      
      ID : EinheitenDatentypen.EinheitenIDMitNullWert;
      KoordinatenAktuell : KartenRecords.AchsenKartenfeldNaturalRecord;
      Heimatstadt : StadtDatentypen.MaximaleStädteMitNullWert;
      
      Lebenspunkte : EinheitenDatentypen.Lebenspunkte;
      Bewegungspunkte : EinheitenDatentypen.VorhandeneBewegungspunkte;
      Erfahrungspunkte : KampfDatentypen.Kampfwerte;
      Rang : KampfDatentypen.Kampfwerte;
      
      ---------------------------- Beschäftigung und Zeit zusammenführen.
      Beschäftigung : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      BeschäftigungNachfolger : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      
      ---------------------------- Besseren Datentypen für die Beschäftigungszeit einbauen? Z. B. für Arbeiten die niemals fertig werden?
      Beschäftigungszeit : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      BeschäftigungszeitNachfolger : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      
      KIZielKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
      KIBeschäftigt : KIDatentypen.Einheit_Aufgabe_Enum;
      KIBewegungPlan : KIBewegungPlanArray;
      
      Transportiert : TransporterArray;
      WirdTransportiert : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      
      Meldungen : EinheitMeldungenArray;
      
   end record;
   
   
   
   type ArbeitRecord is record
      
      WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      Arbeitszeit : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      
   end record;

end EinheitenRecords;
