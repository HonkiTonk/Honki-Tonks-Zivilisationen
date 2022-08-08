pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikEinstellungenSFML;

package body TextberechnungenHoeheSFML is
   
   function HalbeBildschirmhöhe
     return Float
   is begin
      
      return Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y) / 2.00;
      
   end HalbeBildschirmhöhe;
   
   
   
   function KleinerZeilenabstand
     return Float
   is begin
      
      return 28.80; -- 1.20 * Float (TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
   end KleinerZeilenabstand;
   
   
   
   function Zeilenabstand
     return Float
   is begin
      
      return 36.00; -- 1.50 * Float (TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
   end Zeilenabstand;
   
   
   
   function GroßerZeilenabstand
     return Float
   is begin
      
      return 52.80; -- 2.20 * Float (TexteinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
   end GroßerZeilenabstand;
   
   
   
   function Überschriftabstand
     return Float
   is begin
      
      return 90.00; -- 2.50 * Float (TexteinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
   end Überschriftabstand;
   
   
   
   function ÜberschriftabstandGroß
     return Float
   is begin
      
      return 180.00; -- 5.00 * Float (TexteinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
   end ÜberschriftabstandGroß;
   
end TextberechnungenHoeheSFML;
