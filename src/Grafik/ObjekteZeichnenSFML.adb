pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;

with GrafikEinstellungenSFML;

package body ObjekteZeichnenSFML is

   procedure RechteckZeichnen
     (AbmessungExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
            
      Sf.Graphics.RectangleShape.setSize (shape => RechteckAccess,
                                          size  => AbmessungExtern);
      Sf.Graphics.RectangleShape.setPosition (shape    => RechteckAccess,
                                              position => PositionExtern);
      Sf.Graphics.RectangleShape.setFillColor (shape => RechteckAccess,
                                               color => FarbeExtern);
         
      Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                   object       => RechteckAccess);
      
   end RechteckZeichnen;
   
   
   
   procedure KreisZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
            
      Sf.Graphics.CircleShape.setRadius (shape  => KreisAccess,
                                         radius => RadiusExtern);
      Sf.Graphics.CircleShape.setPosition (shape    => KreisAccess,
                                           position => PositionExtern);
      Sf.Graphics.CircleShape.setFillColor (shape => KreisAccess,
                                            color => FarbeExtern);
         
      Sf.Graphics.RenderWindow.drawCircleShape (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                object       => KreisAccess);
      
   end KreisZeichnen;
   
   
   
   procedure PolygonZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      AnzahlEckenExtern : in Sf.sfSize_t;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
   is begin
            
      Sf.Graphics.CircleShape.setRadius (shape  => PolygonAccess,
                                         radius => RadiusExtern);
      Sf.Graphics.CircleShape.setPointCount (shape => PolygonAccess,
                                             count => AnzahlEckenExtern);
      Sf.Graphics.CircleShape.setPosition (shape    => PolygonAccess,
                                           position => PositionExtern);
      Sf.Graphics.CircleShape.setFillColor (shape => PolygonAccess,
                                            color => FarbeExtern);
         
      Sf.Graphics.RenderWindow.drawCircleShape (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                object       => PolygonAccess);
      
   end PolygonZeichnen;
   
   
   
   procedure RahmenZeichnen
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor;
      GrößeExtern : in Sf.System.Vector2.sfVector2f;
      RahmendickeExtern : in Float)
   is begin
      
      Sf.Graphics.RectangleShape.setSize (shape => RahmenAccess,
                                          size  => GrößeExtern);
      Sf.Graphics.RectangleShape.setPosition (shape    => RahmenAccess,
                                              position => PositionExtern);
      Sf.Graphics.RectangleShape.setFillColor (shape => RahmenAccess,
                                               color => Sf.Graphics.Color.sfTransparent);
      Sf.Graphics.RectangleShape.setOutlineColor (shape => RahmenAccess,
                                                  color => FarbeExtern);
      Sf.Graphics.RectangleShape.setOutlineThickness (shape     => RahmenAccess,
                                                      thickness => RahmendickeExtern);
      
      
      Sf.Graphics.RenderWindow.drawRectangleShape (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                   object       => RahmenAccess);
      
   end RahmenZeichnen;

end ObjekteZeichnenSFML;
