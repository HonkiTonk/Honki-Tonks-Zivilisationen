with Sf.Graphics;
with Sf.Graphics.Color;
with Sf.System.Vector2;

package KonvexverwaltungssystemGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfConvexShape_Ptr;

   procedure PositionFarbeZeichnen
     (KonvexaccessExtern : in Sf.Graphics.sfConvexShape_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
     with
       Pre => (
                 KonvexaccessExtern /= null
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

   procedure PfeilErstellen
     (PfeilaccessExtern : in Sf.Graphics.sfConvexShape_Ptr)
     with
       Pre => (
                 PfeilaccessExtern /= null
              );

end KonvexverwaltungssystemGrafik;
