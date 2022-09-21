pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with ForschungKonstanten;
with StadtDatentypen;
with KartenDatentypen;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with TextKonstanten;
with RassenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with StadtRecords;
with KampfDatentypen;

with KIDatentypen;

package StadtKonstanten is
   
   LeerRasse : constant RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;
   LeerNummer : constant StadtDatentypen.MaximaleStädteMitNullWert := StadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerRasseNummer : constant StadtRecords.RasseStadtnummerRecord := (LeerRasse, LeerNummer);
   
   LeerID : constant KartenverbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum := KartenverbesserungDatentypen.Leer_Verbesserung_Enum;
   LeerEinwohner : constant ProduktionDatentypen.Einwohner := 0;
   LeerArbeiter : constant ProduktionDatentypen.Einwohner := 0;
   LeerEinwohnerArbeiter : constant StadtRecords.EinwohnerArbeiterArray := (LeerEinwohner, LeerArbeiter);
   LeerNahrungsmittel : constant ProduktionDatentypen.StadtLagermenge := 0;
   LeerNahrungsproduktion : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerRessourcen : constant ProduktionDatentypen.StadtLagermenge := 0;
   LeerProduktionrate : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerGeldgewinnung : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerPermanenteKosten : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerForschungsrate : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerBauprojekt : constant StadtRecords.BauprojektRecord := (0, 0);
   LeerBauzeit : constant ProduktionDatentypen.Produktion := 0;
   LeerKorruption : constant ProduktionDatentypen.Stadtproduktion := 0;
   LeerZufriedenheit : constant ProduktionDatentypen.Feldproduktion := 0;
   LeerGebäude : constant Boolean := False;
   LeerName : constant Unbounded_Wide_Wide_String := TextKonstanten.LeerUnboundedString;
   LeerUmgebungBewitschaftet : constant Boolean := False;
   LeerUmgebungGröße : constant KartenDatentypen.UmgebungsbereichDrei := 0;
   LeerMeldung : constant StadtDatentypen.Stadt_Meldung_Enum := StadtDatentypen.Leer_Stadt_Meldung_Enum;
   LeerKIBeschäftigung : constant KIDatentypen.Stadt_Aufgabe_Enum := KIDatentypen.Keine_Aufgabe_Enum;
   
   

   MaximaleBauzeit : constant ProduktionDatentypen.Produktion := ProduktionDatentypen.Produktion'Last;
   
   LeerGebäudeID : constant StadtDatentypen.GebäudeIDMitNullwert := 0;
   LeerPreisGeld : constant ProduktionDatentypen.Produktion := 0;
   LeerPreisRessourcen : constant ProduktionDatentypen.Produktion := 0;
   LeerAnforderungen : constant ForschungenDatentypen.ForschungIDNichtMöglich := ForschungKonstanten.ForschungUnmöglich;
   LeerBonusWirtschaft : constant ProduktionDatentypen.Feldproduktion := 0;
   LeerBonusKampf : constant KampfDatentypen.Kampfwerte := KampfDatentypen.Kampfwerte'First;
   LeerGrundBenötigt : constant KartengrundDatentypen.Kartengrund_Enum := KartengrundDatentypen.Leer_Grund_Enum;
   LeerFlussBenötigt : constant Boolean := False;
   LeerRessourceBenötigt : constant KartengrundDatentypen.Kartenressourcen_Enum := KartengrundDatentypen.Leer_Ressource_Enum;
   LeerVerbesserungBenötigt : constant KartenverbesserungDatentypen.Karten_Verbesserung_Enum := KartenverbesserungDatentypen.Leer_Verbesserung_Enum;
   LeerSpezielleEigenschaft : constant StadtDatentypen.Gebäude_Spezielle_Eigenschaften_Enum := StadtDatentypen.Leer_Gebäude_Spezielle_Egienschaft_Enum;
   
   
   
   -- Das auch so ändern dass es davon einen Standardwert und einen einstellbaren Wert gibt. äöü
   type StadtUmgebungWachstumArray is array (SystemDatentypen.Anfang_Ende_Enum'Range, RassenDatentypen.Rassen_Verwendet_Enum'Range) of ProduktionDatentypen.Einwohner;
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
