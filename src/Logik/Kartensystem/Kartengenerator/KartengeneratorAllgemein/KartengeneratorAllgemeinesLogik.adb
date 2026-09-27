with KartengeneratorHimmelLogik;
with KartengeneratorOrbitLogik;
with KartengeneratorPlanetenkernLogik;
with KartengeneratorPolregionLogik;
with KartengeneratorStandardLogik;
with PolbereicheBerechnenLogik;
with KartengeneratorVariablenLogik;
with KartentestsLogik;

package body KartengeneratorAllgemeinesLogik is
   
   procedure GenerierungAllgemeines
   is begin
            
      PolbereicheBerechnenLogik.PolbereicheBerechnen;
      GenerierungGrundlagen (SenkrechteExtern => KartengeneratorVariablenLogik.PolfreierBereichLesen.MaximaleSenkrechte);
      
   end GenerierungAllgemeines;
   
   
  
   procedure GenerierungGrundlagen
     (SenkrechteExtern : in KartenDatentypen.SenkrechteNatural)
   is
      use type KartenDatentypen.EbeneVorhanden;
      use type KartenDatentypen.SenkrechtePositiv;
   
      task Orbit;
      task Himmel;
      task Planeteninneres;
      
      task body Orbit
      is begin

         if
           KartengeneratorVariablenLogik.KartenebenenLesen.EbeneEnde = 2
         then
            KartengeneratorOrbitLogik.Orbit (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.VorhandeneEbenen (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen)
                                             * SenkrechteExtern));
            
         else
            null;
         end if;
         
      end Orbit;
      
      
      
      task body Himmel
      is begin
         
         if
           KartengeneratorVariablenLogik.KartenebenenLesen.EbeneEnde >= 1
         then
            KartengeneratorHimmelLogik.Himmel (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.VorhandeneEbenen (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen)
                                               * SenkrechteExtern));
            
         else
            null;
         end if;
         
      end Himmel;
      
      
      
      task body Planeteninneres
      is begin
         
         -- Sollte ich in dieser Prozedur später weitere Berechnungen durchführen die Zugriff auf die Kartenkoordinatenberechnung vornehmen, äöü
         -- dann muss ich das hier wegverschieben da der Zugriff ebenfalls in KartengeneratorStandardLogik.OberflächeGenerieren erfolgt. äöü
         if
           KartengeneratorVariablenLogik.KartenebenenLesen.EbeneAnfang = -2
         then
            KartengeneratorPlanetenkernLogik.Planetenkern (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.VorhandeneEbenen (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen)
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
         KartengeneratorStandardLogik.OberflächeGenerieren (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.VorhandeneEbenen (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen)
                                                             * SenkrechteExtern));
            
      else
         null;
      end if;
      
   end GenerierungGrundlagen;

end KartengeneratorAllgemeinesLogik;
