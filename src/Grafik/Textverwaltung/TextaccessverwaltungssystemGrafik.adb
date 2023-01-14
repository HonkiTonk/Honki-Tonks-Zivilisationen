with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with EinstellungenGrafik;

package body TextaccessverwaltungssystemGrafik is
   
   procedure TextFarbe
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessExtern,
                                 color => FarbeExtern);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessExtern,
                                         str  => TextExtern);
      
   end TextFarbe;
     
     
   
   procedure TextPositionFarbeZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      TextFarbe (TextaccessExtern => TextaccessExtern,
                 TextExtern       => TextExtern,
                 FarbeExtern      => FarbeExtern);
      
      PositionZeichnen (TextaccessExtern => TextaccessExtern,
                        PositionExtern   => PositionExtern);
      
   end TextPositionFarbeZeichnen;
   
   
   
   procedure TextPosition
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessExtern,
                                         str  => TextExtern);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessExtern,
                                    position => PositionExtern);
      
   end TextPosition;
   
   
   
   procedure TextPositionZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      TextPosition (TextaccessExtern => TextaccessExtern,
                    TextExtern       => TextExtern,
                    PositionExtern   => PositionExtern);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessExtern);
      
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
   
   
   
   procedure TextStandardskalierung
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String)
   is begin
      
      Sf.Graphics.Text.setScale (text  => TextaccessExtern,
                                 scale => (1.00, 1.00));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessExtern,
                                         str  => TextExtern);
      
   end TextStandardskalierung;
   
   
   
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
   
   
   
   procedure TextPositionSkalierenZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      TextPosition (TextaccessExtern => TextaccessExtern,
                    TextExtern       => TextExtern,
                    PositionExtern   => PositionExtern);
      
      SkalierenZeichnen (TextaccessExtern => TextaccessExtern,
                         SkalierungExtern => SkalierungExtern);
      
   end TextPositionSkalierenZeichnen;
   
   
   
   procedure PositionSkalierenZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Sf.Graphics.Text.setPosition (text     => TextaccessExtern,
                                    position => PositionExtern);
      
      SkalierenZeichnen (TextaccessExtern => TextaccessExtern,
                         SkalierungExtern => SkalierungExtern);
      
   end PositionSkalierenZeichnen;
   
   
   
   procedure SkalierenZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
   is begin
            
      Sf.Graphics.Text.scale (text    => TextaccessExtern,
                              factors => SkalierungExtern);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessExtern);
      
   end SkalierenZeichnen;

end TextaccessverwaltungssystemGrafik;
