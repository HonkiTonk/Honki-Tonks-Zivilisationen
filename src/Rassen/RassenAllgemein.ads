pragma SPARK_Mode (On);

with KartenDatentypen, GlobaleVariablen, SonstigeDatentypen;
use SonstigeDatentypen;

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
