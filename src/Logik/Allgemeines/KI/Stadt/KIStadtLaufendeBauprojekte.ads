pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with StadtDatentypen; use StadtDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with SonstigeVariablen;
with StadtRecords;
with SpielVariablen;

package KIStadtLaufendeBauprojekte is

   function StadtLaufendeBauprojekte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BauprojektExtern : in StadtRecords.BauprojektRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum
          and
            (if BauprojektExtern.Gebäude /= 0 then BauprojektExtern.Einheit = 0)
          and
            (if BauprojektExtern.Einheit /= 0 then BauprojektExtern.Gebäude = 0)),
   
         Post =>
           (StadtLaufendeBauprojekte'Result in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze);
   
   function GleicheEinheitArtBauprojekte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitArtExtern : in EinheitenDatentypen.Einheit_Art_Verwendet_Enum)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum),
   
         Post =>
           (GleicheEinheitArtBauprojekte'Result in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Einheitengrenze);
   
private
   
   GleichesGebäudeBauprojekt : StadtDatentypen.MaximaleStädteMitNullWert;
   
   GleichesEinheitenBauprojekt : EinheitenDatentypen.MaximaleEinheitenMitNullWert;

end KIStadtLaufendeBauprojekte;
