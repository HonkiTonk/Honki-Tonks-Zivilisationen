with KartenKonstanten;
with KartenDatentypen;

with KartengeneratorVariablenLogik;
with KartentestsLogik;
with KartengeneratorOberlandschaftLogik;
with KartengeneratorUnterlandschaftLogik;
with KartengeneratorKernlandschaftLogik;

package body KartengeneratorZusatzaufteilungLogik is

   procedure Kartenzusatz
   is
      use type KartenDatentypen.SenkrechtePositiv;
   
      task Planetenkern;
      task Unterfläche;
      
      task body Planetenkern
      is begin
         
         case
           KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang
         is
            when KartenKonstanten.KernKonstante =>
               KartengeneratorKernlandschaftLogik.Landschaft (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.PlanetenEbenen (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen)
                                                              * KartengeneratorVariablenLogik.KartengrößeLesen.Senkrechte));
            
            when others =>
               null;
         end case;
         
      end Planetenkern;
      
      
      
      task body Unterfläche
      is begin
         
         case
           KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang
         is
            when KartenDatentypen.EbeneUntergrund'Range =>
               KartengeneratorUnterlandschaftLogik.Landschaft (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.PlanetenEbenen (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen)
                                                              * KartengeneratorVariablenLogik.PolfreierBereichLesen.MaximaleSenkrechte));
            
            when others =>
               null;
         end case;
         
      end Unterfläche;
      
   begin
         
      case
        KartengeneratorVariablenLogik.KartenebenenLesen.EbeneEnde
      is
         when KartenDatentypen.EbeneOberfläche'Range =>
            KartengeneratorOberlandschaftLogik.Landschaft (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.PlanetenEbenen (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen)
                                                           * KartengeneratorVariablenLogik.PolfreierBereichLesen.MaximaleSenkrechte));
            
         when others =>
            null;
      end case;
      
   end Kartenzusatz;

end KartengeneratorZusatzaufteilungLogik;
