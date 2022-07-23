pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.Graphics;
private with Sf.Graphics.RectangleShape;
private with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with StadtDatentypen;
private with EinheitenDatentypen;
private with StadtRecords;
private with MenueDatentypen;

package BauAuswahlAnzeigeSFML is

   procedure BauAuswahlAnzeige
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
     with
       Pre => (
                 if RasseExtern /= RassenDatentypen.Keine_Rasse_Enum then SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   AnfangsabstandExtratext : constant Float := 5.00;
   EndabstandExtratext : constant Float := 15.00;
   AbstandÜberschrift : Float;
   Multiplikator : Float;
   BreiteTextfeld : Float;

   Hintergrund : MenueDatentypen.Welches_Menü_Vorhanden_Enum;

   ZusatztextGebäude : StadtDatentypen.GebäudeIDMitNullwert;
   ZusatztextEinheiten : EinheitenDatentypen.EinheitenIDMitNullWert;

   AktuellerTextbereichEins : Unbounded_Wide_Wide_String;
   AktuellerTextbereichZwei : Unbounded_Wide_Wide_String;

   AktuelleAuswahl : StadtRecords.BauprojektRecord;

   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   StartPositionText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   VerhältnisTextfeld : constant Sf.System.Vector2.sfVector2f := (0.48, 0.80);
   Grundposition : Sf.System.Vector2.sfVector2f;
   TextPosition : Sf.System.Vector2.sfVector2f;

   procedure SchriftgrößenFestlegen;

end BauAuswahlAnzeigeSFML;
