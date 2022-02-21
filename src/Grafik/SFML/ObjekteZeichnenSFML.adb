pragma SPARK_Mode (On);

with Sf.Graphics.RectangleShape;
with Sf.Graphics.RenderWindow;
with Sf.Graphics.CircleShape;

with GrafikEinstellungenSFML;

package body ObjekteZeichnenSFML is

   procedure RechteckZeichnen
     (AbmessungExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor;
      RechteckAccessExtern : in Sf.Graphics.sfRectangleShape_Ptr)
   is begin
      
      Sf.Graphics.RectangleShape.setSize (shape => RechteckAccessExtern,
                                          size  => AbmessungExtern);
      Sf.Graphics.RectangleShape.setPosition (shape    => RechteckAccessExtern,
                                              position => PositionExtern);
      Sf.Graphics.RectangleShape.setFillColor (shape => RechteckAccessExtern,
                                               color => FarbeExtern);
         
      Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                   object       => RechteckAccessExtern);
      
   end RechteckZeichnen;
   
   
   
   procedure KreisZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor;
      KreisAccessExtern : in Sf.Graphics.sfCircleShape_Ptr)
   is begin
            
      Sf.Graphics.CircleShape.setRadius (shape  => KreisAccessExtern,
                                         radius => RadiusExtern);
      Sf.Graphics.CircleShape.setPosition (shape    => KreisAccessExtern,
                                           position => PositionExtern);
      Sf.Graphics.CircleShape.setFillColor (shape => KreisAccessExtern,
                                            color => FarbeExtern);
         
      Sf.Graphics.RenderWindow.drawCircleShape (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                object       => KreisAccessExtern);
      
   end KreisZeichnen;
   
   
   
   procedure PolygonZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      AnzahlEckenExtern : in Sf.sfSize_t;
      FarbeExtern : in Sf.Graphics.Color.sfColor;
      PolygonAccessExtern : in Sf.Graphics.sfCircleShape_Ptr)
   is begin
            
      Sf.Graphics.CircleShape.setRadius (shape  => PolygonAccessExtern,
                                         radius => RadiusExtern);
      Sf.Graphics.CircleShape.setPointCount (shape => PolygonAccessExtern,
                                             count => AnzahlEckenExtern);
      Sf.Graphics.CircleShape.setPosition (shape    => PolygonAccessExtern,
                                           position => PositionExtern);
      Sf.Graphics.CircleShape.setFillColor (shape => PolygonAccessExtern,
                                            color => FarbeExtern);
         
      Sf.Graphics.RenderWindow.drawCircleShape (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                object       => PolygonAccessExtern);
      
   end PolygonZeichnen;

end ObjekteZeichnenSFML;
