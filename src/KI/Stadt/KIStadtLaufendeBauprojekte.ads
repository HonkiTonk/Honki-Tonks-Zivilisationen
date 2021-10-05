pragma SPARK_Mode (On);

with EinheitStadtRecords, SonstigeDatentypen, GlobaleVariablen, EinheitStadtDatentypen;
use SonstigeDatentypen;

package KIStadtLaufendeBauprojekte is

   function StadtLaufendeBauprojekte
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BauprojektExtern : in Natural)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI
          and
            BauprojektExtern <= 99_999);
   
   function GleicheEinheitArtBauprojekte
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitArtExtern : in EinheitStadtDatentypen.Einheit_Art_Verwendet_Enum)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_KI);
   
private
   
   GleichesBauprojekt : EinheitStadtDatentypen.MaximaleStädteMitNullWert;

end KIStadtLaufendeBauprojekte;
