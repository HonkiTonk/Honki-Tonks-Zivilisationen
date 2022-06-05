pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with KartenRecords;
with ForschungKonstanten;
with StadtDatentypen;
with KartenDatentypen;
with KartengrundDatentypen;
with KartenVerbesserungDatentypen;
with TextKonstanten;
with RassenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with StadtRecords;
with KampfDatentypen;

with DatenbankRecords;

with KIDatentypen;

package StadtKonstanten is
   
   LeerRasse : constant RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;
   LeerNummer : constant StadtDatentypen.MaximaleStädteMitNullWert := StadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerRasseNummer : constant StadtRecords.RasseStadtnummerRecord := (LeerRasse, LeerNummer);
   
   LeerID : constant KartenVerbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum := KartenVerbesserungDatentypen.Leer_Verbesserung_Enum;
   LeerKoordinaten : constant KartenRecords.AchsenKartenfeldNaturalRecord := (0, 0, 0);
   LeerEinwohner : constant ProduktionDatentypen.Feldproduktion := 0;
   LeerArbeiter : constant ProduktionDatentypen.Feldproduktion := 0;
   LeerEinwohnerArbeiter : constant StadtRecords.EinwohnerArbeiterArray := (LeerEinwohner, LeerArbeiter);
   LeerNahrungsmittel : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerNahrungsproduktion : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerRessourcen : constant ProduktionDatentypen.KostenLager := 0;
   LeerProduktionrate : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerGeldgewinnung : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerPermanenteKosten : constant ProduktionDatentypen.GesamtePermanenteKosten := 0;
   LeerForschungsrate : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerBauprojekt : constant StadtRecords.BauprojektRecord := (0, 0);
   LeerBauzeit : constant ProduktionDatentypen.KostenLager := 0;
   LeerKorruption : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerZufriedenheit : constant ProduktionDatentypen.Feldproduktion := 0;
   LeerGebäude : constant Boolean := False;
   LeerName : constant Unbounded_Wide_Wide_String := TextKonstanten.LeerUnboundedString;
   LeerUmgebungBewitschaftet : constant Boolean := False;
   LeerUmgebungGröße : constant KartenDatentypen.UmgebungsbereichDrei := 0;
   LeerMeldung : constant StadtDatentypen.Stadt_Meldung_Enum := StadtDatentypen.Leer_Stadt_Meldung_Enum;
   LeerKIBeschäftigung : constant KIDatentypen.Stadt_Aufgabe_Enum := KIDatentypen.Keine_Aufgabe_Enum;
   
   LeerStadt : constant StadtRecords.StadtGebautRecord := (
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

   MaximaleBauzeit : constant ProduktionDatentypen.KostenLager := ProduktionDatentypen.KostenLager'Last;
   
   LeerGebäudeID : constant StadtDatentypen.GebäudeIDMitNullwert := 0;
   LeerGebäudeGrafik : constant Wide_Wide_Character := TextKonstanten.LeerZeichen;
   LeerPreisGeld : constant ProduktionDatentypen.KostenLager := 0;
   LeerPreisRessourcen : constant ProduktionDatentypen.KostenLager := 0;
   LeerAnforderungen : constant ForschungenDatentypen.ForschungIDNichtMöglich := ForschungKonstanten.ForschungUnmöglich;
   LeerBonusWirtschaft : constant ProduktionDatentypen.Feldproduktion := 0;
   LeerBonusKampf : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;
   LeerGrundBenötigt : constant KartengrundDatentypen.Kartengrund_Enum := KartengrundDatentypen.Leer_Grund_Enum;
   LeerFlussBenötigt : constant Boolean := False;
   LeerRessourceBenötigt : constant KartengrundDatentypen.Kartenressourcen_Enum := KartengrundDatentypen.Leer_Ressource_Enum;
   LeerSpezielleEigenschaft : constant StadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum := StadtDatentypen.Leer_Gebäude_Spezielle_Egienschaft_Enum;
   
   LeerGebäudeListe : constant DatenbankRecords.GebäudelisteRecord := (
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
   
   type StadtUmgebungWachstumArray is array (SystemDatentypen.Anfang_Ende_Enum'Range, RassenDatentypen.Rassen_Verwendet_Enum'Range) of ProduktionDatentypen.Feldproduktion;
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
