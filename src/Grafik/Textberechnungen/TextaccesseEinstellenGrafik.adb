with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with EinstellungenGrafik;

package body TextaccesseEinstellenGrafik is
   
   procedure TextPositionFarbeZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessExtern,
                                 color => FarbeExtern);
      
      TextPositionZeichnen (TextaccessExtern => TextaccessExtern,
                            TextExtern       => TextExtern,
                            PositionExtern   => PositionExtern);
      
   end TextPositionFarbeZeichnen;
   
   
   
   procedure TextPositionZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessExtern,
                                         str  => TextExtern);
      
      PositionZeichnen (TextaccessExtern => TextaccessExtern,
                        PositionExtern   => PositionExtern);
      
   end TextPositionZeichnen;
   
   
   
   procedure PositionZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Sf.Graphics.Text.setPosition (text     => TextaccessExtern,
                                    position => PositionExtern);
            
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessExtern);
      
   end PositionZeichnen;
   
   
   
   procedure TextPositionStandardskalierungZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
            
      TextPositionStandardskalierung (TextaccessExtern => TextaccessExtern,
                                      TextExtern       => TextExtern,
                                      PositionExtern   => PositionExtern);
            
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessExtern);
      
   end TextPositionStandardskalierungZeichnen;
   
   
   
   procedure TextPositionStandardskalierung
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Sf.Graphics.Text.setScale (text  => TextaccessExtern,
                                 scale => (1.00, 1.00));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessExtern,
                                         str  => TextExtern);
      Sf.Graphics.Text.setPosition (text     => TextaccessExtern,
                                    position => PositionExtern);
      
   end TextPositionStandardskalierung;
   
   
   
   procedure SkalierenZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Sf.Graphics.Text.scale (text    => TextaccessExtern,
                              factors => SkalierungExtern);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessExtern);
      
   end SkalierenZeichnen;

end TextaccesseEinstellenGrafik;
