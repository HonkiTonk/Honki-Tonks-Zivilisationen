pragma SPARK_Mode (On);

with Sf.Graphics;
with Sf.Graphics.RectangleShape;
with Sf.System.Vector2;
with Sf.Graphics.Color;
with Sf.Graphics.CircleShape;

with GlobaleTexte;

package GrafikAllgemein is

   -- Immer erster Grafikaufruf.
   procedure FensterLeeren;
   -- Immer erster Grafikaufruf.

   -- Immer letzter Grafikaufruf.
   procedure FensterAnzeigen;
   -- Immer letzter Grafikaufruf.

   procedure AllgemeinesFestlegen;
   procedure SchriftartFestlegen;
   procedure TextAllgemeinFestlegen;

   procedure TextZeichnen
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      WelcheZeileExtern : in Positive);

   procedure RechteckZeichnen
     (AbmessungExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor);

   procedure KreisZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FarbeExtern : in Sf.Graphics.Color.sfColor);

   procedure PolygonZeichnen
     (RadiusExtern : in Float;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      AnzahlEckenExtern : in Sf.sfSize_t;
      FarbeExtern : in Sf.Graphics.Color.sfColor);

private

   Rechteck : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   Kreis : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;
   Polygon : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;

   procedure PositionPrüfen
     (PositionExtern : in Sf.System.Vector2.sfVector2f);

end GrafikAllgemein;
