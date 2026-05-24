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
   
   LeerNummer : constant EinheitenDatentypen.EinheitenbereichBasis := EinheitenDatentypen.EinheitenbereichBasis'First;
   
   -- Wieso ist diese Recordkonstante hier und nicht bei den Recordkonstanten? äöü
   -- Weil es da auch ein LeerEinheit gibt, welche aber den Einheitenrecord auf Leer setzt. äöü
   LeerEinheit : constant EinheitenRecords.SpeziesEinheitnummerRecord := (SpeziesKonstanten.LeerSpezies, LeerNummer);
   
   AnfangNummer : constant EinheitenDatentypen.EinheitenbereichVorhanden := EinheitenDatentypen.EinheitenbereichVorhanden'First;

   LeerID : constant EinheitenDatentypen.EinheitenIDBasis := EinheitenDatentypen.EinheitenIDBasis'First;
   LeerHeimatstadt : constant StadtDatentypen.StädtebereichBasis := StadtDatentypen.StädtebereichBasis'First;
   LeerLebenspunkte : constant KampfDatentypen.LebenspunkteBasis := 0;
   LeerBewegungspunkte : constant EinheitenDatentypen.BewegungspunkteVorhanden := EinheitenDatentypen.BewegungspunkteVorhanden'First;
   LeerErfahrungspunkte : constant KampfDatentypen.ErfahrungspunkteBasis := KampfDatentypen.ErfahrungspunkteBasis'First;
   LeerRang : constant KampfDatentypen.Rang := KampfDatentypen.Rang'First;
   LeerBeschäftigung : constant AufgabenDatentypen.Einheiten_Aufgaben_Enum := AufgabenDatentypen.Leer_Aufgabe_Enum;
   LeerBeschäftigungszeit : constant ProduktionDatentypen.ArbeitszeitBasis := 0;
   LeerKIBeschäftigt : constant KIDatentypen.Einheit_Aufgabe_Enum := KIDatentypen.Leer_Aufgabe_Enum;
   LeerTransportiert : constant EinheitenDatentypen.EinheitenbereichBasis := EinheitenDatentypen.EinheitenbereichBasis'First;
   LeerWirdTransportiert : constant EinheitenDatentypen.EinheitenbereichBasis := EinheitenDatentypen.EinheitenbereichBasis'First;
   LeerMeldung : constant EinheitenDatentypen.Einheit_Meldung_Enum := EinheitenDatentypen.Leer_Einheit_Meldung_Enum;
   
   StandardBewegungspunkt : constant EinheitenDatentypen.BewegungspunkteVorhanden := 3;
   MinimalerBewegungspunkt : constant EinheitenDatentypen.BewegungspunkteVorhanden := 1;
   
   
   
   LeerEinheitArt : constant EinheitenDatentypen.Einheitart_Enum := EinheitenDatentypen.Leer_Einheitart_Enum;
   LeerPreisGeld : constant ProduktionDatentypen.Produktion := 0;
   LeerPreisRessourcen : constant ProduktionDatentypen.Produktion := 0;
   LeerPermanenteKosten : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerAnforderungen : constant ForschungenDatentypen.ForschungIDUnmöglich := ForschungKonstanten.ForschungUnmöglich;
   LeerPassierbarkeit : constant Boolean := False;
   LeerGebäudeBenötigt : constant Boolean := False;
   LeerMaximaleLebenspunkte : constant KampfDatentypen.LebenspunkteVorhanden := KampfDatentypen.LebenspunkteVorhanden'First;
   LeerMaximaleBewegungspunkte : constant EinheitenDatentypen.BewegungspunkteVorhanden := 3;
   LeerWirdVerbessertZu : constant EinheitenDatentypen.EinheitenIDBasis := EinheitenDatentypen.EinheitenIDBasis'First;
   LeerBeförderungsgrenze : constant KampfDatentypen.ErfahrungspunkteVorhanden := KampfDatentypen.ErfahrungspunkteVorhanden'First;
   LeerMaximalerRang : constant KampfDatentypen.Rang := KampfDatentypen.Rang'First;
   LeerReichweite : constant KampfDatentypen.ReichweiteVorhanden := KampfDatentypen.ReichweiteVorhanden'First;
   LeerAngriff : constant KampfDatentypen.KampfwerteEinheiten := KampfDatentypen.KampfwerteEinheiten'First;
   LeerVerteidigung : constant KampfDatentypen.KampfwerteEinheiten := KampfDatentypen.KampfwerteEinheiten'First;
   LeerKannTransportieren : constant EinheitenDatentypen.Transport_Enum := EinheitenDatentypen.Kein_Transport_Enum;
   LeerKannTransportiertWerden : constant EinheitenDatentypen.Transport_Enum := EinheitenDatentypen.Kein_Transport_Enum;
   LeerTransportkapazität : constant EinheitenDatentypen.TransportplätzeBasis := EinheitenDatentypen.TransportplätzeBasis'First;
   
end EinheitenKonstanten;
