with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

private with GrafikRecordKonstanten;

package DiplomatieauswahlGrafik is
   pragma Elaborate_Body;

   procedure Diplomatieauswahl
     (AuswahlExtern : in Natural);

private

   Textbreite : Float;

   Text : Unbounded_Wide_Wide_String;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;

   function Textdarstellung
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Textdarstellung'Result.x >= 0.00
                and
                  Textdarstellung'Result.y >= 0.00
               );

end DiplomatieauswahlGrafik;
