with EinheitenDatentypen;
with ForschungKonstanten;
with AufgabenDatentypen;
with RassenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with EinheitenRecords;
with KampfDatentypen;
with StadtDatentypen;

with KIDatentypen;

package EinheitenKonstanten is
   pragma Preelaborate;
   use type EinheitenDatentypen.BewegungFloat;
   
   LeerRasse : constant RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;
   LeerNummer : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerRasseNummer : constant EinheitenRecords.RasseEinheitnummerRecord := (LeerRasse, LeerNummer);

   LeerID : constant EinheitenDatentypen.EinheitenIDMitNullWert := EinheitenDatentypen.EinheitenIDMitNullWert'First;
   LeerHeimatstadt : constant StadtDatentypen.MaximaleStädteMitNullWert := StadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerLebenspunkte : constant EinheitenDatentypen.Lebenspunkte := 0;
   LeerBewegungspunkte : constant EinheitenDatentypen.VorhandeneBewegungspunkte := EinheitenDatentypen.VorhandeneBewegungspunkte'First;
   LeerErfahrungspunkte : constant KampfDatentypen.Erfahrungspunkte := KampfDatentypen.Erfahrungspunkte'First;
   LeerRang : constant KampfDatentypen.Rang := KampfDatentypen.Rang'First;
   LeerBeschäftigung : constant AufgabenDatentypen.Einheiten_Aufgaben_Enum := AufgabenDatentypen.Leer_Aufgabe_Enum;
   LeerBeschäftigungszeit : constant ProduktionDatentypen.Arbeitszeit := 0;
   LeerKIBeschäftigt : constant KIDatentypen.Einheit_Aufgabe_Enum := KIDatentypen.Leer_Aufgabe_Enum;
   LeerTransportiert : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerWirdTransportiert : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerMeldung : constant EinheitenDatentypen.Einheit_Meldung_Enum := EinheitenDatentypen.Leer_Einheit_Meldung_Enum;
   EinheitUnbewegbar : constant EinheitenDatentypen.BewegungFloat := -1.00;
   
   
   
   LeerEinheitArt : constant EinheitenDatentypen.Einheitart_Enum := EinheitenDatentypen.Leer_Einheitart_Enum;
   LeerPreisGeld : constant ProduktionDatentypen.Produktion := 0;
   LeerPreisRessourcen : constant ProduktionDatentypen.Produktion := 0;
   LeerPermanenteKosten : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerAnforderungen : constant ForschungenDatentypen.ForschungIDNichtMöglich := ForschungKonstanten.ForschungUnmöglich;
   LeerPassierbarkeit : constant Boolean := False;
   LeerMaximaleLebenspunkte : constant EinheitenDatentypen.VorhandeneLebenspunkte := EinheitenDatentypen.VorhandeneLebenspunkte'First;
   LeerMaximaleBewegungspunkte : constant EinheitenDatentypen.VorhandeneBewegungspunkte := 1.00;
   LeerWirdVerbessertZu : constant EinheitenDatentypen.EinheitenIDMitNullWert := EinheitenDatentypen.EinheitenIDMitNullWert'First;
   LeerBeförderungsgrenze : constant KampfDatentypen.ErfahrungspunkteVorhanden := KampfDatentypen.ErfahrungspunkteVorhanden'First;
   LeerMaximalerRang : constant KampfDatentypen.Rang := KampfDatentypen.RangVorhanden'First;
   LeerReichweite : constant KampfDatentypen.Reichweite := KampfDatentypen.Reichweite'First;
   LeerAngriff : constant KampfDatentypen.KampfwerteEinheiten := KampfDatentypen.KampfwerteEinheiten'First;
   LeerVerteidigung : constant KampfDatentypen.KampfwerteEinheiten := KampfDatentypen.KampfwerteEinheiten'First;
   LeerKannTransportieren : constant EinheitenDatentypen.Transport_Enum := EinheitenDatentypen.Kein_Transport_Enum;
   LeerKannTransportiertWerden : constant EinheitenDatentypen.Transport_Enum := EinheitenDatentypen.Kein_Transport_Enum;
   LeerTransportkapazität : constant EinheitenDatentypen.Transportplätze := EinheitenDatentypen.Transportplätze'First;
   
   
   
   -- Das hier später auslagern nach ProduktionKonstanten oder sowas? äöü
   LeerArbeit : constant AufgabenDatentypen.Einheiten_Aufgaben_Enum := AufgabenDatentypen.Leer_Aufgabe_Enum;
   LeerArbeitszeit : constant ProduktionDatentypen.Arbeitszeit := 0;
   UnmöglicheArbeit : constant ProduktionDatentypen.Arbeitszeit := ProduktionDatentypen.Arbeitszeit'First;
   MinimaleArbeitszeit : constant ProduktionDatentypen.Arbeitszeit := 1;
   
end EinheitenKonstanten;
