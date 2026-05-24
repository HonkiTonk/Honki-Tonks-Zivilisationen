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
      Nummer : EinheitenDatentypen.EinheitenbereichBasis;
      
   end record;
   
   
   
   type SpeziesEinheitnummerVorhandenRecord is record
      
      Spezies : SpeziesDatentypen.Spezies_Vorhanden_Enum;
      Nummer : EinheitenDatentypen.EinheitenbereichVorhanden;
      
   end record;
   
   
   
   type SpeziesIDRecord is record
      
      Spezies : SpeziesDatentypen.Spezies_Enum;
      ID : EinheitenDatentypen.EinheitenIDBasis;
      
   end record;
   
   
   
   type ArbeitRecord is record
      
      Aufgabe : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      Arbeitszeit : ProduktionDatentypen.ArbeitszeitBasis;
      
   end record;
   
   
   
   type ArbeitVorleistungRecord is record
      
      Aufgabe : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      Arbeitszeit : ProduktionDatentypen.ArbeitszeitBasis;
     
      Vorarbeit : Boolean;
   
   end record;
   
   
   
   type KIBewegungPlanArray is array (EinheitenDatentypen.BewegungsplanVorhanden'Range) of KartenRecords.KartenfeldNaturalRecord;
   type TransporterArray is array (EinheitenDatentypen.TransportplätzeVorhanden'Range) of EinheitenDatentypen.EinheitenbereichBasis;
   type EinheitMeldungenArray is array (EinheitenDatentypen.Einheit_Meldung_Art_Enum'Range) of EinheitenDatentypen.Einheit_Meldung_Enum;

   type EinheitenGebautRecord is record
      
      ID : EinheitenDatentypen.EinheitenIDBasis;
      Koordinaten : KartenRecords.KartenfeldNaturalRecord;
      Heimatstadt : StadtDatentypen.StädtebereichBasis;
      
      Lebenspunkte : KampfDatentypen.LebenspunkteVorhanden;
      Bewegungspunkte : EinheitenDatentypen.BewegungspunkteVorhanden;
      Erfahrungspunkte : KampfDatentypen.ErfahrungspunkteBasis;
      Rang : KampfDatentypen.Rang;
      
      Beschäftigung : ArbeitRecord;
      BeschäftigungNachfolger : ArbeitRecord;
      
      KIZielKoordinaten : KartenRecords.KartenfeldNaturalRecord;
      KIBeschäftigt : KIDatentypen.Einheit_Aufgabe_Enum;
      KIZielKoordinatenNachfolger : KartenRecords.KartenfeldNaturalRecord;
      KIBeschäftigtNachfolger : KIDatentypen.Einheit_Aufgabe_Enum;
      KIVerbesserung : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      
      Transportiert : TransporterArray;
      WirdTransportiert : EinheitenDatentypen.EinheitenbereichBasis;
      
      Meldungen : EinheitMeldungenArray;
      
   end record;
   
   
   
   type MöglicheAuswahlenArray is array (0 .. TransporterArray'Last) of EinheitenDatentypen.EinheitenbereichBasis;
   
   type AuswahlRecord is record
      
      StadtEinheit : Boolean;
      MöglicheAuswahlen : MöglicheAuswahlenArray;
      
   end record;

end EinheitenRecords;
