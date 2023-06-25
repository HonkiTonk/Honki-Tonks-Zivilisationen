with KartengeneratorHimmelLogik;
with KartengeneratorWeltraumLogik;
with KartengeneratorPlanetenkernLogik;
with KartengeneratorPolregionLogik;
with KartengeneratorStandardLogik;
with PolbereicheBerechnenLogik;

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
         
         KartengeneratorHimmelLogik.Himmel;
         
      end Himmel;
      
      
      
      task body Weltraum
      is begin

         KartengeneratorWeltraumLogik.Weltraum;
         
      end Weltraum;
      
      
      
      task body Planeteninneres
      is begin
         
         -- Sollte ich in dieser Prozedur später weitere Berechnungen durchführen die Zugriff auf die Kartenkoordinatenberechnung vornehmen, äöü
         -- dann muss ich das hier wegverschieben da der Zugriff ebenfall in KartengeneratorStandardLogik.OberflächeGenerieren erfolgt. äöü
         KartengeneratorPlanetenkernLogik.Planetenkern;
         
      end Planeteninneres;
   
   begin
      
      KartengeneratorPolregionLogik.PolregionGenerieren;
      KartengeneratorStandardLogik.OberflächeGenerieren;
      
   end GenerierungGrundlagen;

end KartengeneratorAllgemeinesLogik;
