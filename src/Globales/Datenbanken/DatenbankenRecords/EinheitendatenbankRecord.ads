with DatenbankRecords;
with EinheitenDatentypen;
with ProduktionDatentypen;
with StadtRecords;
with ForschungenDatentypen;
with KampfDatentypen;

package EinheitendatenbankRecord is
   pragma Preelaborate;

   type EinheitenlisteRecord is record
      
      Einheitenart : EinheitenDatentypen.Einheitart_Enum;
      PreisGeld : ProduktionDatentypen.Produktion;
      Produktionskosten : ProduktionDatentypen.Lagermenge;
      PermanenteKosten : StadtRecords.PermanenteKostenArray;
      Anforderungen : ForschungenDatentypen.ForschungIDNichtMöglich;

      Passierbarkeit : DatenbankRecords.PassierbarkeitArray;
      
      MaximaleLebenspunkte : EinheitenDatentypen.VorhandeneLebenspunkte;
      MaximaleBewegungspunkte : EinheitenDatentypen.VorhandeneBewegungspunkte;
      VerbesserungZu : EinheitenDatentypen.EinheitenIDMitNullWert;

      Beförderungsgrenze : KampfDatentypen.ErfahrungspunkteVorhanden;
      MaximalerRang : KampfDatentypen.RangVorhanden;
      Reichweite : KampfDatentypen.Reichweite;
      Angriff : KampfDatentypen.KampfwerteEinheiten;
      Verteidigung : KampfDatentypen.KampfwerteEinheiten;

      KannTransportieren : EinheitenDatentypen.Transport_Enum;
      KannTransportiertWerden : EinheitenDatentypen.Transport_Enum;
      Transportkapazität : EinheitenDatentypen.Transportplätze;
      
   end record;
   
   type EinheitenlisteArray is array (EinheitenDatentypen.EinheitenID'Range) of EinheitenlisteRecord;

end EinheitendatenbankRecord;
