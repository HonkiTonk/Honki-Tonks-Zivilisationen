with EinheitenDatentypen;
with ProduktionDatentypen;
with StadtRecords;
with ForschungenDatentypen;
with KampfDatentypen;
with KartenRecords;
with StadtArrays;
with EinheitenArrays;

-- Voraussetzungen wie beim GebäudedatenbankRecord erweitern? äöü
package EinheitendatenbankRecord is
   pragma Preelaborate;
         
   type EinheitenlisteRecord is record
      
      Einheitenart : EinheitenDatentypen.Einheitart_Enum;
      PreisGeld : ProduktionDatentypen.Produktion;
      Produktionskosten : ProduktionDatentypen.Lagermenge;
      PermanenteKosten : StadtRecords.PermanenteKostenArray;
      Anforderungen : ForschungenDatentypen.ForschungIDUnmöglich;
      NotwendigeGebäude : StadtArrays.GebäudeArray;

      Passierbarkeit : EinheitenArrays.PassierbarkeitArray;
      
      MaximaleLebenspunkte : KampfDatentypen.LebenspunkteVorhanden;
      MaximaleBewegungspunkte : EinheitenDatentypen.BewegungspunkteVorhanden;
      VerbesserungZu : EinheitenDatentypen.EinheitenID;

      Beförderungsgrenze : KampfDatentypen.ErfahrungspunkteVorhanden;
      MaximalerRang : KampfDatentypen.Rang;
      Reichweite : KampfDatentypen.ReichweiteVorhanden;
      Angriff : KampfDatentypen.KampfwerteEinheiten;
      Verteidigung : KampfDatentypen.KampfwerteEinheiten;

      KannTransportieren : EinheitenDatentypen.Transport_Enum;
      KannTransportiertWerden : EinheitenDatentypen.Transport_Enum;
      Transportkapazität : EinheitenDatentypen.Transportplätze;
      
      Zusatzeffekt : KartenRecords.EffekteArray;
      Effektreichweite : KartenRecords.EffektbereichArray;
      
   end record;
   
   type EinheitenlisteArray is array (EinheitenDatentypen.EinheitenIDVorhanden'Range) of EinheitenlisteRecord;

end EinheitendatenbankRecord;
