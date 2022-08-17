pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

package AllgemeineTextanzeigeSFML is

   procedure Überschrift;



   function Versionsnummer
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleTextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f;

private

   AktuelleTextbreite : Float;
   NeueTextbreite : Float;

   Rückgabewert : Sf.System.Vector2.sfVector2f;
   PositionVersionsnummer : Sf.System.Vector2.sfVector2f;

end AllgemeineTextanzeigeSFML;
