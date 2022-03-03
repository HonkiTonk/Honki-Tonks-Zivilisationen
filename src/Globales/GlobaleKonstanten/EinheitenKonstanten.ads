pragma SPARK_Mode (On);

with EinheitStadtRecords;
with SystemKonstanten;
with KartenRecords;
with ForschungKonstanten;
with EinheitStadtDatentypen;
with SystemDatentypen;

with DatenbankRecords;

with KIDatentypen;

package EinheitenKonstanten is
   
   LeerRasse : constant SystemDatentypen.Rassen_Enum := SystemKonstanten.LeerRasse;
   LeerNummer : constant EinheitStadtDatentypen.MaximaleStädteMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerRasseNummer : constant EinheitStadtRecords.RassePlatznummerRecord := (LeerRasse, LeerNummer);

   LeerID : constant EinheitStadtDatentypen.EinheitenIDMitNullWert := EinheitStadtDatentypen.EinheitenIDMitNullWert'First;
   LeerKoordinaten : constant KartenRecords.AchsenKartenfeldPositivRecord := (0, 0, 0);
   LeerHeimatstadt : constant EinheitStadtDatentypen.MaximaleStädteMitNullWert := EinheitStadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerLebenspunkte : constant EinheitStadtDatentypen.Lebenspunkte := EinheitStadtDatentypen.Lebenspunkte'First;
   LeerBewegungspunkte : constant EinheitStadtDatentypen.VorhandeneBewegungspunkte := EinheitStadtDatentypen.VorhandeneBewegungspunkte'First;
   LeerErfahrungspunkte : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;
   LeerRang : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;
   LeerBeschäftigung : constant SystemDatentypen.Tastenbelegung_Enum := SystemKonstanten.LeerTastenbelegungKonstante;
   LeerBeschäftigungszeit : constant EinheitStadtDatentypen.MaximaleStädteMitNullWert := EinheitStadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerKIBeschäftigt : constant KIDatentypen.Einheit_Aufgabe_Enum := KIDatentypen.Tut_Nichts;
   LeerTransportiert : constant EinheitStadtDatentypen.MaximaleEinheitenMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerWirdTransportiert : constant EinheitStadtDatentypen.MaximaleEinheitenMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerMeldung : constant EinheitStadtDatentypen.Einheit_Meldung_Enum := EinheitStadtDatentypen.Leer;
   
   LeerEinheit : constant EinheitStadtRecords.EinheitenGebautRecord := (
                                                                        ID                           => LeerID,
                                                                        Koordinaten                  => LeerKoordinaten,
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
      
   LeerEinheitenGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
   LeerEinheitArt : constant EinheitStadtDatentypen.Einheit_Art_Enum := EinheitStadtDatentypen.Leer;
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
   LeerKannTransportieren : constant EinheitStadtDatentypen.Transportwerte := EinheitStadtDatentypen.Transportwerte'First;
   LeerKannTransportiertWerden : constant EinheitStadtDatentypen.Transportwerte := EinheitStadtDatentypen.Transportwerte'First;
   LeerTransportkapazität : constant EinheitStadtDatentypen.Transportwerte := EinheitStadtDatentypen.Transportwerte'First;
   
   LeerEinheitListe : constant DatenbankRecords.EinheitenListeRecord := (
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
