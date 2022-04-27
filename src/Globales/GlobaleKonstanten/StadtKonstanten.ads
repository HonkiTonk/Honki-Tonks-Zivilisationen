pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with EinheitStadtRecords;
with KartenRecords;
with ForschungKonstanten;
with EinheitStadtDatentypen;
with KartenDatentypen;
with KartengrundDatentypen;
with KartenVerbesserungDatentypen;
with TextKonstanten;
with RassenDatentypen;

with DatenbankRecords;

with KIDatentypen;

package StadtKonstanten is
   
   LeerRasse : constant RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;
   LeerNummer : constant EinheitStadtDatentypen.MaximaleStädteMitNullWert := EinheitStadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerRasseNummer : constant EinheitStadtRecords.RassePlatznummerRecord := (LeerRasse, LeerNummer);
   
   LeerID : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum := KartenVerbesserungDatentypen.Leer_Verbesserung_Enum;
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
   LeerName : constant Unbounded_Wide_Wide_String := TextKonstanten.LeerUnboundedString;
   LeerUmgebungBewitschaftet : constant Boolean := False;
   LeerUmgebungGröße : constant KartenDatentypen.UmgebungsbereichDrei := 0;
   LeerMeldung : constant EinheitStadtDatentypen.Stadt_Meldung_Enum := EinheitStadtDatentypen.Leer_Enum;
   LeerKIBeschäftigung : constant KIDatentypen.Stadt_Aufgabe_Enum := KIDatentypen.Keine_Aufgabe_Enum;
   
   LeerStadt : constant EinheitStadtRecords.StadtGebautRecord := (
                                                                  ID                      => LeerID,
                                                                  KoordinatenAktuell      => LeerKoordinaten,
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
   
   LeerGebäudeGrafik : constant Wide_Wide_Character := TextKonstanten.LeerZeichen;
   LeerPreisGeld : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerPreisRessourcen : constant EinheitStadtDatentypen.KostenLager := 0;
   LeerAnforderungen : constant EinheitStadtDatentypen.ForschungIDNichtMöglich := ForschungKonstanten.ForschungUnmöglich;
   LeerBonusWirtschaft : constant EinheitStadtDatentypen.ProduktionFeld := 0;
   LeerBonusKampf : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;
   LeerGrundBenötigt : constant KartengrundDatentypen.Kartengrund_Enum := KartengrundDatentypen.Leer_Grund_Enum;
   LeerFlussBenötigt : constant Boolean := False;
   LeerRessourceBenötigt : constant KartengrundDatentypen.Karten_Ressourcen_Enum := KartengrundDatentypen.Leer_Ressource_Enum;
   LeerSpezielleEigenschaft : constant EinheitStadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum := EinheitStadtDatentypen.Leer_Enum;
   
   LeerGebäudeListe : constant DatenbankRecords.GebäudeListeRecord := (
                                                                         PreisGeld                   => LeerPreisGeld,
                                                                         PreisRessourcen             => LeerPreisRessourcen,
                                                                         PermanenteKosten            => (others => LeerPermanenteKosten),
                                                                         Anforderungen               => LeerAnforderungen,
                                                                         BonusWirtschaft             => (others => LeerBonusWirtschaft),
                                                                         BonusKampf                  => (others => LeerBonusKampf),
                                                                         GrundBenötigt               => LeerGrundBenötigt,
                                                                         FlussBenötigt               => LeerFlussBenötigt,
                                                                         RessourceBenötigt           => LeerRessourceBenötigt,
                                                                         GebäudeSpezielleEigenschaft => LeerSpezielleEigenschaft
                                                                        );
   
   type StadtUmgebungWachstumArray is array (SystemDatentypen.Anfang_Ende_Enum'Range, RassenDatentypen.Rassen_Verwendet_Enum'Range) of EinheitStadtDatentypen.ProduktionFeld;
   StadtUmgebungWachstum : constant StadtUmgebungWachstumArray := (
                                                                   SystemDatentypen.Anfangswert_Enum =>
                                                                     (
                                                                      RassenDatentypen.Menschen_Enum         => 10,
                                                                      RassenDatentypen.Kasrodiah_Enum        => 10,
                                                                      RassenDatentypen.Lasupin_Enum          => 10,
                                                                      RassenDatentypen.Lamustra_Enum         => 10,
                                                                      RassenDatentypen.Manuky_Enum           => 10,
                                                                      RassenDatentypen.Suroka_Enum           => 10,
                                                                      RassenDatentypen.Pryolon_Enum          => 10,
                                                                      RassenDatentypen.Talbidahr_Enum        => 10,
                                                                      RassenDatentypen.Moru_Phisihl_Enum     => 10,
                                                                      RassenDatentypen.Larinos_Lotaris_Enum  => 10,
                                                                      RassenDatentypen.Carupex_Enum          => 10,
                                                                      RassenDatentypen.Alary_Enum            => 10,
                                                                      RassenDatentypen.Tesorahn_Enum         => 10,
                                                                      RassenDatentypen.Natries_Zermanis_Enum => 10,
                                                                      RassenDatentypen.Tridatus_Enum         => 10,
                                                                      RassenDatentypen.Senelari_Enum         => 10,
                                                                      RassenDatentypen.Aspari_2_Enum         => 10,
                                                                      RassenDatentypen.Ekropa_Enum           => 10
                                                                     ),

                                                                   SystemDatentypen.Endwert_Enum =>
                                                                     (
                                                                      RassenDatentypen.Menschen_Enum         => 20,
                                                                      RassenDatentypen.Kasrodiah_Enum        => 20,
                                                                      RassenDatentypen.Lasupin_Enum          => 20,
                                                                      RassenDatentypen.Lamustra_Enum         => 20,
                                                                      RassenDatentypen.Manuky_Enum           => 20,
                                                                      RassenDatentypen.Suroka_Enum           => 20,
                                                                      RassenDatentypen.Pryolon_Enum          => 20,
                                                                      RassenDatentypen.Talbidahr_Enum        => 20,
                                                                      RassenDatentypen.Moru_Phisihl_Enum     => 20,
                                                                      RassenDatentypen.Larinos_Lotaris_Enum  => 20,
                                                                      RassenDatentypen.Carupex_Enum          => 20,
                                                                      RassenDatentypen.Alary_Enum            => 20,
                                                                      RassenDatentypen.Tesorahn_Enum         => 20,
                                                                      RassenDatentypen.Natries_Zermanis_Enum => 20,
                                                                      RassenDatentypen.Tridatus_Enum         => 20,
                                                                      RassenDatentypen.Senelari_Enum         => 20,
                                                                      RassenDatentypen.Aspari_2_Enum         => 20,
                                                                      RassenDatentypen.Ekropa_Enum           => 20
                                                                     )
                                                                  );

end StadtKonstanten;
