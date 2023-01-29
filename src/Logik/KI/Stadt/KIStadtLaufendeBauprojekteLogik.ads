with SpeziesDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with StadtRecords;
with StadtKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KIStadtLaufendeBauprojekteLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type StadtDatentypen.MaximaleStädteMitNullWert;
   use type StadtDatentypen.GebäudeIDMitNullwert;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   use type EinheitenDatentypen.EinheitenIDMitNullWert;

   function StadtLaufendeBauprojekte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BauprojektExtern : in StadtRecords.BauprojektRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 (if BauprojektExtern.Gebäude /= 0 then BauprojektExtern.Einheit = 0)
               and
                 (if BauprojektExtern.Einheit /= 0 then BauprojektExtern.Gebäude = 0)
              ),
   
       Post => (
                  StadtLaufendeBauprojekte'Result <= LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               );
   
   function GleicheEinheitArtBauprojekte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitArtExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              ),
   
       Post => (
                  GleicheEinheitArtBauprojekte'Result <= LeseGrenzen.Einheitengrenze (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               );
   
   function EinheitenInProduktion
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              ),
   
   -- Sollte so eine Post Bedingung nicht auf <= MaximaleStädte eingeschränkt sein? äöü
   -- Einen subtype für MaximaleEinheiten erstellen der nur bis MaximalStädte geht? äöü
     Post => (
                EinheitenInProduktion'Result <= LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
             );
   
private
   
   GleichesGebäudeBauprojekt : StadtDatentypen.MaximaleStädteMitNullWert;
   
   GleichesEinheitenBauprojekt : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   EinheitenImBau : EinheitenDatentypen.MaximaleEinheitenMitNullWert;

end KIStadtLaufendeBauprojekteLogik;
