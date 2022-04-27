pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body FarbgebungSFML is

   function FarbeKartenfeldErmitteln
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum)
      return Sf.Graphics.Color.sfColor
   is begin
      
      return Feldfarbe (GrundExtern);
      
   end FarbeKartenfeldErmitteln;
   
   
   
   function FarbeFlussErmitteln
     (FlussExtern : in KartengrundDatentypen.Karten_Fluss_Enum)
      return Sf.Graphics.Color.sfColor
   is begin
      
      return Flussfarbe (FlussExtern);
            
   end FarbeFlussErmitteln;
   
   
   
   -- -------------------
   -- function FarbeVerbesserungErmitteln ???
   -- function FarbeEinheitErmitteln ???

end FarbgebungSFML;
