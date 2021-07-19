pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

package VerbesserungenAllgemein is

   procedure Beschreibung
     (KartenVerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum)
     with
       Pre =>
         (KartenVerbesserungExtern /= GlobaleDatentypen.Leer);

end VerbesserungenAllgemein;
