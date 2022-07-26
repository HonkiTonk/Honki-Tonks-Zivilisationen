pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

with RassenDatentypen;
private with ForschungenDatentypen;

package ForschungAnzeigeSFML is

   -- Hier später "KORREKTEN" Contract einfügen. äöü
   procedure ForschungAnzeige
     (RasseExtern : in RassenDatentypen.Rassen_Enum);
   
private
   
   Überschrift : constant ForschungenDatentypen.ForschungIDMitNullWert := 0;
   
   AktuelleAuswahl : ForschungenDatentypen.ForschungIDMitNullWert;
   WelcherZusatztext : ForschungenDatentypen.ForschungIDMitNullWert;
   
   WelcherText : Positive;
   
   AbstandÜberschrift : Float;
      
   MausZeigerPosition : Sf.System.Vector2.sfVector2i;

   StartPositionText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   TextPosition : Sf.System.Vector2.sfVector2f;

end ForschungAnzeigeSFML;
