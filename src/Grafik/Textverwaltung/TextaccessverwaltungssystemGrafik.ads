with Sf.Graphics;
with Sf.System.Vector2;
with Sf.Graphics.Color;

package TextaccessverwaltungssystemGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfText_Ptr;
   
   procedure PositionSkalierenFarbeZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
     with
       Pre => (
                 TextaccessExtern /= null
                 --   and
               --     PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
                 -- and
               --   SkalierungExtern.x >= 0.00
               -- and
               --   SkalierungExtern.y >= 0.00
              );
   
   procedure PositionFarbeZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
     with
       Pre => (
                 TextaccessExtern /= null
                 --   and
               --     PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure PositionFarbe
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
     with
       Pre => (
                 TextaccessExtern /= null
                 --   and
               --     PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
              );
   
   procedure TextFarbe
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
     with
       Pre => (
                 TextaccessExtern /= null
              );
   
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
   
   procedure TextPosition
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
   
   procedure PositionZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 TextaccessExtern /= null
                 -- Das hier funktioniert aktuell nicht mit dem Hauptmenü, später anpassen. äöü
               -- and
               --   PositionExtern.x >= 0.00
               -- and
               --   PositionExtern.y >= 0.00
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
   
   procedure SkalierenZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 TextaccessExtern /= null
                 -- and
               --   SkalierungExtern.x >= 0.00
               -- and
               --   SkalierungExtern.y >= 0.00
              );
   
   procedure TextPositionSkalierenZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      TextExtern : in Wide_Wide_String;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 TextaccessExtern /= null
               and
                 PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
               and
                 SkalierungExtern.x >= 0.00
               and
                 SkalierungExtern.y >= 0.00
              );
   
   procedure PositionSkalierenZeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f)
     with
       Pre => (
                 TextaccessExtern /= null
                 -- and
               --   PositionExtern.x >= 0.00
               and
                 PositionExtern.y >= 0.00
               and
                 SkalierungExtern.x >= 0.00
               and
                 SkalierungExtern.y >= 0.00
              );
   
   procedure SkalierenFarbe
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
     with
       Pre => (
                 TextaccessExtern /= null
               and
                 SkalierungExtern.x >= 0.00
               and
                 SkalierungExtern.y >= 0.00
              );
   
   procedure Skalieren
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
   
   procedure Farbe
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
     with
       Pre => (
                 TextaccessExtern /= null
              );
   
   procedure Zeichnen
     (TextaccessExtern : in Sf.Graphics.sfText_Ptr)
     with
       Pre => (
                 TextaccessExtern /= null
              );

end TextaccessverwaltungssystemGrafik;
