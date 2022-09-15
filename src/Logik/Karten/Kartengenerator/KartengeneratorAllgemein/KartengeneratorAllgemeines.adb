pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengeneratorHimmel;
with KartengeneratorWeltraum;
with KartengeneratorPlaneteninneres;
with KartengeneratorPolregion;
with KartengeneratorStandard;
with PolbereicheBerechnen;

package body KartengeneratorAllgemeines is
   
   procedure GenerierungAllgemeines
   is begin
            
      PolbereicheBerechnen.PolbereicheBerechnen;
      GenerierungGrundlagen;
      
   end GenerierungAllgemeines;
   
   
  
   -- Wenn ich die ganzen Arbeiten zusammenführe könnte ich wahrscheinlich noch mehr parallelisieren. äöü
   -- Beispielsweise nach der Generierung des Planeteninneres direkt dafür die Flüsse generieren und nicht warten das der Hauptteil fertig wird. äöü
   procedure GenerierungGrundlagen
   is
   
      task Himmel;
      task Weltraum;
      task Planeteninneres;
      
      task body Himmel
      is begin
         
         KartengeneratorHimmel.Himmel;
         
      end Himmel;
      
      
      
      task body Weltraum
      is begin

         KartengeneratorWeltraum.Weltraum;
         
      end Weltraum;
      
      
      
      task body Planeteninneres
      is begin
         
         KartengeneratorPlaneteninneres.Planeteninneres;
         
      end Planeteninneres;
   
   begin
      
      KartengeneratorPolregion.PolregionGenerieren;
      KartengeneratorStandard.OberflächeGenerieren;
      
   end GenerierungGrundlagen;

end KartengeneratorAllgemeines;
