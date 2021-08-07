pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

package KartenfelderBewerten is

   procedure KartenfelderBewerten
     (RasseExtern : in GlobaleDatentypen.Rassen_Enum);

end KartenfelderBewerten;
