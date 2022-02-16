pragma SPARK_Mode (On);

with Sf.Graphics.Color;

with KartenDatentypen;

package FarbgebungSFML is

   function FarbeKartenfeldErmitteln
     (GrundExtern : in KartenDatentypen.Karten_Grund_Vorhanden_Enum)
      return Sf.Graphics.Color.sfColor;
   
   function FarbeFlussErmitteln
     (FlussExtern : in KartenDatentypen.Karten_Fluss_Enum)
      return Sf.Graphics.Color.sfColor;

end FarbgebungSFML;
