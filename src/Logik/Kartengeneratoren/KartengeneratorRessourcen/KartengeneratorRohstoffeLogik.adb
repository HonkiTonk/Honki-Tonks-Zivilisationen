with KartenDatentypen;

with KartengeneratorVariablenLogik;
with KartengeneratorOberrohstoffeLogik;
with KartengeneratorUnterrohstoffeLogik;
with KartengeneratorKernrohstoffeLogik;
with LadezeitenAllgemeinesLogik;

package body KartengeneratorRohstoffeLogik is
   
   procedure Rohstoffgenerierung
   is
      use type KartenDatentypen.EbeneVorhanden;
      
      task RohstoffeUnterfläche;
      task RohstoffeKern;
      
      task body RohstoffeUnterfläche
      is begin
         
         if
           KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang <= -1
         then
            KartengeneratorUnterrohstoffeLogik.Rohstoffe (LadezeitbasisExtern => LadezeitenAllgemeinesLogik.ZeiteinheitPlanetBerechnen);
                                  
            
         else
            null;
         end if;
         
      end RohstoffeUnterfläche;
      
      
      
      task body RohstoffeKern
      is begin
         
         if
           KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang = -2
         then
           KartengeneratorKernrohstoffeLogik.Rohstoffe (LadezeitbasisExtern => LadezeitenAllgemeinesLogik.ZeiteinheitPlanetBerechnen);
            
         else
            null;
         end if;
         
      end RohstoffeKern;
   
   begin

      if
        KartengeneratorVariablenLogik.KartenebenenLesen.EbeneEnde >= 0
      then
         KartengeneratorOberrohstoffeLogik.Rohstoffe (LadezeitbasisExtern => LadezeitenAllgemeinesLogik.ZeiteinheitPlanetBerechnen);
         
      else
         null;
      end if;
      
   end Rohstoffgenerierung;

end KartengeneratorRohstoffeLogik;
