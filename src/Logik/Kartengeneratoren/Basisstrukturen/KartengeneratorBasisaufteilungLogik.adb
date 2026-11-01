with KartenKonstanten;
with KartenDatentypen;

with KartengeneratorKernstrukturenLogik;
with KartengeneratorPolregionLogik;
with KartengeneratorBasisstrukturenLogik;
with KartengeneratorVariablenLogik;
with KartentestsLogik;

package body KartengeneratorBasisaufteilungLogik is
  
   procedure Kartenbasis
   is
      use type KartenDatentypen.SenkrechtePositiv;
   
      task Planetenkern;
      
      task body Planetenkern
      is begin
         
         case
           KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang
         is
            when KartenKonstanten.KernKonstante =>
               KartengeneratorKernstrukturenLogik.Planetenkern (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.KartengeneratorAllgemeines (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen)
                                                                * KartengeneratorVariablenLogik.KartengrößeLesen.Senkrechte));
            
            when others =>
               null;
         end case;
         
      end Planetenkern;
   
   begin
      
      KartengeneratorPolregionLogik.Polregion;
      
      case
        KartengeneratorVariablenLogik.KartenebenenLesen.EbeneEnde
      is
         when KartenKonstanten.UnterflächeKonstante =>
            KartengeneratorBasisstrukturenLogik.Basisstrukturen (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.KartengeneratorAllgemeines (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen)
                                                                 * KartengeneratorVariablenLogik.PolfreierBereichLesen.MaximaleSenkrechte),
                                                                 EbeneExtern         => KartenKonstanten.UnterflächeKonstante);
            
         when others =>
            KartengeneratorBasisstrukturenLogik.Basisstrukturen (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.KartengeneratorAllgemeines (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen)
                                                                 * KartengeneratorVariablenLogik.PolfreierBereichLesen.MaximaleSenkrechte),
                                                                 EbeneExtern         => KartenKonstanten.OberflächeKonstante);
      end case;
      
   end Kartenbasis;

end KartengeneratorBasisaufteilungLogik;
