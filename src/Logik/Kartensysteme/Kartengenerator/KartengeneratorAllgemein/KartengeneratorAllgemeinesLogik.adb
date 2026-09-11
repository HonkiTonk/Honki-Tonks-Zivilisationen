with KartenDatentypen;

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
      GenerierungGrundlagen;
      
   end GenerierungAllgemeines;
   
   
  
   procedure GenerierungGrundlagen
   is
      use type KartenDatentypen.EbeneVorhanden;
      use type KartenDatentypen.SenkrechtePositiv;
   
      task Orbit;
      task Himmel;
      task Planeteninneres;
      
      task body Orbit
      is begin

         if
           KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneEnde = 2
         then
            KartengeneratorOrbitLogik.Orbit (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.VorhandeneEbenen (EbenenExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene)
                                             * KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte));
            
         else
            null;
         end if;
         
      end Orbit;
      
      
      
      task body Himmel
      is begin
         
         if
           KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneEnde >= 1
         then
            KartengeneratorHimmelLogik.Himmel (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.VorhandeneEbenen (EbenenExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene)
                                               * KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte));
            
         else
            null;
         end if;
         
      end Himmel;
      
      
      
      task body Planeteninneres
      is begin
         
         -- Sollte ich in dieser Prozedur später weitere Berechnungen durchführen die Zugriff auf die Kartenkoordinatenberechnung vornehmen, äöü
         -- dann muss ich das hier wegverschieben da der Zugriff ebenfalls in KartengeneratorStandardLogik.OberflächeGenerieren erfolgt. äöü
         if
           KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneAnfang = -2
         then
            KartengeneratorPlanetenkernLogik.Planetenkern (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.VorhandeneEbenen (EbenenExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene)
                                                           * KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte));
            
         else
            null;
         end if;
         
      end Planeteninneres;
   
   begin
      
      KartengeneratorPolregionLogik.PolregionGenerieren;
      
      if
        KartengeneratorVariablenLogik.Kartenparameter.Kartenebene.EbeneEnde >= 0
      then
         KartengeneratorStandardLogik.OberflächeGenerieren (LadezeitbasisExtern => 100.00 / Float (KartentestsLogik.VorhandeneEbenen (EbenenExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene)
                                                             * KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte));
            
      else
         null;
      end if;
      
   end GenerierungGrundlagen;

end KartengeneratorAllgemeinesLogik;
