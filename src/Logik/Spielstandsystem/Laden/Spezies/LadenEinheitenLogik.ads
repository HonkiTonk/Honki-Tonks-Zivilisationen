with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with SpeziesDatentypen;

private with EinheitenDatentypen;
private with KartenRecords;
private with StadtDatentypen;
private with KampfDatentypen;
private with EinheitenRecords;
private with KIDatentypen;
private with AufgabenDatentypen;

package LadenEinheitenLogik is
   pragma Elaborate_Body;

   function Einheiten
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
private
   
   Belegung : SpeziesDatentypen.Spieler_Belegt_Enum;
   
   VorhandeneEinheiten : EinheitenDatentypen.Einheitenbereich;

   ID : EinheitenDatentypen.EinheitenIDVorhanden;
   
   Koordinaten : KartenRecords.KartenfeldNaturalRecord;
   
   Heimatstadt : StadtDatentypen.Städtebereich;
   
   Lebenspunkte : KampfDatentypen.LebenspunkteVorhanden;
   
   Bewegungspunkte : EinheitenDatentypen.BewegungspunkteVorhanden;
   
   Erfahrungspunkte : KampfDatentypen.Erfahrungspunkte;
   
   Rang : KampfDatentypen.Rang;
   
   Beschäftigung : EinheitenRecords.ArbeitRecord;
   
   BeschäftigungNachfolger : EinheitenRecords.ArbeitRecord;
   
   KIZielKoordinaten : KartenRecords.KartenfeldNaturalRecord;
   
   KIBeschäftigt : KIDatentypen.Einheit_Aufgabe_Enum;
   
   KIZielKoordinatenNachfolger : KartenRecords.KartenfeldNaturalRecord;
   
   KIBeschäftigtNachfolger : KIDatentypen.Einheit_Aufgabe_Enum;
   
   KIVerbesserung : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   
   AlleMeldungen : EinheitenRecords.EinheitMeldungenArray;
   
   TransportplätzeBelegt : EinheitenDatentypen.Transportplätze;
   
   Ladung : EinheitenRecords.TransporterArray;
   
   WirdTransportiert : EinheitenDatentypen.Einheitenbereich;
   
   

   function Einheitenwerte
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      BelegungExtern : in SpeziesDatentypen.Spieler_Belegt_Enum;
      DateiLadenExtern : in File_Type;
      EinheitExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
      return Boolean;

end LadenEinheitenLogik;
