pragma SPARK_Mode (On);

with GlobaleDatentypen, SonstigeDatentypen;
use GlobaleDatentypen;

package KartenfelderBewerten is

   procedure KartenfelderBewerten
     (RasseExtern : in SonstigeDatentypen.Rassen_Enum);

end KartenfelderBewerten;
