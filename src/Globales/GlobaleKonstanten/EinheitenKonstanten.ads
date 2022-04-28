pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtRecords;
with KartenRecords;
with ForschungKonstanten;
with EinheitStadtDatentypen;
with AufgabenDatentypen;
with TextKonstanten;
with RassenDatentypen;

with DatenbankRecords;

with KIDatentypen;

package EinheitenKonstanten is
   
   LeerRasse : constant RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;
   LeerNummer : constant EinheitStadtDatentypen.MaximaleStädteMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerRasseNummer : constant EinheitStadtRecords.RassePlatznummerRecord := (LeerRasse, LeerNummer);

   LeerID : constant EinheitStadtDatentypen.EinheitenIDMitNullWert := EinheitStadtDatentypen.EinheitenIDMitNullWert'First;
   LeerKoordinaten : constant KartenRecords.AchsenKartenfeldPositivRecord := (0, 0, 0);
   LeerHeimatstadt : constant EinheitStadtDatentypen.MaximaleStädteMitNullWert := EinheitStadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerLebenspunkte : constant EinheitStadtDatentypen.Lebenspunkte := EinheitStadtDatentypen.Lebenspunkte'First;
   LeerBewegungspunkte : constant EinheitStadtDatentypen.VorhandeneBewegungspunkte := EinheitStadtDatentypen.VorhandeneBewegungspunkte'First;
   LeerErfahrungspunkte : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;
   LeerRang : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;
   ----------------------- Beschäftigung und Tastenbelegung mal trennen?
   LeerBeschäftigung : constant AufgabenDatentypen.Einheiten_Aufgaben_Enum := AufgabenDatentypen.Leer_Aufgabe_Enum;
   LeerBeschäftigungszeit : constant EinheitStadtDatentypen.MaximaleStädteMitNullWert := EinheitStadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerKIBeschäftigt : constant KIDatentypen.Einheit_Aufgabe_Enum := KIDatentypen.Tut_Nichts_Enum;
   LeerTransportiert : constant EinheitStadtDatentypen.MaximaleEinheitenMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerWirdTransportiert : constant EinheitStadtDatentypen.MaximaleEinheitenMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerMeldung : constant EinheitStadtDatentypen.Einheit_Meldung_Enum := EinheitStadtDatentypen.Leer_Enum;
   
   LeerEinheit : constant EinheitStadtRecords.EinheitenGebautRecord := (
                                                                        ID                           => LeerID,
                                                                        KoordinatenAktuell           => LeerKoordinaten,
                                                                        Heimatstadt                  => LeerHeimatstadt,
                                                                        Lebenspunkte                 => LeerLebenspunkte,
                                                                        Bewegungspunkte              => LeerBewegungspunkte,
                                                                        Erfahrungspunkte             => LeerErfahrungspunkte,
                                                                        Rang                         => LeerRang,
                                                                        Beschäftigung                => LeerBeschäftigung,
                                                                        BeschäftigungNachfolger      => LeerBeschäftigung,
                                                                        Beschäftigungszeit           => LeerBeschäftigungszeit,
                                                                        BeschäftigungszeitNachfolger => LeerBeschäftigungszeit,
                                                                        KIZielKoordinaten            => LeerKoordinaten,
                                                                        KIBeschäftigt                => LeerKIBeschäftigt,
                                                                        KIBewegungPlan               => (others => LeerKoordinaten),
                                                                        Transportiert                => (others => LeerTransportiert),
                                                                        WirdTransportiert            => LeerWirdTransportiert,
                                                                        Meldungen                    => (others => LeerMeldung)
                                                                       );
   
   EinheitBefehlAbzug : constant Positive := 22;
      
   LeerEinheitenGrafik : constant Wide_Wide_Character := TextKonstanten.LeerZeichen;
   LeerEinheitArt : constant EinheitStadtDatentypen.Einheit_Art_Enum := EinheitStadtDatentypen.Leer_Enum;
   LeerPreisGeld : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerPreisRessourcen : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerPermanenteKosten : constant EinheitStadtDatentypen.GesamtePermanenteKosten := 0;
   LeerAnforderungen : constant EinheitStadtDatentypen.ForschungIDNichtMöglich := ForschungKonstanten.ForschungUnmöglich;
   LeerPassierbarkeit : constant Boolean := False;
   LeerMaximaleLebenspunkte : constant EinheitStadtDatentypen.LebenspunkteVorhanden := EinheitStadtDatentypen.LebenspunkteVorhanden'First;
   LeerMaximaleBewegungspunkte : constant EinheitStadtDatentypen.VorhandeneBewegungspunkte := 1.00;
   LeerWirdVerbessertZu : constant EinheitStadtDatentypen.EinheitenIDMitNullWert := EinheitStadtDatentypen.EinheitenIDMitNullWert'First;
   LeerBeförderungsgrenze : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;
   LeerMaximalerRang : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;
   LeerReichweite : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;
   LeerAngriff : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;
   LeerVerteidigung : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;
   LeerKannTransportieren : constant EinheitStadtDatentypen.Transport_Enum := EinheitStadtDatentypen.Kein_Transport_Enum;
   LeerKannTransportiertWerden : constant EinheitStadtDatentypen.Transport_Enum := EinheitStadtDatentypen.Kein_Transport_Enum;
   LeerTransportkapazität : constant EinheitStadtDatentypen.Transportplätze := EinheitStadtDatentypen.Transportplätze'First;
   
   LeerEinheitListe : constant DatenbankRecords.EinheitenlisteRecord := (
                                                                         EinheitArt                 => LeerEinheitArt,
                                                                         PreisGeld                  => LeerPreisGeld,
                                                                         PreisRessourcen            => LeerPreisRessourcen,
                                                                         PermanenteKosten           => (others => LeerPermanenteKosten),
                                                                         Anforderungen              => LeerAnforderungen,
                                                                         Passierbarkeit             => (others => LeerPassierbarkeit),
                                                                         MaximaleLebenspunkte       => LeerMaximaleLebenspunkte,
                                                                         MaximaleBewegungspunkte    => LeerMaximaleBewegungspunkte,
                                                                         WirdVerbessertZu           => LeerWirdVerbessertZu,
                                                                         Beförderungsgrenze         => LeerBeförderungsgrenze,
                                                                         MaximalerRang              => LeerMaximalerRang,
                                                                         Reichweite                 => LeerReichweite,
                                                                         Angriff                    => LeerAngriff,
                                                                         Verteidigung               => LeerVerteidigung,
                                                                         KannTransportieren         => LeerKannTransportieren,
                                                                         KannTransportiertWerden    => LeerKannTransportiertWerden,
                                                                         Transportkapazität         => LeerTransportkapazität
                                                                        );

end EinheitenKonstanten;
