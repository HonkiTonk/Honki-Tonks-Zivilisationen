pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package GrafischeAnzeige is

   procedure Sichtbarkeit
     (InDerStadtExtern : in Boolean;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure Farben
     (EinheitExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID;
      VerbesserungExtern : in GlobaleDatentypen.KartenVerbesserung;
      RessourceExtern, GrundExtern : in GlobaleDatentypen.KartenGrund;
      CursorExtern : in Boolean;
      EigeneRasseExtern, RasseExtern : in GlobaleDatentypen.RassenMitNullwert)
     with
       Pre =>
         ((if EigeneRasseExtern > 0 then GlobaleVariablen.RassenImSpiel (EigeneRasseExtern) = 1)
          and
            (if RasseExtern > 0 then GlobaleVariablen.RassenImSpiel (RasseExtern) > 0));

private

   EinheitStadtRasseNummer : GlobaleRecords.RassePlatznummerRecord;

end GrafischeAnzeige;
