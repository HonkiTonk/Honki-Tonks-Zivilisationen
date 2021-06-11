pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

package VerbesserungenAllgemein is

   procedure Beschreibung
     (IDExtern : in GlobaleDatentypen.KartenVerbesserung)
     with
       Pre =>
         (IDExtern > 0);

end VerbesserungenAllgemein;
