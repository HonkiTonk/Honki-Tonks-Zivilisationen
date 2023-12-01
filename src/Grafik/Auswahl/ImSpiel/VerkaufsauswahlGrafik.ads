private with Sf.System.Vector2;

with SpeziesDatentypen;
with StadtDatentypen;

private with GrafikRecordKonstanten;

with LeseSpeziesbelegung;

package VerkaufsauswahlGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Verkaufsauswahl
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      AktuelleAuswahlExtern : in StadtDatentypen.GebäudeID)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

private

   AktuelleTextbreite : Float;

   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;

   procedure Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

end VerkaufsauswahlGrafik;
