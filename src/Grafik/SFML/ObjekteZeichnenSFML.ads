pragma SPARK_Mode (On);

with Sf;
with Sf.Graphics.Color;
with Sf.System.Vector2;

package ObjekteZeichnenSFML is
   
   procedure RechteckZeichnen
     (AbmessungExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor;
      RechteckAccessExtern : in Sf.Graphics.sfRectangleShape_Ptr);

   procedure KreisZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor;
      KreisAccessExtern : in Sf.Graphics.sfCircleShape_Ptr);

   procedure PolygonZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      AnzahlEckenExtern : in Sf.sfSize_t;
      FarbeExtern : in Sf.Graphics.Color.sfColor;
      PolygonAccessExtern : in Sf.Graphics.sfCircleShape_Ptr);

end ObjekteZeichnenSFML;
