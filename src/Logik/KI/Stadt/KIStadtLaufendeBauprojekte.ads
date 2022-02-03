pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with SystemKonstanten;

package KIStadtLaufendeBauprojekte is

   function StadtLaufendeBauprojekte
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BauprojektExtern : in EinheitStadtRecords.BauprojektRecord)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);
   
   function GleicheEinheitArtBauprojekte
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      EinheitArtExtern : in EinheitStadtDatentypen.Einheit_Art_Verwendet_Enum)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in EinheitStadtDatentypen.MaximaleStädte'Range
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerKIKonstante);
   
private
   
   GleichesBauprojekt : EinheitStadtDatentypen.MaximaleStädteMitNullWert;

end KIStadtLaufendeBauprojekte;
