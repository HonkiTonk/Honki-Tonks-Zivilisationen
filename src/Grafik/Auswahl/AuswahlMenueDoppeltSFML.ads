pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;
private with Sf.Graphics.Color;

with MenueDatentypen;

private with GrafikRecordKonstanten;
private with TextKonstanten;

package AuswahlMenueDoppeltSFML is

   procedure AuswahlMenüDoppelt
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      AktuelleAuswahlExtern : in Natural);
   
private
   
   Textarrayanpassung : constant Positive := 2;
   Auswahlbereich : constant Positive := 1;
   Zusatzbereich : constant Positive := 2;
   
   Textbreite : Float;
   
   Textposition : Sf.System.Vector2.sfVector2f;
   
   -- Mal eine eigene Konstante für die Viewflächen anlegen. äöü
   type ViewflächenArray is array (GrafikRecordKonstanten.MenüDoppelbereich'Range) of Sf.System.Vector2.sfVector2f;
   Viewfläche : ViewflächenArray := (others => TextKonstanten.StartpositionText);
   
   Farbe : Sf.Graphics.Color.sfColor;

   procedure FarbenFestlegen
     (AktuellerTextExtern : in Positive;
      AktuelleAuswahlExtern : in Natural;
      WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum);
   
   
   
   function TextpositionFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  TextpositionFestlegen'Result.x >= 0.00
                and
                  TextpositionFestlegen'Result.y >= 0.00
               );

end AuswahlMenueDoppeltSFML;
