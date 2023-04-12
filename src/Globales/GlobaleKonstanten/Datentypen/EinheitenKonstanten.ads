with EinheitenDatentypen;
with ForschungKonstanten;
with AufgabenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with EinheitenRecords;
with KampfDatentypen;
with StadtDatentypen;
with SpeziesKonstanten;

with KIDatentypen;

package EinheitenKonstanten is
   pragma Preelaborate;
   
   LeerNummer : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   
   -- Wieso ist diese Recordkonstante hier und nicht bei den Recordkonstanten? äöü
   LeerEinheit : constant EinheitenRecords.SpeziesEinheitnummerRecord := (SpeziesKonstanten.LeerSpezies, LeerNummer);
   
   AnfangNummer : constant EinheitenDatentypen.MaximaleEinheiten := EinheitenDatentypen.MaximaleEinheiten'First;

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
   
   StandardBewegungspunkt : constant EinheitenDatentypen.VorhandeneBewegungspunkte := 3;
   MinimalerBewegungspunkt : constant EinheitenDatentypen.VorhandeneBewegungspunkte := 1;
   
   
   
   LeerEinheitArt : constant EinheitenDatentypen.Einheitart_Enum := EinheitenDatentypen.Leer_Einheitart_Enum;
   LeerPreisGeld : constant ProduktionDatentypen.Produktion := 0;
   LeerPreisRessourcen : constant ProduktionDatentypen.Produktion := 0;
   LeerPermanenteKosten : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerAnforderungen : constant ForschungenDatentypen.ForschungIDNichtMöglich := ForschungKonstanten.ForschungUnmöglich;
   LeerPassierbarkeit : constant Boolean := False;
   LeerGebäudeBenötigt : constant Boolean := False;
   LeerMaximaleLebenspunkte : constant EinheitenDatentypen.VorhandeneLebenspunkte := EinheitenDatentypen.VorhandeneLebenspunkte'First;
   LeerMaximaleBewegungspunkte : constant EinheitenDatentypen.VorhandeneBewegungspunkte := 3;
   LeerWirdVerbessertZu : constant EinheitenDatentypen.EinheitenIDMitNullWert := EinheitenDatentypen.EinheitenIDMitNullWert'First;
   LeerBeförderungsgrenze : constant KampfDatentypen.ErfahrungspunkteVorhanden := KampfDatentypen.ErfahrungspunkteVorhanden'First;
   LeerMaximalerRang : constant KampfDatentypen.Rang := KampfDatentypen.RangVorhanden'First;
   LeerReichweite : constant KampfDatentypen.ReichweiteVorhanden := KampfDatentypen.ReichweiteVorhanden'First;
   LeerAngriff : constant KampfDatentypen.KampfwerteEinheiten := KampfDatentypen.KampfwerteEinheiten'First;
   LeerVerteidigung : constant KampfDatentypen.KampfwerteEinheiten := KampfDatentypen.KampfwerteEinheiten'First;
   LeerKannTransportieren : constant EinheitenDatentypen.Transport_Enum := EinheitenDatentypen.Kein_Transport_Enum;
   LeerKannTransportiertWerden : constant EinheitenDatentypen.Transport_Enum := EinheitenDatentypen.Kein_Transport_Enum;
   LeerTransportkapazität : constant EinheitenDatentypen.Transportplätze := EinheitenDatentypen.Transportplätze'First;
   
   
   
   -- Das hier später auslagern nach ProduktionKonstanten oder sowas? äöü
   -- Generall mal alles ein bisschen besser aufteilen damit ich nicht mehr alles doppelt und dreifach habe? äöü
   LeerArbeit : constant AufgabenDatentypen.Einheiten_Aufgaben_Enum := AufgabenDatentypen.Leer_Aufgabe_Enum;
   LeerArbeitszeit : constant ProduktionDatentypen.Arbeitszeit := 0;
   UnmöglicheArbeit : constant ProduktionDatentypen.Arbeitszeit := ProduktionDatentypen.Arbeitszeit'First;
   MinimaleArbeitszeit : constant ProduktionDatentypen.Arbeitszeit := 1;
   
end EinheitenKonstanten;
