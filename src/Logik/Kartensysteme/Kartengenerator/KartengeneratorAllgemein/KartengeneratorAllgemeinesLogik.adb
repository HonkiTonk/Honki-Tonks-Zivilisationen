with KartengeneratorHimmelLogik;
with KartengeneratorWeltraumLogik;
with KartengeneratorPlanetenkernLogik;
with KartengeneratorPolregionLogik;
with KartengeneratorStandardLogik;
with PolbereicheBerechnenLogik;
with KartengeneratorVariablenLogik;

package body KartengeneratorAllgemeinesLogik is
   
   procedure GenerierungAllgemeines
   is begin
            
      PolbereicheBerechnenLogik.PolbereicheBerechnen;
      GenerierungGrundlagen;
      
   end GenerierungAllgemeines;
   
   
  
   procedure GenerierungGrundlagen
   is
   
      task Himmel;
      task Weltraum;
      task Planeteninneres;
      
      task body Himmel
      is begin
         
         KartengeneratorHimmelLogik.Himmel (LadezeitbasisExtern => 100.00 / (4.00 * Float (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte)));
         
      end Himmel;
      
      
      
      task body Weltraum
      is begin

         KartengeneratorWeltraumLogik.Weltraum (LadezeitbasisExtern => 100.00 / (4.00 * Float (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte)));
         
      end Weltraum;
      
      
      
      task body Planeteninneres
      is begin
         
         -- Sollte ich in dieser Prozedur später weitere Berechnungen durchführen die Zugriff auf die Kartenkoordinatenberechnung vornehmen, äöü
         -- dann muss ich das hier wegverschieben da der Zugriff ebenfalls in KartengeneratorStandardLogik.OberflächeGenerieren erfolgt. äöü
         KartengeneratorPlanetenkernLogik.Planetenkern (LadezeitbasisExtern => 100.00 / (4.00 * Float (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte)));
         
      end Planeteninneres;
   
   begin
      
      KartengeneratorPolregionLogik.PolregionGenerieren;
      KartengeneratorStandardLogik.OberflächeGenerieren (LadezeitbasisExtern => 100.00 / (4.00 * Float (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte)));
      
   end GenerierungGrundlagen;

end KartengeneratorAllgemeinesLogik;
