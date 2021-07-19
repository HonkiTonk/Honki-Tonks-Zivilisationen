pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package GrafischeAnzeige is

   procedure Sichtbarkeit
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch);

   procedure Farben
     (EinheitExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID;
      VerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum;
      RessourceExtern, GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      CursorExtern : in Boolean;
      EigeneRasseExtern, RasseExtern : in GlobaleDatentypen.Rassen_Enum)
     with
       Pre =>
         ((if EigeneRasseExtern /= GlobaleDatentypen.Leer then GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = GlobaleDatentypen.Spieler_Mensch)
          and
            (if RasseExtern /= GlobaleDatentypen.Leer then GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer));

private

   EinheitStadtRasseNummer : GlobaleRecords.RassePlatznummerRecord;

end GrafischeAnzeige;
