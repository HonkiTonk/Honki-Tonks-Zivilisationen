pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;

package SpielerVorhanden is
   
   function BeliebigeSpielerart
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
   return Boolean;

   function MenschlicheSpieler
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
      return Boolean;
   
   function KISpieler
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
      return Boolean;

end SpielerVorhanden;
