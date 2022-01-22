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
   
   LeerRasse : constant SystemDatentypen.Rassen_Enum := SystemDatentypen.Keine_Rasse;
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
   LeerBauprojekt : constant EinheitStadtRecords.BauprojektRecord := (True, 0);
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

   MaximaleBauzeit : constant EinheitStadtDatentypen.KostenLager := EinheitStadtDatentypen.KostenLager'Last;
   
   LeerGebäudeGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
   LeerPreisGeld : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerPreisRessourcen : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerAnforderungen : constant EinheitStadtDatentypen.ForschungIDNichtMöglich := ForschungKonstanten.ForschungUnmöglich;
   LeerBonusWirtschaft : constant EinheitStadtDatentypen.ProduktionFeld := 0;
   LeerBonusKampf : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;
   LeerUmgebungBenötigt : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer;
   LeerSpezielleEigenschaft : constant EinheitStadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum := EinheitStadtDatentypen.Leer;
   
   LeerGebäudeListe : constant DatenbankRecords.GebäudeListeRecord := (
                                                                         GebäudeGrafik               => LeerGebäudeGrafik,
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
                                                                      SystemDatentypen.Menschen         => 10,
                                                                      SystemDatentypen.Kasrodiah        => 10,
                                                                      SystemDatentypen.Lasupin          => 10,
                                                                      SystemDatentypen.Lamustra         => 10,
                                                                      SystemDatentypen.Manuky           => 10,
                                                                      SystemDatentypen.Suroka           => 10,
                                                                      SystemDatentypen.Pryolon          => 10,
                                                                      SystemDatentypen.Talbidahr        => 10,
                                                                      SystemDatentypen.Moru_Phisihl     => 10,
                                                                      SystemDatentypen.Larinos_Lotaris  => 10,
                                                                      SystemDatentypen.Carupex          => 10,
                                                                      SystemDatentypen.Alary            => 10,
                                                                      SystemDatentypen.Tesorahn         => 10,
                                                                      SystemDatentypen.Natries_Zermanis => 10,
                                                                      SystemDatentypen.Tridatus         => 10,
                                                                      SystemDatentypen.Senelari         => 10,
                                                                      SystemDatentypen.Aspari_2         => 10,
                                                                      SystemDatentypen.Ekropa           => 10
                                                                     ),

                                                                   SystemDatentypen.Endwert =>
                                                                     (
                                                                      SystemDatentypen.Menschen         => 20,
                                                                      SystemDatentypen.Kasrodiah        => 20,
                                                                      SystemDatentypen.Lasupin          => 20,
                                                                      SystemDatentypen.Lamustra         => 20,
                                                                      SystemDatentypen.Manuky           => 20,
                                                                      SystemDatentypen.Suroka           => 20,
                                                                      SystemDatentypen.Pryolon          => 20,
                                                                      SystemDatentypen.Talbidahr        => 20,
                                                                      SystemDatentypen.Moru_Phisihl     => 20,
                                                                      SystemDatentypen.Larinos_Lotaris  => 20,
                                                                      SystemDatentypen.Carupex          => 20,
                                                                      SystemDatentypen.Alary            => 20,
                                                                      SystemDatentypen.Tesorahn         => 20,
                                                                      SystemDatentypen.Natries_Zermanis => 20,
                                                                      SystemDatentypen.Tridatus         => 20,
                                                                      SystemDatentypen.Senelari         => 20,
                                                                      SystemDatentypen.Aspari_2         => 20,
                                                                      SystemDatentypen.Ekropa           => 20
                                                                     )
                                                                  );

end StadtKonstanten;
