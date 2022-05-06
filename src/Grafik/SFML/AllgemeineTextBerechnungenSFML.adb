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
         -- Hier später ein Fehler.GrafikStopp einbauen?
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
         -- Hier später ein Fehler.GrafikStopp einbauen?
         return Position;
      end if;
      
   end TextViertelPositionErmitteln;
   
   
   
   function TextHalbeBreiteErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
      
      return Sf.Graphics.Text.getLocalBounds (text => TextAccessExtern).width / 2.00;
      
   end TextHalbeBreiteErmitteln;

end AllgemeineTextBerechnungenSFML;
