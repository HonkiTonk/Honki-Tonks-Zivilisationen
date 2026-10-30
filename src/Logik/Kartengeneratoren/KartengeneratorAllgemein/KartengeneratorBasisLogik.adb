with KartenKonstanten;
with KartenartDatentypen;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

with KartengeneratorPlanetenkernLogik;
with KartengeneratorPolregionLogik;
with KartengeneratorStandardLogik;
with KartengeneratorVariablenLogik;
with KartentestsLogik;

package body KartengeneratorBasisLogik is
  
   procedure Kartenbasis
   is
      use type KartenDatentypen.EbeneVorhanden;
      use type KartenDatentypen.SenkrechtePositiv;
   
      task Planeteninneres;
      
      task body Planeteninneres
      is begin
         
         if
           KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang = KartenKonstanten.KernKonstante
         then
            KartengeneratorPlanetenkernLogik.Planetenkern (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.KartengeneratorAllgemeines (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen)
                                                           * KartengeneratorVariablenLogik.KartengrößeLesen.Senkrechte));
            
         else
            null;
         end if;
         
      end Planeteninneres;
   
   begin
      
      PolbereicheBerechnen;
      KartengeneratorPolregionLogik.PolregionGenerieren;
      
      if
        KartengeneratorVariablenLogik.KartenebenenLesen.EbeneEnde >= KartenKonstanten.OberflächeKonstante
      then
         KartengeneratorStandardLogik.OberflächeGenerieren (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.KartengeneratorAllgemeines (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen)
                                                             * KartengeneratorVariablenLogik.PolfreierBereichLesen.MaximaleSenkrechte));
         
      elsif
        KartengeneratorVariablenLogik.KartenebenenLesen.EbeneEnde = KartenKonstanten.UnterflächeKonstante
      then
         null;
            
      else
         null;
      end if;
      
   end Kartenbasis;
      
   
   
   procedure PolbereicheBerechnen
   is
      use type KartenDatentypen.SenkrechteBasis;
      use type KartenDatentypen.WaagerechteBasis;
   begin
      
      Schleifenbereiche.MinimaleSenkrechte := KartenKonstanten.AnfangSenkrechte + KartengeneratorVariablenLogik.SenkrechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Norden_Enum);
      
      Schleifenbereiche.MaximaleSenkrechte := LeseWeltkarteneinstellungen.Senkrechte - KartengeneratorVariablenLogik.SenkrechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Süden_Enum);
      
      
      
      Schleifenbereiche.MinimaleWaagerechte := KartenKonstanten.AnfangWaagerechte + KartengeneratorVariablenLogik.WaagerechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Westen_Enum);
      
      
      Schleifenbereiche.MaximaleWaagerechte := LeseWeltkarteneinstellungen.Waagerechte - KartengeneratorVariablenLogik.WaagerechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Osten_Enum);
      
      KartengeneratorVariablenLogik.PolfreierBereichSchreiben (BereichExtern => Schleifenbereiche);
      

   end PolbereicheBerechnen;

end KartengeneratorBasisLogik;
