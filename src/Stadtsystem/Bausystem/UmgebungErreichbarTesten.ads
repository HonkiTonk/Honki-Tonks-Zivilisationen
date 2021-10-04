pragma SPARK_Mode (On);

with GlobaleDatentypen, KartenRecords;
use GlobaleDatentypen;

with Karten;

package UmgebungErreichbarTesten is
   
   function UmgebungErreichbarTesten
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.MinimimMaximumID;
      NotwendigeFelderExtern : in Positive)
      return KartenRecords.AchsenKartenfeldPositivRecord
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
   
   BereitsGetestet : KartenDatentypen.LoopRangeMinusZweiZuZwei;
   Umgebung : KartenDatentypen.LoopRangeMinusDreiZuDrei;
   
   GefundeneFelder : Positive;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWertZwei : KartenRecords.AchsenKartenfeldPositivRecord;
   
   function NochErreichbar
     (AktuellePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.MinimimMaximumID)
      return Boolean;

end UmgebungErreichbarTesten;
