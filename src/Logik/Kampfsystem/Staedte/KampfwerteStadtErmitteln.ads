pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with EinheitStadtDatentypen;

package KampfwerteStadtErmitteln is

   function AktuelleVerteidigungStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Kampfwerte
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer
          and
            StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze);
   
   function AktuellerAngriffStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Kampfwerte
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer
          and
            StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze);
   
private
   
   VerteidigungWert : EinheitStadtDatentypen.Kampfwerte;
   AngriffWert : EinheitStadtDatentypen.Kampfwerte;

end KampfwerteStadtErmitteln;
