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
   
   LeerRasse : constant SystemDatentypen.Rassen_Enum := SystemDatentypen.Keine_Rasse;
   LeerNummer : constant EinheitStadtDatentypen.MaximaleStädteMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerRasseNummer : constant EinheitStadtRecords.RassePlatznummerRecord := (LeerRasse, LeerNummer);

   LeerID : constant EinheitStadtDatentypen.EinheitenIDMitNullWert := EinheitStadtDatentypen.EinheitenIDMitNullWert'First;
   LeerPosition : constant KartenRecords.AchsenKartenfeldPositivRecord := (0, 0, 0);
   LeerHeimatstadt : constant EinheitStadtDatentypen.MaximaleStädteMitNullWert := EinheitStadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerLebenspunkte : constant EinheitStadtDatentypen.MaximaleEinheitenMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerBewegungspunkte : constant EinheitStadtDatentypen.BewegungFloat := 0.00;
   LeerErfahrungspunkte : constant EinheitStadtDatentypen.MaximaleStädteMitNullWert := EinheitStadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerRang : constant EinheitStadtDatentypen.MaximaleStädteMitNullWert := EinheitStadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerBeschäftigung : constant SystemDatentypen.Tastenbelegung_Enum := SystemDatentypen.Leer;
   LeerBeschäftigungszeit : constant EinheitStadtDatentypen.MaximaleStädteMitNullWert := EinheitStadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerKIBeschäftigt : constant KIDatentypen.Einheit_Aufgabe_Enum := KIDatentypen.Tut_Nichts;
   LeerTransportiert : constant EinheitStadtDatentypen.MaximaleEinheitenMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerWirdTransportiert : constant EinheitStadtDatentypen.MaximaleEinheitenMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerMeldung : constant EinheitStadtDatentypen.Einheit_Meldung_Enum := EinheitStadtDatentypen.Leer;
   
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
   
   EinheitBefehlAbzug : constant Positive := 22;
      
   LeerEinheitenGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
   LeerEinheitArt : constant EinheitStadtDatentypen.Einheit_Art_Enum := EinheitStadtDatentypen.Leer;
   LeerPreisGeld : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerPreisRessourcen : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerPermanenteKosten : constant EinheitStadtDatentypen.GesamtePermanenteKosten := 0;
   LeerAnforderungen : constant EinheitStadtDatentypen.ForschungIDMitNullWert := ForschungKonstanten.LeerForschungAnforderung;
   LeerPassierbarkeit : constant Boolean := False;
   LeerMaximaleLebenspunkte : constant EinheitStadtDatentypen.MaximaleEinheiten := EinheitStadtDatentypen.MaximaleEinheiten'First;
   LeerMaximaleBewegungspunkte : constant EinheitStadtDatentypen.BewegungFloat := 1.00;
   LeerWirdVerbessertZu : constant EinheitStadtDatentypen.EinheitenIDMitNullWert := EinheitStadtDatentypen.EinheitenIDMitNullWert'First;
   LeerBeförderungsgrenze : constant EinheitStadtDatentypen.MaximaleStädte := EinheitStadtDatentypen.MaximaleStädte'First;
   LeerMaximalerRang : constant EinheitStadtDatentypen.MaximaleStädte := EinheitStadtDatentypen.MaximaleStädte'First;
   LeerReichweite : constant EinheitStadtDatentypen.ProduktionFeld := 0;
   LeerAngriff : constant EinheitStadtDatentypen.ProduktionFeld := 0;
   LeerVerteidigung : constant EinheitStadtDatentypen.ProduktionFeld := 1;
   LeerKannTransportieren : constant EinheitStadtDatentypen.MaximaleEinheitenMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerKannTransportiertWerden : constant EinheitStadtDatentypen.MaximaleEinheitenMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerTransportkapazität : constant EinheitStadtDatentypen.MaximaleEinheitenMitNullWert := EinheitStadtDatentypen.MaximaleEinheitenMitNullWert'First;
   
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
