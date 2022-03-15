pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package KartenfelderBewerten is

   procedure KartenfelderBewerten
     (RasseExtern : in SystemDatentypen.Rassen_Enum);

end KartenfelderBewerten;
