pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;

with TexteinstellungenGrafik;

package body TextfarbeGrafik is

   procedure AuswahlfarbeFestlegen
     (TextnummerExtern : in Natural;
      AuswahlExtern : in Integer;
      TextaccessExtern : in Sf.Graphics.sfText_Ptr)
   is begin
      
      if
        AuswahlExtern = TextnummerExtern
      then
         Farbe := TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText;
            
      else
         Farbe := TexteinstellungenGrafik.Schriftfarben.FarbeStandardText;
      end if;
      
      Sf.Graphics.Text.setColor (text  => TextaccessExtern,
                                 color => Farbe);
      
   end AuswahlfarbeFestlegen;
   
   
   
   procedure Standardfarbe
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr)
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessExtern,
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
      
   end Standardfarbe;

end TextfarbeGrafik;
