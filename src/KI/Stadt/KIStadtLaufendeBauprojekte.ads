pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package KIStadtLaufendeBauprojekte is

   function StadtLaufendeBauprojekte
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      BauprojektExtern : in Natural)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
          and
            BauprojektExtern <= 99_999);
   
   function GleicheEinheitArtBauprojekte
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitArtExtern : in GlobaleDatentypen.Einheit_Art_Verwendet_Enum)
      return GlobaleDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI);
   
private
   
   GleichesBauprojekt : GlobaleDatentypen.MaximaleStädteMitNullWert;

end KIStadtLaufendeBauprojekte;
