with RassenDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with StadtRecords;
with StadtKonstanten;

with LeseGrenzen;
with LeseRassenbelegung;

package KIStadtLaufendeBauprojekteLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type StadtDatentypen.MaximaleStädteMitNullWert;
   use type StadtDatentypen.GebäudeIDMitNullwert;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   use type EinheitenDatentypen.EinheitenIDMitNullWert;

   function StadtLaufendeBauprojekte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BauprojektExtern : in StadtRecords.BauprojektRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
               and
                 (if BauprojektExtern.Gebäude /= 0 then BauprojektExtern.Einheit = 0)
               and
                 (if BauprojektExtern.Einheit /= 0 then BauprojektExtern.Gebäude = 0)
              ),
   
       Post => (
                  StadtLaufendeBauprojekte'Result <= LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               );
   
   function GleicheEinheitArtBauprojekte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitArtExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              ),
   
       Post => (
                  GleicheEinheitArtBauprojekte'Result <= LeseGrenzen.Einheitengrenze (RasseExtern => StadtRasseNummerExtern.Rasse)
               );
   
   function EinheitenInProduktion
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.KI_Spieler_Enum
              ),
   
   -- Sollte so eine Post Bedingung nicht auf <= MaximaleStädte eingeschränkt sein? äöü
   -- Einen subtype für MaximaleEinheiten erstellen der nur bis MaximalStädte geht? äöü
       Post => (
                  EinheitenInProduktion'Result <= LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern)
               );
   
private
   
   GleichesGebäudeBauprojekt : StadtDatentypen.MaximaleStädteMitNullWert;
   
   GleichesEinheitenBauprojekt : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   EinheitenImBau : EinheitenDatentypen.MaximaleEinheitenMitNullWert;

end KIStadtLaufendeBauprojekteLogik;
