with KartenKonstanten;
with KartenartDatentypen;

with LeseWeltkarteneinstellungen;

with KartengeneratorPlanetenkernLogik;
with KartengeneratorPolregionLogik;
with KartengeneratorStandardLogik;
with KartengeneratorVariablenLogik;
with KartentestsLogik;

package body KartengeneratorAllgemeinesLogik is
   
   procedure GenerierungAllgemeines
   is begin
            
      PolbereicheBerechnen;
      GenerierungGrundlagen (SenkrechteExtern => KartengeneratorVariablenLogik.PolfreierBereichLesen.MaximaleSenkrechte);
      
   end GenerierungAllgemeines;
   
   
  
   procedure GenerierungGrundlagen
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural)
   is
      use type KartenDatentypen.EbeneVorhanden;
      use type KartenDatentypen.SenkrechtePositiv;
   
      task Planeteninneres;
      
      task body Planeteninneres
      is begin
         
         if
           KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang = -2
         then
            KartengeneratorPlanetenkernLogik.Planetenkern (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.KartengeneratorAllgemeines (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen)
                                                           * SenkrechteExtern));
            
         else
            null;
         end if;
         
      end Planeteninneres;
   
   begin
      
      KartengeneratorPolregionLogik.PolregionGenerieren;
      
      if
        KartengeneratorVariablenLogik.KartenebenenLesen.EbeneEnde >= 0
      then
         KartengeneratorStandardLogik.OberflächeGenerieren (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.KartengeneratorAllgemeines (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen)
                                                             * SenkrechteExtern));
            
      else
         null;
      end if;
      
   end GenerierungGrundlagen;
      
   
   
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

end KartengeneratorAllgemeinesLogik;
