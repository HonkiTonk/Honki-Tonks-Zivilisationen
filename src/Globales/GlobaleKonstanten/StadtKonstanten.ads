pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with EinheitStadtRecords;
with KartenRecords;
with ForschungKonstanten;
with EinheitStadtDatentypen;
with KartenDatentypen;
with KartenGrundDatentypen;
with KartenVerbesserungDatentypen;
with TextKonstanten;

with DatenbankRecords;

with KIDatentypen;

package StadtKonstanten is
   
   LeerRasse : constant SystemDatentypen.Rassen_Enum := SystemDatentypen.Keine_Rasse_Enum;
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
   LeerGrundBenötigt : constant KartenGrundDatentypen.Karten_Grund_Enum := KartenGrundDatentypen.Leer_Grund_Enum;
   LeerFlussBenötigt : constant Boolean := False;
   LeerRessourceBenötigt : constant KartenGrundDatentypen.Karten_Ressourcen_Enum := KartenGrundDatentypen.Leer_Ressource_Enum;
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
   
   type StadtUmgebungWachstumArray is array (SystemDatentypen.Anfang_Ende_Enum'Range, SystemDatentypen.Rassen_Verwendet_Enum'Range) of EinheitStadtDatentypen.ProduktionFeld;
   StadtUmgebungWachstum : constant StadtUmgebungWachstumArray := (
                                                                   SystemDatentypen.Anfangswert_Enum =>
                                                                     (
                                                                      SystemDatentypen.Menschen_Enum        => 10,
                                                                      SystemDatentypen.Kasrodiah_Enum       => 10,
                                                                      SystemDatentypen.Lasupin_Enum         => 10,
                                                                      SystemDatentypen.Lamustra_Enum        => 10,
                                                                      SystemDatentypen.Manuky_Enum          => 10,
                                                                      SystemDatentypen.Suroka_Enum          => 10,
                                                                      SystemDatentypen.Pryolon_Enum         => 10,
                                                                      SystemDatentypen.Talbidahr_Enum       => 10,
                                                                      SystemDatentypen.Moru_Phisihl_Enum     => 10,
                                                                      SystemDatentypen.Larinos_Lotaris_Enum  => 10,
                                                                      SystemDatentypen.Carupex_Enum         => 10,
                                                                      SystemDatentypen.Alary_Enum           => 10,
                                                                      SystemDatentypen.Tesorahn_Enum        => 10,
                                                                      SystemDatentypen.Natries_Zermanis_Enum => 10,
                                                                      SystemDatentypen.Tridatus_Enum        => 10,
                                                                      SystemDatentypen.Senelari_Enum        => 10,
                                                                      SystemDatentypen.Aspari_2_Enum         => 10,
                                                                      SystemDatentypen.Ekropa_Enum          => 10
                                                                     ),

                                                                   SystemDatentypen.Endwert_Enum =>
                                                                     (
                                                                      SystemDatentypen.Menschen_Enum        => 20,
                                                                      SystemDatentypen.Kasrodiah_Enum       => 20,
                                                                      SystemDatentypen.Lasupin_Enum         => 20,
                                                                      SystemDatentypen.Lamustra_Enum        => 20,
                                                                      SystemDatentypen.Manuky_Enum          => 20,
                                                                      SystemDatentypen.Suroka_Enum          => 20,
                                                                      SystemDatentypen.Pryolon_Enum         => 20,
                                                                      SystemDatentypen.Talbidahr_Enum       => 20,
                                                                      SystemDatentypen.Moru_Phisihl_Enum     => 20,
                                                                      SystemDatentypen.Larinos_Lotaris_Enum  => 20,
                                                                      SystemDatentypen.Carupex_Enum         => 20,
                                                                      SystemDatentypen.Alary_Enum           => 20,
                                                                      SystemDatentypen.Tesorahn_Enum        => 20,
                                                                      SystemDatentypen.Natries_Zermanis_Enum => 20,
                                                                      SystemDatentypen.Tridatus_Enum        => 20,
                                                                      SystemDatentypen.Senelari_Enum        => 20,
                                                                      SystemDatentypen.Aspari_2_Enum         => 20,
                                                                      SystemDatentypen.Ekropa_Enum          => 20
                                                                     )
                                                                  );

end StadtKonstanten;
