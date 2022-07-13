pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;

with GrafikEinstellungenSFML;

package body AllgemeineTextBerechnungenSFML is

   function TextMittelPositionErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
      
      TextHalbeBreite := TextHalbeBreiteErmitteln (TextAccessExtern => TextAccessExtern);
      Position := Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 2.00 - TextHalbeBreite;
      
      if
        Position in 0.00 .. Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x)
      then
         return Position;
         
      else
         -- Hier später ein Fehler.GrafikStopp einbauen? äöü
         return Position;
      end if;
      
   end TextMittelPositionErmitteln;
   
   
   
   function TextViertelPositionErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      LinksRechtsExtern : in Boolean)
      return Float
   is begin
      
      Position := Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 4.00;
      TextHalbeBreite := TextHalbeBreiteErmitteln (TextAccessExtern => TextAccessExtern);
      
      case
        LinksRechtsExtern
      is
         when True =>
            Position := Position - TextHalbeBreite;
            
         when False =>
            Position := Position * 3.00 - TextHalbeBreite;
      end case;
      
      if
        Position in 0.00 .. Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x)
      then
         return Position;
         
      else
         -- Hier später ein Fehler.GrafikStopp einbauen? äöü
         return Position;
      end if;
      
   end TextViertelPositionErmitteln;
   
   
   
   function TextHalbeBreiteErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
      
      return Sf.Graphics.Text.getLocalBounds (text => TextAccessExtern).width / 2.00;
      
   end TextHalbeBreiteErmitteln;
   
   
   
   -- In was Anderes auslagern. äöü
   function HalbeBildschirmhöhe
     return Float
   is begin
      
      return Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y) / 2.00;
      
   end HalbeBildschirmhöhe;
   
   
   
   function AbstandZeilen
     return Float
   is begin
      
      return 0.20 * Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
   end AbstandZeilen;
   
   
   
   function AbstandZeilenGroß
     return Float
   is begin
      
      return 0.50 * Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeStandard);
      
   end AbstandZeilenGroß;
   
   
   
   function AbstandÜberschrift
     return Float
   is begin
      
      return 3.00 * Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
   end AbstandÜberschrift;
   
   
   
   function AbstandÜberschriftGroß
     return Float
   is begin
      
      return 5.00 * Float (GrafikEinstellungenSFML.Schriftgrößen.SchriftgrößeÜberschrift);
      
   end AbstandÜberschriftGroß;

end AllgemeineTextBerechnungenSFML;
