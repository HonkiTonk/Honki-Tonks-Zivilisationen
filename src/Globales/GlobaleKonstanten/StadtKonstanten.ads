pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with EinheitStadtRecords;
with SystemKonstanten;
with KartenRecords;
with ForschungKonstanten;
with EinheitStadtDatentypen;
with KartenDatentypen;

with DatenbankRecords;

with KIDatentypen;

package StadtKonstanten is
   
   LeerRasse : constant SystemDatentypen.Rassen_Enum := SystemKonstanten.LeerRasse;
   LeerNummer : constant EinheitStadtDatentypen.MaximaleStädteMitNullWert := EinheitStadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerRasseNummer : constant EinheitStadtRecords.RassePlatznummerRecord := (LeerRasse, LeerNummer);
   
   LeerID : constant KartenDatentypen.Karten_Verbesserung_Stadt_ID_Enum := KartenDatentypen.Leer_Verbesserung;
   LeerKoordinaten : constant KartenRecords.AchsenKartenfeldPositivRecord := (0, 0, 0);
   LeerEinwohner : constant EinheitStadtDatentypen.ProduktionFeld := 0;
   LeerArbeiter : constant EinheitStadtDatentypen.ProduktionFeld := 0;
   LeerEinwohnerArbeiter : constant EinheitStadtRecords.EinwohnerArbeiterArray := (LeerEinwohner, LeerArbeiter);
   LeerNahrungsmittel : constant EinheitStadtDatentypen.GesamtproduktionStadt := 0;
   LeerNahrungsproduktion : constant EinheitStadtDatentypen.GesamtproduktionStadt := 0;
   LeerRessourcen : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerProduktionrate : constant EinheitStadtDatentypen.GesamtproduktionStadt := 0;
   LeerGeldgewinnung : constant EinheitStadtDatentypen.GesamtproduktionStadt := 0;
   LeerPermanenteKosten : constant EinheitStadtDatentypen.GesamtePermanenteKosten := 0;
   LeerForschungsrate : constant EinheitStadtDatentypen.GesamtproduktionStadt := 0;
   LeerBauprojekt : constant EinheitStadtRecords.BauprojektRecord := (True, 0);
   LeerBauzeit : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerKorruption : constant EinheitStadtDatentypen.GesamtproduktionStadt := 0;
   LeerZufriedenheit : constant EinheitStadtDatentypen.ProduktionFeld := 0;
   LeerGebäude : constant Boolean := False;
   LeerName : constant Unbounded_Wide_Wide_String := SystemKonstanten.LeerUnboundedString;
   LeerUmgebungBewitschaftet : constant Boolean := False;
   LeerUmgebungGröße : constant KartenDatentypen.UmgebungsbereichDrei := 0;
   LeerMeldung : constant EinheitStadtDatentypen.Stadt_Meldung_Enum := EinheitStadtDatentypen.Leer;
   LeerKIBeschäftigung : constant KIDatentypen.Stadt_Aufgabe_Enum := KIDatentypen.Keine_Aufgabe;
   
   LeerStadt : constant EinheitStadtRecords.StadtGebautRecord := (
                                                                  ID                      => LeerID,
                                                                  Koordinaten             => LeerKoordinaten,
                                                                  EinwohnerArbeiter       => LeerEinwohnerArbeiter,
                                                                  Nahrungsmittel          => LeerNahrungsmittel,
                                                                  Nahrungsproduktion      => LeerNahrungsproduktion,
                                                                  Ressourcen              => LeerRessourcen,
                                                                  Produktionrate          => LeerProduktionrate,
                                                                  Geldgewinnung           => LeerGeldgewinnung,
                                                                  PermanenteKostenPosten  => (others => LeerPermanenteKosten),
                                                                  Forschungsrate          => LeerForschungsrate,
                                                                  Bauprojekt              => LeerBauprojekt,
                                                                  Bauzeit                 => LeerBauzeit,
                                                                  Korruption              => LeerKorruption,
                                                                  Zufriedenheit           => LeerZufriedenheit,
                                                                  GebäudeVorhanden        => (others => LeerGebäude),
                                                                  Name                    => LeerName,
                                                                  UmgebungBewirtschaftung => (others => (others => LeerUmgebungBewitschaftet)),
                                                                  UmgebungGröße           => LeerUmgebungGröße,
                                                                  Meldungen               => (others => LeerMeldung),
                                                                  KIBeschäftigung         => LeerKIBeschäftigung
                                                                 );

   MaximaleBauzeit : constant EinheitStadtDatentypen.KostenLager := EinheitStadtDatentypen.KostenLager'Last;
   
   LeerGebäudeGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
   LeerPreisGeld : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerPreisRessourcen : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerAnforderungen : constant EinheitStadtDatentypen.ForschungIDNichtMöglich := ForschungKonstanten.ForschungUnmöglich;
   LeerBonusWirtschaft : constant EinheitStadtDatentypen.ProduktionFeld := 0;
   LeerBonusKampf : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;
   LeerUmgebungBenötigt : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer_Grund;
   LeerSpezielleEigenschaft : constant EinheitStadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum := EinheitStadtDatentypen.Leer;
   
   LeerGebäudeListe : constant DatenbankRecords.GebäudeListeRecord := (
                                                                         PreisGeld                   => LeerPreisGeld,
                                                                         PreisRessourcen             => LeerPreisRessourcen,
                                                                         PermanenteKosten            => (others => LeerPermanenteKosten),
                                                                         Anforderungen               => LeerAnforderungen,
                                                                         BonusWirtschaft             => (others => LeerBonusWirtschaft),
                                                                         BonusKampf                  => (others => LeerBonusKampf),
                                                                         UmgebungBenötigt            => LeerUmgebungBenötigt,
                                                                         GebäudeSpezielleEigenschaft => LeerSpezielleEigenschaft
                                                                        );
   
   type StadtUmgebungWachstumArray is array (SystemDatentypen.Anfang_Ende_Enum'Range, SystemDatentypen.Rassen_Verwendet_Enum'Range) of EinheitStadtDatentypen.ProduktionFeld;
   StadtUmgebungWachstum : constant StadtUmgebungWachstumArray := (
                                                                   SystemDatentypen.Anfangswert =>
                                                                     (
                                                                      SystemKonstanten.MenschenKonstante        => 10,
                                                                      SystemKonstanten.KasrodiahKonstante       => 10,
                                                                      SystemKonstanten.LasupinKonstante         => 10,
                                                                      SystemKonstanten.LamustraKonstante        => 10,
                                                                      SystemKonstanten.ManukyKonstante          => 10,
                                                                      SystemKonstanten.SurokaKonstante          => 10,
                                                                      SystemKonstanten.PryolonKonstante         => 10,
                                                                      SystemKonstanten.TalbidahrKonstante       => 10,
                                                                      SystemKonstanten.MoruPhisihlKonstante     => 10,
                                                                      SystemKonstanten.LarinosLotarisKonstante  => 10,
                                                                      SystemKonstanten.CarupexKonstante         => 10,
                                                                      SystemKonstanten.AlaryKonstante           => 10,
                                                                      SystemKonstanten.TesorahnKonstante        => 10,
                                                                      SystemKonstanten.NatriesZermanisKonstante => 10,
                                                                      SystemKonstanten.TridatusKonstante        => 10,
                                                                      SystemKonstanten.SenelariKonstante        => 10,
                                                                      SystemKonstanten.Aspari2Konstante         => 10,
                                                                      SystemKonstanten.EkropaKonstante          => 10
                                                                     ),

                                                                   SystemDatentypen.Endwert =>
                                                                     (
                                                                      SystemKonstanten.MenschenKonstante        => 20,
                                                                      SystemKonstanten.KasrodiahKonstante       => 20,
                                                                      SystemKonstanten.LasupinKonstante         => 20,
                                                                      SystemKonstanten.LamustraKonstante        => 20,
                                                                      SystemKonstanten.ManukyKonstante          => 20,
                                                                      SystemKonstanten.SurokaKonstante          => 20,
                                                                      SystemKonstanten.PryolonKonstante         => 20,
                                                                      SystemKonstanten.TalbidahrKonstante       => 20,
                                                                      SystemKonstanten.MoruPhisihlKonstante     => 20,
                                                                      SystemKonstanten.LarinosLotarisKonstante  => 20,
                                                                      SystemKonstanten.CarupexKonstante         => 20,
                                                                      SystemKonstanten.AlaryKonstante           => 20,
                                                                      SystemKonstanten.TesorahnKonstante        => 20,
                                                                      SystemKonstanten.NatriesZermanisKonstante => 20,
                                                                      SystemKonstanten.TridatusKonstante        => 20,
                                                                      SystemKonstanten.SenelariKonstante        => 20,
                                                                      SystemKonstanten.Aspari2Konstante         => 20,
                                                                      SystemKonstanten.EkropaKonstante          => 20
                                                                     )
                                                                  );

end StadtKonstanten;
