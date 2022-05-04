pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.RectangleShape;
with Sf.System.Vector2;

with EinheitStadtDatentypen;
with EinheitStadtRecords;

package BauAuswahlAnzeigeSFML is

   procedure BauAuswahlAnzeige;

private

   SchriftartFestgelegt : Boolean := False;
   SchriftfarbeFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;
   TextFestgelegt : Boolean := False;

   Zeilenabstand : Float;
   AbstandÜberschrift : Float;

   ZusatztextGebäude : EinheitStadtDatentypen.GebäudeIDMitNullwert;
   ZusatztextEinheiten : EinheitStadtDatentypen.EinheitenIDMitNullWert;

   AktuelleAuswahl : EinheitStadtRecords.BauprojektRecord;

   ÜberschriftAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

   type GebäudtextAccessArray is array (EinheitStadtDatentypen.GebäudeIDMitNullwert'Range) of Sf.Graphics.sfText_Ptr;
   GebäudtextAccess : constant GebäudtextAccessArray := (others => Sf.Graphics.Text.create);

   type GebäudzusatztextAccessArray is array (EinheitStadtDatentypen.GebäudeID'Range) of Sf.Graphics.sfText_Ptr;
   GebäudzusatztextAccess : constant GebäudzusatztextAccessArray := (others => Sf.Graphics.Text.create);

   type EinheitentextAccessArray is array (EinheitStadtDatentypen.EinheitenIDMitNullWert'Range) of Sf.Graphics.sfText_Ptr;
   EinheitentextAccess : constant EinheitentextAccessArray := (others => Sf.Graphics.Text.create);

   type EinheitenzusatztextAccessArray is array (EinheitStadtDatentypen.EinheitenID'Range) of Sf.Graphics.sfText_Ptr;
   EinheitenzusatztextAccess : constant EinheitenzusatztextAccessArray := (others => Sf.Graphics.Text.create);

   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   StartPositionText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   Grundposition : Sf.System.Vector2.sfVector2f;
   TextPosition : Sf.System.Vector2.sfVector2f;



   function SchriftartFestlegen
     return Boolean;

   function SchriftgrößenFestlegen
     return Boolean;

   function SchriftfarbenFestlegen
     return Boolean;

   function TextFestlegen
     return Boolean;

end BauAuswahlAnzeigeSFML;
