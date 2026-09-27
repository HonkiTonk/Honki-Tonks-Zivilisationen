with Sf.System.Vector2;

private with KartenDatentypen;
private with KartenKonstanten;

package ZusatztextKartenebeneGrafik is
   pragma Elaborate_Body;

   function ZusatztextKartenebene
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
               and
                 RealeViewbreiteExtern >= 0.00
              ),
         
       Post => (
                  ZusatztextKartenebene'Result.x >= 0.00
                and
                  ZusatztextKartenebene'Result.y >= 0.00
               );
   
private
   
   Trennbereich : constant Wide_Wide_String (1 .. 4) := " .. ";
   
   Textbreite : Float;
   
   Textposition : Sf.System.Vector2.sfVector2f;
   
   type ZusatztextArray is array (KartenDatentypen.EbeneVorhanden'Range) of Positive;
   Zusatztext : constant ZusatztextArray := (
                                             KartenKonstanten.KernKonstante        => 6,
                                             KartenKonstanten.UnterflächeKonstante => 5,
                                             KartenKonstanten.OberflächeKonstante  => 4,
                                             KartenKonstanten.HimmelKonstante      => 3,
                                             KartenKonstanten.OrbitKonstante       => 2
                                            );
                                         
   procedure TextFestlegen;
   
   
   
   function TextAnzeigen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
               and
                 RealeViewbreiteExtern >= 0.00
              ),
         
       Post => (
                  TextAnzeigen'Result.x >= 0.00
                and
                  TextAnzeigen'Result.y >= 0.00
               );

end ZusatztextKartenebeneGrafik;
