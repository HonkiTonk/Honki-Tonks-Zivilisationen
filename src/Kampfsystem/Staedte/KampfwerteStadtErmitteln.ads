pragma SPARK_Mode (On);

with EinheitStadtRecords, GlobaleVariablen, EinheitStadtDatentypen, SonstigeDatentypen;
use SonstigeDatentypen;

package KampfwerteStadtErmitteln is

   function AktuelleVerteidigungStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer
          and
            StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze);
   
   function AktuellerAngriffStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.GesamtproduktionStadt
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SonstigeDatentypen.Leer
          and
            StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze);
   
private
   
   VerteidigungWert : EinheitStadtDatentypen.ProduktionFeld;
   AngriffWert : EinheitStadtDatentypen.ProduktionFeld;

end KampfwerteStadtErmitteln;
