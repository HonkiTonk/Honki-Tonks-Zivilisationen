with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with FensterGrafik;

package body TextaccessverwaltungssystemGrafik is
   
   procedure PositionSkalierenFarbeZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      SkalierenFarbe (TextaccessExtern => TextaccessExtern,
                      SkalierungExtern => SkalierungExtern,
                      FarbeExtern      => FarbeExtern);
      
      PositionZeichnen (TextaccessExtern => TextaccessExtern,
                        PositionExtern   => PositionExtern);
      
   end PositionSkalierenFarbeZeichnen;
   
   
   
   procedure PositionFarbeZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessExtern,
                                 color => FarbeExtern);
      
      PositionZeichnen (TextaccessExtern => TextaccessExtern,
                        PositionExtern   => PositionExtern);
      
   end PositionFarbeZeichnen;
   
   
   
   procedure PositionFarbe
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessExtern,
                                 color => FarbeExtern);
      
      Sf.Graphics.Text.setPosition (text     => TextaccessExtern,
                                    position => PositionExtern);
      
   end PositionFarbe;
   
     
   
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
      
      Zeichnen (TextaccessExtern => TextaccessExtern);
      
   end TextPositionZeichnen;
   
   
   
   procedure PositionZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Sf.Graphics.Text.setPosition (text     => TextaccessExtern,
                                    position => PositionExtern);
            
      Zeichnen (TextaccessExtern => TextaccessExtern);
      
   end PositionZeichnen;
   
   
   
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
            
      Sf.Graphics.Text.setScale (text  => TextaccessExtern,
                                 scale => SkalierungExtern);
      
      Zeichnen (TextaccessExtern => TextaccessExtern);
      
   end SkalierenZeichnen;
   
   
   
   procedure SkalierenFarbe
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessExtern,
                                 color => FarbeExtern);
      
      Skalieren (TextaccessExtern => TextaccessExtern,
                 SkalierungExtern => SkalierungExtern);
      
   end SkalierenFarbe;
   
   
   
   procedure Skalieren
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Sf.Graphics.Text.setScale (text  => TextaccessExtern,
                                 scale => SkalierungExtern);
      
   end Skalieren;
   
   
   
   procedure Farbe
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
      
      Sf.Graphics.Text.setColor (text  => TextaccessExtern,
                                 color => FarbeExtern);
      
   end Farbe;
   
   
   
   procedure Zeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr)
   is begin
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => FensterGrafik.FensterLesen,
                                         text         => TextaccessExtern);
      
   end Zeichnen;

end TextaccessverwaltungssystemGrafik;
