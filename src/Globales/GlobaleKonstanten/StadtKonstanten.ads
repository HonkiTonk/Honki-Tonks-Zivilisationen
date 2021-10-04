pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen, EinheitStadtRecords, SystemKonstanten, KartenRecords, ForschungKonstanten, EinheitStadtDatentypen, KartenDatentypen, SonstigeDatentypen;

with DatenbankRecords;

with KIDatentypen;

package StadtKonstanten is
   
   LeerRasse : constant SonstigeDatentypen.Rassen_Enum := SonstigeDatentypen.Leer;
   LeerNummer : constant EinheitStadtDatentypen.MaximaleStädteMitNullWert := EinheitStadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerRasseNummer : constant EinheitStadtRecords.RassePlatznummerRecord := (LeerRasse, LeerNummer);
   
   LeerID : constant KartenDatentypen.Karten_Verbesserung_Stadt_ID_Enum := KartenDatentypen.Leer;
   LeerPosition : constant KartenRecords.AchsenKartenfeldPositivRecord := (0, 0, 0);
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
   LeerBauprojekt : constant Natural := Natural'First;
   LeerBauzeit : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerKorruption : constant EinheitStadtDatentypen.GesamtproduktionStadt := 0;
   LeerGebäude : constant Boolean := False;
   LeerName : constant Unbounded_Wide_Wide_String := SystemKonstanten.LeerUnboundedString;
   LeerUmgebungBewitschaftet : constant Boolean := False;
   LeerUmgebungGröße : constant KartenDatentypen.LoopRangeMinusDreiZuDrei := 0;
   LeerMeldung : constant EinheitStadtDatentypen.Stadt_Meldung_Enum := EinheitStadtDatentypen.Leer;
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

   MaximaleBauzeit : constant EinheitStadtDatentypen.KostenLager := EinheitStadtDatentypen.KostenLager'Last;
   
   LeerGebäudeGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
   LeerPreisGeld : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerPreisRessourcen : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerAnforderungen : constant EinheitStadtDatentypen.ForschungIDMitNullWert := ForschungKonstanten.LeerForschungAnforderung;
   LeerPermanenterBonus : constant EinheitStadtDatentypen.ProduktionFeld := 0;
   LeerUmgebungBenötigt : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer;
   LeerSpezielleEigenschaft : constant EinheitStadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum := EinheitStadtDatentypen.Leer;
   
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
   
   type StadtUmgebungWachstumArray is array (GlobaleDatentypen.Anfang_Ende_Enum'Range, SonstigeDatentypen.Rassen_Verwendet_Enum'Range) of EinheitStadtDatentypen.ProduktionFeld;
   StadtUmgebungWachstum : constant StadtUmgebungWachstumArray := (
                                                                   GlobaleDatentypen.Anfangswert =>
                                                                     (
                                                                      SonstigeDatentypen.Menschen         => 10,
                                                                      SonstigeDatentypen.Kasrodiah        => 10,
                                                                      SonstigeDatentypen.Lasupin          => 10,
                                                                      SonstigeDatentypen.Lamustra         => 10,
                                                                      SonstigeDatentypen.Manuky           => 10,
                                                                      SonstigeDatentypen.Suroka           => 10,
                                                                      SonstigeDatentypen.Pryolon          => 10,
                                                                      SonstigeDatentypen.Talbidahr        => 10,
                                                                      SonstigeDatentypen.Moru_Phisihl     => 10,
                                                                      SonstigeDatentypen.Larinos_Lotaris  => 10,
                                                                      SonstigeDatentypen.Carupex          => 10,
                                                                      SonstigeDatentypen.Alary            => 10,
                                                                      SonstigeDatentypen.Tesorahn         => 10,
                                                                      SonstigeDatentypen.Natries_Zermanis => 10,
                                                                      SonstigeDatentypen.Tridatus         => 10,
                                                                      SonstigeDatentypen.Senelari         => 10,
                                                                      SonstigeDatentypen.Aspari_2         => 10,
                                                                      SonstigeDatentypen.Ekropa           => 10
                                                                     ),

                                                                   GlobaleDatentypen.Endwert =>
                                                                     (
                                                                      SonstigeDatentypen.Menschen         => 20,
                                                                      SonstigeDatentypen.Kasrodiah        => 20,
                                                                      SonstigeDatentypen.Lasupin          => 20,
                                                                      SonstigeDatentypen.Lamustra         => 20,
                                                                      SonstigeDatentypen.Manuky           => 20,
                                                                      SonstigeDatentypen.Suroka           => 20,
                                                                      SonstigeDatentypen.Pryolon          => 20,
                                                                      SonstigeDatentypen.Talbidahr        => 20,
                                                                      SonstigeDatentypen.Moru_Phisihl     => 20,
                                                                      SonstigeDatentypen.Larinos_Lotaris  => 20,
                                                                      SonstigeDatentypen.Carupex          => 20,
                                                                      SonstigeDatentypen.Alary            => 20,
                                                                      SonstigeDatentypen.Tesorahn         => 20,
                                                                      SonstigeDatentypen.Natries_Zermanis => 20,
                                                                      SonstigeDatentypen.Tridatus         => 20,
                                                                      SonstigeDatentypen.Senelari         => 20,
                                                                      SonstigeDatentypen.Aspari_2         => 20,
                                                                      SonstigeDatentypen.Ekropa           => 20
                                                                     )
                                                                  );

end StadtKonstanten;
