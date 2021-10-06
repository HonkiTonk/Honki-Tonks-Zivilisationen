pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with KartenDatentypen;
with GlobaleVariablen;

package RassenAllgemein is
   
   function RassenBelegungAnfang
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BelegterGrund
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
   
   function RassenBelegungEnde
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BelegterGrund
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);

end RassenAllgemein;
