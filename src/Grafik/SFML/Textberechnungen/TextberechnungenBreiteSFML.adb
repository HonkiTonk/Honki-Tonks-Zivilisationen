pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;

with GrafikEinstellungenSFML;
with Warnung;

package body TextberechnungenBreiteSFML is

   function MittelpositionBerechnen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      ViewbreiteExtern : in Float)
      return Float
   is begin
      
      Position := ViewbreiteExtern / 2.00 - HalbeBreiteBerechnen (TextAccessExtern => TextAccessExtern);
      
      if
        Position in 0.00 .. Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x)
      then
         null;
         
      else
         -- Später in ein Fehler.GrafikStopp umbauen? äöü
         Warnung.GrafikWarnung (WarnmeldungExtern => "TextberechnungenBreiteSFML.MittelpositionBerechnen - Textposition außerhalb des Fensters.");
      end if;
      
      return Position;
      
   end MittelpositionBerechnen;
   
   
   
   function ViertelpositionBerechnen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      LinksRechtsExtern : in Boolean)
      return Float
   is begin
      
      Position := Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) / 4.00;
      
      case
        LinksRechtsExtern
      is
         when True =>
            Position := Position - HalbeBreiteBerechnen (TextAccessExtern => TextAccessExtern);
            
         when False =>
            Position := Position * 3.00 - HalbeBreiteBerechnen (TextAccessExtern => TextAccessExtern);
      end case;
      
      if
        Position in 0.00 .. Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x)
      then
         null;
         
      else
         -- Später in ein Fehler.GrafikStopp umbauen? äöü
         Warnung.GrafikWarnung (WarnmeldungExtern => "TextberechnungenBreiteSFML.ViertelpositionBerechnen - Textposition außerhalb des Fensters.");
      end if;
      
      return Position;
      
   end ViertelpositionBerechnen;
   
   
   
   function HalbeBreiteBerechnen
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
      
      return Sf.Graphics.Text.getLocalBounds (text => TextAccessExtern).width / 2.00;
      
   end HalbeBreiteBerechnen;
   
   
   
   function NeueTextbreiteErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      TextbreiteExtern : in Float)
      return Float
   is begin
      
      NeueTextbreite := Sf.Graphics.Text.getLocalBounds (text => TextAccessExtern).width;
      
      if
        NeueTextbreite > TextbreiteExtern
      then
         return NeueTextbreite;
           
      else
         return TextbreiteExtern;
      end if;
      
   end NeueTextbreiteErmitteln;
   
end TextberechnungenBreiteSFML;
