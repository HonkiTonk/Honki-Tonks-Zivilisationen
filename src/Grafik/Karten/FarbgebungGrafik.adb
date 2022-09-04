pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body FarbgebungGrafik is

   function FarbeKartenfeldErmitteln
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
      return Sf.Graphics.Color.sfColor
   is begin
      
      return Feldfarbe (GrundExtern);
      
   end FarbeKartenfeldErmitteln;
   
   
   
   function FarbeFlussErmitteln
     (FlussExtern : in KartengrundDatentypen.Kartenfluss_Enum)
      return Sf.Graphics.Color.sfColor
   is begin
      
      return Flussfarbe (FlussExtern);
            
   end FarbeFlussErmitteln;

end FarbgebungGrafik;