pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, EinheitStadtRecords, SystemKonstanten, KartenRecords, ForschungKonstanten;

with DatenbankRecords;

with KIDatentypen;

package StadtKonstanten is
   
   LeerRasse : constant GlobaleDatentypen.Rassen_Enum := GlobaleDatentypen.Leer;
   LeerNummer : constant GlobaleDatentypen.MaximaleStädteMitNullWert := GlobaleDatentypen.MaximaleStädteMitNullWert'First;
   LeerRasseNummer : constant EinheitStadtRecords.RassePlatznummerRecord := (LeerRasse, LeerNummer);
   
   LeerID : constant GlobaleDatentypen.Karten_Verbesserung_Stadt_ID_Enum := GlobaleDatentypen.Leer;
   LeerPosition : constant KartenRecords.AchsenKartenfeldPositivRecord := (0, 0, 0);
   LeerEinwohner : constant GlobaleDatentypen.ProduktionFeld := 0;
   LeerArbeiter : constant GlobaleDatentypen.ProduktionFeld := 0;
   LeerEinwohnerArbeiter : constant EinheitStadtRecords.EinwohnerArbeiterArray := (LeerEinwohner, LeerArbeiter);
   LeerNahrungsmittel : constant GlobaleDatentypen.GesamtproduktionStadt := 0;
   LeerNahrungsproduktion : constant GlobaleDatentypen.GesamtproduktionStadt := 0;
   LeerRessourcen : constant GlobaleDatentypen.KostenLager := 0;
   LeerProduktionrate : constant GlobaleDatentypen.GesamtproduktionStadt := 0;
   LeerGeldgewinnung : constant GlobaleDatentypen.GesamtproduktionStadt := 0;
   LeerPermanenteKosten : constant GlobaleDatentypen.GesamtePermanenteKosten := 0;
   LeerForschungsrate : constant GlobaleDatentypen.GesamtproduktionStadt := 0;
   LeerBauprojekt : constant Natural := Natural'First;
   LeerBauzeit : constant GlobaleDatentypen.KostenLager := 0;
   LeerKorruption : constant GlobaleDatentypen.GesamtproduktionStadt := 0;
   LeerGebäude : constant Boolean := False;
   LeerName : constant Unbounded_Wide_Wide_String := SystemKonstanten.LeerUnboundedString;
   LeerUmgebungBewitschaftet : constant Boolean := False;
   LeerUmgebungGröße : constant GlobaleDatentypen.LoopRangeMinusDreiZuDrei := 0;
   LeerMeldung : constant GlobaleDatentypen.Stadt_Meldung_Enum := GlobaleDatentypen.Leer;
   LeerKIBeschäftigung : constant KIDatentypen.Stadt_Aufgabe_Enum := KIDatentypen.Keine_Aufgabe;
   
   LeerStadt : constant EinheitStadtRecords.StadtGebautRecord := (
                                                                  ID                      => LeerID,
                                                                  Position                => LeerPosition,
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
                                                                  GebäudeVorhanden        => (others => LeerGebäude),
                                                                  Name                    => LeerName,
                                                                  UmgebungBewirtschaftung => (others => (others => LeerUmgebungBewitschaftet)),
                                                                  UmgebungGröße           => LeerUmgebungGröße,
                                                                  Meldungen               => (others => LeerMeldung),
                                                                  KIBeschäftigung         => LeerKIBeschäftigung
                                                                 );
   
   GebäudeAufschlag : constant Positive := 1_000;

   BauprojekteGebäudeAnfang : constant Positive := 1_001;
   BauprojekteGebäudeEnde : constant Positive := 9_999;
   BauprojekteEinheitenAnfang : constant Positive := 10_001;
   BauprojekteEinheitenEnde : constant Positive := 99_999;

   MaximaleBauzeit : constant GlobaleDatentypen.KostenLager := GlobaleDatentypen.KostenLager'Last;
   
   LeerGebäudeGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
   LeerPreisGeld : constant GlobaleDatentypen.KostenLager := 0;
   LeerPreisRessourcen : constant GlobaleDatentypen.KostenLager := 0;
   LeerAnforderungen : constant GlobaleDatentypen.ForschungIDMitNullWert := ForschungKonstanten.LeerForschungAnforderung;
   LeerPermanenterBonus : constant GlobaleDatentypen.ProduktionFeld := 0;
   LeerUmgebungBenötigt : constant GlobaleDatentypen.Karten_Grund_Enum := GlobaleDatentypen.Leer;
   LeerSpezielleEigenschaft : constant GlobaleDatentypen.Gebäude_Spezielle_Eigenschaften_Enum := GlobaleDatentypen.Leer;
   
   LeerGebäudeListe : constant DatenbankRecords.GebäudeListeRecord := (
                                                                         GebäudeGrafik               => LeerGebäudeGrafik,
                                                                         PreisGeld                   => LeerPreisGeld,
                                                                         PreisRessourcen             => LeerPreisRessourcen,
                                                                         PermanenteKosten            => (others => LeerPermanenteKosten),
                                                                         Anforderungen               => LeerAnforderungen,
                                                                         PermanenterBonus            => (others => LeerPermanenterBonus),
                                                                         UmgebungBenötigt            => LeerUmgebungBenötigt,
                                                                         GebäudeSpezielleEigenschaft => LeerSpezielleEigenschaft
                                                                        );
   
   type StadtUmgebungWachstumArray is array (GlobaleDatentypen.Anfang_Ende_Enum'Range, GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of GlobaleDatentypen.ProduktionFeld;
   StadtUmgebungWachstum : constant StadtUmgebungWachstumArray := (
                                                                   GlobaleDatentypen.Anfangswert =>
                                                                     (
                                                                      GlobaleDatentypen.Menschen         => 10,
                                                                      GlobaleDatentypen.Kasrodiah        => 10,
                                                                      GlobaleDatentypen.Lasupin          => 10,
                                                                      GlobaleDatentypen.Lamustra         => 10,
                                                                      GlobaleDatentypen.Manuky           => 10,
                                                                      GlobaleDatentypen.Suroka           => 10,
                                                                      GlobaleDatentypen.Pryolon          => 10,
                                                                      GlobaleDatentypen.Talbidahr        => 10,
                                                                      GlobaleDatentypen.Moru_Phisihl     => 10,
                                                                      GlobaleDatentypen.Larinos_Lotaris  => 10,
                                                                      GlobaleDatentypen.Carupex          => 10,
                                                                      GlobaleDatentypen.Alary            => 10,
                                                                      GlobaleDatentypen.Tesorahn         => 10,
                                                                      GlobaleDatentypen.Natries_Zermanis => 10,
                                                                      GlobaleDatentypen.Tridatus         => 10,
                                                                      GlobaleDatentypen.Senelari         => 10,
                                                                      GlobaleDatentypen.Aspari_2         => 10,
                                                                      GlobaleDatentypen.Ekropa           => 10
                                                                     ),

                                                                   GlobaleDatentypen.Endwert =>
                                                                     (
                                                                      GlobaleDatentypen.Menschen         => 20,
                                                                      GlobaleDatentypen.Kasrodiah        => 20,
                                                                      GlobaleDatentypen.Lasupin          => 20,
                                                                      GlobaleDatentypen.Lamustra         => 20,
                                                                      GlobaleDatentypen.Manuky           => 20,
                                                                      GlobaleDatentypen.Suroka           => 20,
                                                                      GlobaleDatentypen.Pryolon          => 20,
                                                                      GlobaleDatentypen.Talbidahr        => 20,
                                                                      GlobaleDatentypen.Moru_Phisihl     => 20,
                                                                      GlobaleDatentypen.Larinos_Lotaris  => 20,
                                                                      GlobaleDatentypen.Carupex          => 20,
                                                                      GlobaleDatentypen.Alary            => 20,
                                                                      GlobaleDatentypen.Tesorahn         => 20,
                                                                      GlobaleDatentypen.Natries_Zermanis => 20,
                                                                      GlobaleDatentypen.Tridatus         => 20,
                                                                      GlobaleDatentypen.Senelari         => 20,
                                                                      GlobaleDatentypen.Aspari_2         => 20,
                                                                      GlobaleDatentypen.Ekropa           => 20
                                                                     )
                                                                  );

end StadtKonstanten;
