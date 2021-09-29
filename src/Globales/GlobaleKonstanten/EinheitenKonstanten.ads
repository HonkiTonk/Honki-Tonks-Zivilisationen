pragma SPARK_Mode (On);

with GlobaleDatentypen, EinheitStadtRecords, SystemKonstanten, KartenRecords, ForschungKonstanten;

with DatenbankRecords;

with KIDatentypen;

package EinheitenKonstanten is
   
   LeerRasse : constant GlobaleDatentypen.Rassen_Enum := GlobaleDatentypen.Leer;
   LeerNummer : constant GlobaleDatentypen.MaximaleStädteMitNullWert := GlobaleDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerRasseNummer : constant EinheitStadtRecords.RassePlatznummerRecord := (LeerRasse, LeerNummer);

   LeerID : constant GlobaleDatentypen.EinheitenIDMitNullWert := GlobaleDatentypen.EinheitenIDMitNullWert'First;
   LeerPosition : constant KartenRecords.AchsenKartenfeldPositivRecord := (0, 0, 0);
   LeerHeimatstadt : constant GlobaleDatentypen.MaximaleStädteMitNullWert := GlobaleDatentypen.MaximaleStädteMitNullWert'First;
   LeerLebenspunkte : constant GlobaleDatentypen.MaximaleEinheitenMitNullWert := GlobaleDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerBewegungspunkte : constant GlobaleDatentypen.BewegungFloat := 0.00;
   LeerErfahrungspunkte : constant GlobaleDatentypen.MaximaleStädteMitNullWert := GlobaleDatentypen.MaximaleStädteMitNullWert'First;
   LeerRang : constant GlobaleDatentypen.MaximaleStädteMitNullWert := GlobaleDatentypen.MaximaleStädteMitNullWert'First;
   LeerBeschäftigung : constant GlobaleDatentypen.Tastenbelegung_Enum := GlobaleDatentypen.Leer;
   LeerBeschäftigungszeit : constant GlobaleDatentypen.MaximaleStädteMitNullWert := GlobaleDatentypen.MaximaleStädteMitNullWert'First;
   LeerKIBeschäftigt : constant KIDatentypen.Einheit_Aufgabe_Enum := KIDatentypen.Tut_Nichts;
   LeerTransportiert : constant GlobaleDatentypen.MaximaleEinheitenMitNullWert := GlobaleDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerWirdTransportiert : constant GlobaleDatentypen.MaximaleEinheitenMitNullWert := GlobaleDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerMeldung : constant GlobaleDatentypen.Einheit_Meldung_Enum := GlobaleDatentypen.Leer;
   
   LeerEinheit : constant EinheitStadtRecords.EinheitenGebautRecord := (
                                                                        ID                           => LeerID,
                                                                        Position                     => LeerPosition,
                                                                        Heimatstadt                  => LeerHeimatstadt,
                                                                        Lebenspunkte                 => LeerLebenspunkte,
                                                                        Bewegungspunkte              => LeerBewegungspunkte,
                                                                        Erfahrungspunkte             => LeerErfahrungspunkte,
                                                                        Rang                         => LeerRang,
                                                                        Beschäftigung                => LeerBeschäftigung,
                                                                        BeschäftigungNachfolger      => LeerBeschäftigung,
                                                                        Beschäftigungszeit           => LeerBeschäftigungszeit,
                                                                        BeschäftigungszeitNachfolger => LeerBeschäftigungszeit,
                                                                        KIZielKoordinaten            => LeerPosition,
                                                                        KIBeschäftigt                => LeerKIBeschäftigt,
                                                                        KIBewegungPlan               => (others => LeerPosition),
                                                                        Transportiert                => (others => LeerTransportiert),
                                                                        WirdTransportiert            => LeerWirdTransportiert,
                                                                        Meldungen                    => (others => LeerMeldung)
                                                                       );
   
   -- Den Aufschlag nach StadtKonstanten verschieben da er wohl nur beim Bauen in der Stadt benötigt wird?
   EinheitAufschlag : constant Positive := 10_000;
   
   EinheitBefehlAbzug : constant Positive := 21;
      
   LeerEinheitenGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
   LeerEinheitArt : constant GlobaleDatentypen.Einheit_Art_Enum := GlobaleDatentypen.Leer;
   LeerPreisGeld : constant GlobaleDatentypen.KostenLager := 0;
   LeerPreisRessourcen : constant GlobaleDatentypen.KostenLager := 0;
   LeerPermanenteKosten : constant GlobaleDatentypen.GesamtePermanenteKosten := 0;
   LeerAnforderungen : constant GlobaleDatentypen.ForschungIDMitNullWert := ForschungKonstanten.LeerForschungAnforderung;
   LeerPassierbarkeit : constant Boolean := False;
   LeerMaximaleLebenspunkte : constant GlobaleDatentypen.MaximaleEinheiten := GlobaleDatentypen.MaximaleEinheiten'First;
   LeerMaximaleBewegungspunkte : constant GlobaleDatentypen.BewegungFloat := 1.00;
   LeerWirdVerbessertZu : constant GlobaleDatentypen.EinheitenIDMitNullWert := GlobaleDatentypen.EinheitenIDMitNullWert'First;
   LeerBeförderungsgrenze : constant GlobaleDatentypen.MaximaleStädte := GlobaleDatentypen.MaximaleStädte'First;
   LeerMaximalerRang : constant GlobaleDatentypen.MaximaleStädte := GlobaleDatentypen.MaximaleStädte'First;
   LeerReichweite : constant GlobaleDatentypen.ProduktionFeld := 0;
   LeerAngriff : constant GlobaleDatentypen.ProduktionFeld := 0;
   LeerVerteidigung : constant GlobaleDatentypen.ProduktionFeld := 1;
   LeerKannTransportieren : constant GlobaleDatentypen.MaximaleEinheitenMitNullWert := GlobaleDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerKannTransportiertWerden : constant GlobaleDatentypen.MaximaleEinheitenMitNullWert := GlobaleDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerTransportkapazität : constant GlobaleDatentypen.MaximaleEinheitenMitNullWert := GlobaleDatentypen.MaximaleEinheitenMitNullWert'First;
   
   LeerEinheitListe : constant DatenbankRecords.EinheitenListeRecord := (
                                                                         EinheitenGrafik            => LeerEinheitenGrafik,
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
