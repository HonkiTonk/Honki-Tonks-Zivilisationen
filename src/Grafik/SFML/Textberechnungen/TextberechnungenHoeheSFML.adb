pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikEinstellungenSFML;

package body TextberechnungenHoeheSFML is
   
   function HalbeBildschirmhöhe
     return Float
   is begin
      
      return Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y) / 2.00;
      
   end HalbeBildschirmhöhe;
   
   
   
   -- Feste Werte einbauen, dann kommt es nicht zu Problemen bei großen Texteinstellungen. äöü
   function KleinerZeilenabstand
     return Float
   is begin
      
      return 1.20 * Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
   end KleinerZeilenabstand;
   
   
   
   function Zeilenabstand
     return Float
   is begin
      
      return 1.50 * Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
   end Zeilenabstand;
   
   
   
   function GroßerZeilenabstand
     return Float
   is begin
      
      return 2.20 * Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
   end GroßerZeilenabstand;
   
   
   
   function Überschriftabstand
     return Float
   is begin
      
      return 2.50 * Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
   end Überschriftabstand;
   
   
   
   function ÜberschriftabstandGroß
     return Float
   is begin
      
      return 5.00 * Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
   end ÜberschriftabstandGroß;
   
end TextberechnungenHoeheSFML;
