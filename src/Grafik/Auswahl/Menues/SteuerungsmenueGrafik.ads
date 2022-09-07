pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.Window.Keyboard;

private with Sf.System.Vector2;

with SystemRecords;

private with GrafikRecordKonstanten;

package SteuerungsmenueGrafik is

   procedure Steuerungsmenü
     (AuswahlExtern : in SystemRecords.MehrfacheAuswahlRecord);
   
private
   
   Zusatzabstand : Boolean;
      
   AktuelleBelegung : Sf.Window.Keyboard.sfKeyCode;
   
   Textbreite : Float;
   
   Text : Unbounded_Wide_Wide_String;
   
   Textposition : Sf.System.Vector2.sfVector2f;
   
   ViewflächeText : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   ViewflächeBelegung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   
   
      
   function BefehleAnzeigen
     (AuswahlExtern : in SystemRecords.MehrfacheAuswahlRecord)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  BefehleAnzeigen'Result.x >= 0.00
                and
                  BefehleAnzeigen'Result.y >= 0.00
               );
   
   function BelegungAnzeigen
     (AuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  BelegungAnzeigen'Result.x >= 0.00
                and
                  BelegungAnzeigen'Result.y >= 0.00
               );

end SteuerungsmenueGrafik;
