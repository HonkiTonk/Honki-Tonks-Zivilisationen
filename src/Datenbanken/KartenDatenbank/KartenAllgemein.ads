pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

package KartenAllgemein is

   procedure Beschreibung
     (KartenGrundExtern : in GlobaleDatentypen.Karten_Grund_Enum)
     with
       Pre =>
         (KartenGrundExtern /= GlobaleDatentypen.Leer);

end KartenAllgemein;
