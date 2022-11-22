private with Sf.System.Vector2;

with RassenDatentypen;
with StadtDatentypen;

private with GrafikRecordKonstanten;

with LeseRassenbelegung;

package VerkaufsauswahlGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Verkaufsauswahl
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AktuelleAuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

private

   AktuelleTextbreite : Float;

   Textposition : Sf.System.Vector2.sfVector2f;

   type ViewflächenArray is array (GrafikRecordKonstanten.Verkausmenübereich'Range) of Sf.System.Vector2.sfVector2f;
   Viewfläche : ViewflächenArray := (others => GrafikRecordKonstanten.StartgrößeView);

   procedure Gebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure InformationenGebäude
     (AuswahlExtern : in StadtDatentypen.GebäudeIDMitNullwert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

end VerkaufsauswahlGrafik;
