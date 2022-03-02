pragma SPARK_Mode (On);

package body FarbgebungSFML is

   function FarbeKartenfeldErmitteln
     (GrundExtern : in KartenDatentypen.Karten_Grund_Alle_Felder_Enum)
      return Sf.Graphics.Color.sfColor
   is begin
      
      return Feldfarbe (GrundExtern);
      
   end FarbeKartenfeldErmitteln;
   
   
   
   function FarbeFlussErmitteln
     (FlussExtern : in KartenDatentypen.Karten_Fluss_Enum)
      return Sf.Graphics.Color.sfColor
   is begin
      
      return Flussfarbe (FlussExtern);
            
   end FarbeFlussErmitteln;
   
   
   
   -- -------------------
   -- function FarbeVerbesserungErmitteln ???
   -- function FarbeEinheitErmitteln ???

end FarbgebungSFML;
