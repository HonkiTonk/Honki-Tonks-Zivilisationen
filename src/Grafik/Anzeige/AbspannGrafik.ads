pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

with RassenDatentypen; -- use RassenDatentypen;
-- with SpielVariablen;
with GrafikDatentypen;

private with GrafikRecordKonstanten;

package AbspannGrafik is

   procedure Abspann
     (AbspannExtern : in GrafikDatentypen.Abspann_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   -- Später wieder einbauen, funktioniert aktuell nicht richtig da die gewinnende Rasse nicht fesgetzt wird. äöü
   --  with
   --    Pre => (
   --            SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
   --       );

private

   Textbreite : Float;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;



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
