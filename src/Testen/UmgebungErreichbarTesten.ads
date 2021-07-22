pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen, GlobaleRecords;

with Karten;

package UmgebungErreichbarTesten is
   
   type MöglicheFelderArray is array (1 .. 80) of GlobaleRecords.AchsenKartenfeldPositivRecord;
   MöglicheFelder : MöglicheFelderArray;

   function UmgebungErreichbarTesten
     (AktuelleKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in GlobaleDatentypen.KartenverbesserungEinheitenID)
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
   
   Möglich : Boolean;
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenWertNeu : GlobaleRecords.AchsenKartenfeldPositivRecord;

end UmgebungErreichbarTesten;
