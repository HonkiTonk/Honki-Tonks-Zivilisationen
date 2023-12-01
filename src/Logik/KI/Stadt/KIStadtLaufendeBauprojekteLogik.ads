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
   use type StadtDatentypen.Städtebereich;
   use type StadtDatentypen.GebäudeID;
   use type EinheitenDatentypen.Einheitenbereich;
   use type EinheitenDatentypen.EinheitenID;

   function StadtLaufendeBauprojekte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BauprojektExtern : in StadtRecords.BauprojektRecord)
      return StadtDatentypen.Städtebereich
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
      return EinheitenDatentypen.Einheitenbereich
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return EinheitenDatentypen.Einheitenbereich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              ),
   
   -- Einen subtype für MaximaleEinheiten erstellen der nur bis MaximaleStädte geht? äöü
   -- Ist <= Städtegrenzen, da ja nicht mehr Einheiten gebaut werden kann als Städte vorhanden sind.
     Post => (
                EinheitenInProduktion'Result <= EinheitenDatentypen.Einheitenbereich (LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern))
             );
   
private
   
   GleichesGebäudeBauprojekt : StadtDatentypen.Städtebereich;
   
   GleichesEinheitenBauprojekt : EinheitenDatentypen.Einheitenbereich;
   EinheitenImBau : EinheitenDatentypen.Einheitenbereich;

end KIStadtLaufendeBauprojekteLogik;
