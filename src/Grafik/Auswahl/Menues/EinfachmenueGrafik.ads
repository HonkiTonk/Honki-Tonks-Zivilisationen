private with Sf.System.Vector2;

with MenueDatentypen;

private with GrafikRecordKonstanten;

package EinfachmenueGrafik is
   pragma Elaborate_Body;

   procedure Einfachmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Integer);

private

   Textbreite : Float;
   Viewbreite : Float;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;



   function Textdarstellung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AktuelleAuswahlExtern : in Integer)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Textdarstellung'Result.x >= 0.00
                and
                  Textdarstellung'Result.y >= 0.00
               );

end EinfachmenueGrafik;
