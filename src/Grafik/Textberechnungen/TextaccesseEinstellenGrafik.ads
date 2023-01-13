with Sf.Graphics;
with Sf.System.Vector2;
with Sf.Graphics.Color;

package TextaccesseEinstellenGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfText_Ptr;
   
   procedure TextPositionFarbeZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
     with
       Pre => (
                 TextaccessExtern /= null
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure PositionZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 TextaccessExtern /= null
                 -- Das hier funktioniert aktuell nicht mit dem Hauptmenü, später anpassen. äöü
               -- and
               --   PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );

   procedure TextPositionZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 TextaccessExtern /= null
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure TextPositionStandardskalierungZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 TextaccessExtern /= null
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure TextPositionStandardskalierung
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 TextaccessExtern /= null
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure SkalierenZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 TextaccessExtern /= null
               and
                 SkalierungExtern.x >= 0.00
               and
                 SkalierungExtern.y >= 0.00
              );

end TextaccesseEinstellenGrafik;
