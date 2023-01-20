with DatenbankRecords;
with EinheitenDatentypen;
with ProduktionDatentypen;
with StadtRecords;
with ForschungenDatentypen;
with KampfDatentypen;
with KartengrundDatentypen;
with KartenRecords;

package EinheitendatenbankRecord is
   pragma Preelaborate;

   -- Damit sollen mehrere Effekte auf einmal möglich sein. Wenn der Leerwert True ist, dann alle anderen Werte ignorieren? äöü
   type EinheiteneffektArray is array (KartengrundDatentypen.Effekt_Enum'Range) of Boolean;
   
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
      Reichweite : KampfDatentypen.ReichweiteVorhanden;
      Angriff : KampfDatentypen.KampfwerteEinheiten;
      Verteidigung : KampfDatentypen.KampfwerteEinheiten;

      KannTransportieren : EinheitenDatentypen.Transport_Enum;
      KannTransportiertWerden : EinheitenDatentypen.Transport_Enum;
      Transportkapazität : EinheitenDatentypen.Transportplätze;
      
      Zusatzeffekt : KartengrundDatentypen.Effekt_Enum;
      Effektreichweite : KartenRecords.EffektbereichRecord;
      
   end record;
   
   type EinheitenlisteArray is array (EinheitenDatentypen.EinheitenID'Range) of EinheitenlisteRecord;

end EinheitendatenbankRecord;
