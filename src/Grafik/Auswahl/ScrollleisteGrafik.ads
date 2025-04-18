private with Sf.System.Vector2;

private with GrafikRecordKonstanten;

with InteraktionAuswahl;

package ScrollleisteGrafik is
   pragma Elaborate_Body;
   
   procedure Scrollen
     (AbschnittExtern : in Natural)
     with
       Pre => (
                 AbschnittExtern < InteraktionAuswahl.PositionenSteuerungsleiste'Last
              );

private
   
   Leistenabschnitt : Float;
   
   ViewflächeScrollen : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;

end ScrollleisteGrafik;
