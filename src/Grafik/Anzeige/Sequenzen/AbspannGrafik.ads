private with Sf.System.Vector2;

with SpeziesDatentypen;
with GrafikDatentypen;

private with GrafikRecordKonstanten;

package AbspannGrafik is
   pragma Elaborate_Body;

   procedure Abspann
     (AbspannExtern : in GrafikDatentypen.Abspann_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum);
   -- Später wieder einbauen, funktioniert aktuell nicht richtig da die gewinnende Spezies nicht festgetzt wird. äöü
   --  with
   --    Pre => (
   --            LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
   --       );

private

   AllgemeineTextzeilen : constant Positive := 2;

   Textbreite : Float;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   NeueViewfläche : Sf.System.Vector2.sfVector2f;
   Textposition : Sf.System.Vector2.sfVector2f;



   function AllgemeinerText
     return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  AllgemeinerText'Result.x >= 0.00
                and
                  AllgemeinerText'Result.y >= 0.00
               );

   function PlanetVernichtet
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
              ),

       Post => (
                  PlanetVernichtet'Result.x >= 0.00
                and
                  PlanetVernichtet'Result.y >= 0.00
               );

   function Gewonnen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 ViewflächeExtern.x >= 0.00
               and
                 ViewflächeExtern.y >= 0.00
              ),

       Post => (
                  Gewonnen'Result.x >= 0.00
                and
                  Gewonnen'Result.y >= 0.00
               );

end AbspannGrafik;
