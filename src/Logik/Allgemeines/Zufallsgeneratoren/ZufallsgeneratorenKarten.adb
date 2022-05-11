pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

package body ZufallsgeneratorenKarten is
   
   function KartengeneratorZufallswerte
     return KartenDatentypen.WahrscheinlichkeitKartengenerator
   is begin
      
      ZufälligeZahl.Reset (zufälligeZahlGewählt);
      return ZufälligeZahl.Random (zufälligeZahlGewählt);
      
   end KartengeneratorZufallswerte;

end ZufallsgeneratorenKarten;
