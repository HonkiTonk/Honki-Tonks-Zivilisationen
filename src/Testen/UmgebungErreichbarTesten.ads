pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package UmgebungErreichbarTesten is
   

   function UmgebungErreichbarTesten
     (AktuelleKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID;
      NotwendigeFelderExtern : in Positive)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (AktuelleKoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            AktuelleKoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           (UmgebungErreichbarTesten'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              UmgebungErreichbarTesten'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
private
   
   YAchseBereitsGetestet : GlobaleDatentypen.LoopRangeMinusZweiZuZwei;
   XAchseBereitsGetestet : GlobaleDatentypen.LoopRangeMinusZweiZuZwei;
   Umgebung : GlobaleDatentypen.LoopRangeMinusDreiZuDrei;
   
   GefundeneFelder : Positive;
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;

end UmgebungErreichbarTesten;
