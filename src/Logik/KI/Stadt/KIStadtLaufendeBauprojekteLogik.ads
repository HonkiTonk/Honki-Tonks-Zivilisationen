with RassenDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with StadtRecords;
with SpielVariablen;

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
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
               and
                 (if BauprojektExtern.Gebäude /= 0 then BauprojektExtern.Einheit = 0)
               and
                 (if BauprojektExtern.Einheit /= 0 then BauprojektExtern.Gebäude = 0)
              ),
   
       Post => (
                  StadtLaufendeBauprojekte'Result <= SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               );
   
   function GleicheEinheitArtBauprojekte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitArtExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
              ),
   
       Post => (
                  GleicheEinheitArtBauprojekte'Result <= SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Einheitengrenze
               );
   
   function EinheitenInProduktion
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              ),
   
   -- Sollte so eine Post Bedingung nicht auf <= MaximaleStädte eingeschränkt sein? äöü
   -- Einen subtype für MaximaleEinheiten erstellen der nur bis MaximalStädte geht? äöü
       Post => (
                  EinheitenInProduktion'Result <= SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
               );
   
private
   
   GleichesGebäudeBauprojekt : StadtDatentypen.MaximaleStädteMitNullWert;
   
   GleichesEinheitenBauprojekt : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   EinheitenImBau : EinheitenDatentypen.MaximaleEinheitenMitNullWert;

end KIStadtLaufendeBauprojekteLogik;
