with SpeziesDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with KartenRecords;
with AufgabenDatentypen;
with KampfDatentypen;
with ProduktionDatentypen;

with KIDatentypen;

package EinheitenRecords is
   pragma Pure;

   type SpeziesEinheitnummerRecord is record
      
      Spezies : SpeziesDatentypen.Spezies_Enum;
      Nummer : EinheitenDatentypen.Einheitenbereich;
      
   end record;
   
   
   
   type SpeziesEinheitnummerVorhandenRecord is record
      
      Spezies : SpeziesDatentypen.Spezies_Verwendet_Enum;
      Nummer : EinheitenDatentypen.EinheitenbereichVorhanden;
      
   end record;
   
   
   
   type SpeziesIDRecord is record
      
      Spezies : SpeziesDatentypen.Spezies_Enum;
      ID : EinheitenDatentypen.EinheitenID;
      
   end record;
   
   
   
   type ArbeitRecord is record
      
      Aufgabe : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      Arbeitszeit : ProduktionDatentypen.Arbeitszeit;
      
   end record;
   
   
   
   type ArbeitVorleistungRecord is record
      
      Aufgabe : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      Arbeitszeit : ProduktionDatentypen.Arbeitszeit;
     
      Vorarbeit : Boolean;
   
   end record;
   
   
   
   type KIBewegungPlanArray is array (EinheitenDatentypen.BewegungsplanVorhanden'Range) of KartenRecords.AchsenKartenfeldNaturalRecord;
   type TransporterArray is array (EinheitenDatentypen.TransportplätzeVorhanden'Range) of EinheitenDatentypen.Einheitenbereich;
   type EinheitMeldungenArray is array (EinheitenDatentypen.Einheit_Meldung_Art_Enum'Range) of EinheitenDatentypen.Einheit_Meldung_Enum;

   type EinheitenGebautRecord is record
      
      ID : EinheitenDatentypen.EinheitenID;
      KoordinatenAktuell : KartenRecords.AchsenKartenfeldNaturalRecord;
      Heimatstadt : StadtDatentypen.Städtebereich;
      
      Lebenspunkte : KampfDatentypen.Lebenspunkte;
      Bewegungspunkte : EinheitenDatentypen.BewegungspunkteVorhanden;
      Erfahrungspunkte : KampfDatentypen.Erfahrungspunkte;
      Rang : KampfDatentypen.Rang;
      
      Beschäftigung : ArbeitRecord;
      BeschäftigungNachfolger : ArbeitRecord;
      
      KIZielKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
      KIBeschäftigt : KIDatentypen.Einheit_Aufgabe_Enum;
      KIZielKoordinatenNachfolger : KartenRecords.AchsenKartenfeldNaturalRecord;
      KIBeschäftigtNachfolger : KIDatentypen.Einheit_Aufgabe_Enum;
      KIVerbesserung : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      
      Transportiert : TransporterArray;
      WirdTransportiert : EinheitenDatentypen.Einheitenbereich;
      
      Meldungen : EinheitMeldungenArray;
      
   end record;
   
   
   
   type MöglicheAuswahlenArray is array (0 .. TransporterArray'Last) of EinheitenDatentypen.Einheitenbereich;
   
   type AuswahlRecord is record
      
      StadtEinheit : Boolean;
      MöglicheAuswahlen : MöglicheAuswahlenArray;
      
   end record;

end EinheitenRecords;
