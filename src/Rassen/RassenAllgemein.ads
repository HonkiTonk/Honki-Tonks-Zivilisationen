pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package RassenAllgemein is
   
   function RassenBelegungAnfang
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BelegterGrund
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   function RassenBelegungEnde
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BelegterGrund
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);

end RassenAllgemein;
