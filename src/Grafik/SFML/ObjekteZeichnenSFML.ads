pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;
with Sf;
with Sf.Graphics.Color;
with Sf.System.Vector2;

package ObjekteZeichnenSFML is
   
   procedure RechteckZeichnen
     (AbmessungExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor;
      RechteckAccessExtern : in Sf.Graphics.sfRectangleShape_Ptr)
     with
       Pre => (
                 RechteckAccessExtern /= null
               and
                 (AbmessungExtern.x /= 0.00
                        -- Muss hier kein 'and' sein, da es sonst unmöglich wäre einen Strich zu zeichnen.
                  or
                    AbmessungExtern.y /= 0.00)
              );
         
   procedure KreisZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor;
      KreisAccessExtern : in Sf.Graphics.sfCircleShape_Ptr)
     with
       Pre => (
                 KreisAccessExtern /= null
               and
                 RadiusExtern /= 0.00
              );

   
   ----------------------- Hier eventuell noch einen Contract für AnzahlEckenExtern einbauen.
   procedure PolygonZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      AnzahlEckenExtern : in Sf.sfSize_t;
      FarbeExtern : in Sf.Graphics.Color.sfColor;
      PolygonAccessExtern : in Sf.Graphics.sfCircleShape_Ptr)
     with
       Pre => (
                 PolygonAccessExtern /= null
               and
                 RadiusExtern /= 0.00
              );

end ObjekteZeichnenSFML;
