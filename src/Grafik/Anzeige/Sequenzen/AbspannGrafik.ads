private with Sf.System.Vector2;

with SpeziesDatentypen;
with GrafikDatentypen;

private with GrafikRecordKonstanten;

package AbspannGrafik is
   pragma Elaborate_Body;

   procedure Abspann
     (AbspannExtern : in GrafikDatentypen.Abspannhintergrund_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum);
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
     (MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 MaximaleTextbreiteExtern >= 0.00
              ),

       Post => (
                  AllgemeinerText'Result >= 0.00
               );

   function PlanetVernichtet
     (MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 MaximaleTextbreiteExtern >= 0.00
              ),

       Post => (
                  PlanetVernichtet'Result >= 0.00
               );

   function Gewonnen
     (MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 MaximaleTextbreiteExtern >= 0.00
              ),

       Post => (
                  Gewonnen'Result >= 0.00
               );

end AbspannGrafik;
