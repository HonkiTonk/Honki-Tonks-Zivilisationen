pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

with Karten;

package KIStadtSuchen is

   function NähesteFeindlicheStadtSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer
          and
            AnfangKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            AnfangKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

   function UnbewachteStadtSuchen
     (FeindlicheRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (FeindlicheRasseExtern) = GlobaleDatentypen.Spieler_KI);

private

   AktuelleStadt : GlobaleDatentypen.MaximaleStädteMitNullWert;
   GefundeneStadt : GlobaleDatentypen.MaximaleStädteMitNullWert;
   Entfernung : Positive;
   EntfernungNeu : Positive;

   function StadtSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      AnfangKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleStädteMitNullWert;

end KIStadtSuchen;
