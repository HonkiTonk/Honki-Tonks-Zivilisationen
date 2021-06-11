pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

package KartenAllgemein is

   procedure Beschreibung
     (IDExtern : in GlobaleDatentypen.KartenGrund)
     with
       Pre =>
         (IDExtern > 0);

end KartenAllgemein;
