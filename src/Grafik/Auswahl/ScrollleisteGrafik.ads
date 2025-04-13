private with Sf.System.Vector2;

private with GrafikRecordKonstanten;

package ScrollleisteGrafik is
   pragma Elaborate_Body;
   
   procedure Scrollen
     (BelegungslängeExtern : in Float;
      AbschnittExtern : in Natural)
     with
       Pre => (
                 BelegungslängeExtern >= 0.00
              );

private
   
   Durchläufe : Natural;
   
   Leistenabschnitt : Float;
   
   ViewflächeScrollen : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;

end ScrollleisteGrafik;
