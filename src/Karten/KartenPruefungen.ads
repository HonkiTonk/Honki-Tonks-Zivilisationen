pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten;
use Karten;

package KartenPruefungen is

   function KartenPositionBestimmenKartengenerator
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      ZusatzYAbstandExtern : in GlobaleDatentypen.KartenfeldPositivMitNullwert)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           ((if
                      KartenPositionBestimmenKartengenerator'Result.YAchse = 0
                        then
                          KartenPositionBestimmenKartengenerator'Result.XAchse = 0)
            and
              (if
                         KartenPositionBestimmenKartengenerator'Result.XAchse = 0
                           then
                             KartenPositionBestimmenKartengenerator'Result.YAchse = 0)
            and
              KartenPositionBestimmenKartengenerator'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              KartenPositionBestimmenKartengenerator'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function KartenPositionBestimmen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           ((if -- Hier kommt der Fehler, mal nachprüfen
                      KartenPositionBestimmen'Result.YAchse = 0
                        then
                          KartenPositionBestimmen'Result.XAchse = 0)
            and
              (if
                         KartenPositionBestimmen'Result.XAchse = 0
                           then
                             KartenPositionBestimmen'Result.YAchse = 0)
            and
              KartenPositionBestimmen'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              KartenPositionBestimmen'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function KartenGrund
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

private
   
   type PositionArray is array (GlobaleDatentypen.EbeneVorhanden'Range) of GlobaleRecords.AchsenKartenfeldPositivRecord;
   type ÄnderungArray is array (GlobaleDatentypen.EbeneVorhanden'Range) of GlobaleRecords.AchsenKartenfeldRecord;
   type PositionFeldArray is array (GlobaleDatentypen.EbeneVorhanden'Range) of GlobaleDatentypen.Kartenfeld;
   type ÜberhangArray is array (GlobaleDatentypen.EbeneVorhanden'Range) of Integer;
      
   PolXAchse : PositionFeldArray;
   PositionAchse : PositionArray;
   
   ÜberhangYAchse : ÜberhangArray;
   ÜberhangXAchse : ÜberhangArray;
   
   function KartenPositionBestimmenYAchse
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           (KartenPositionBestimmenYAchse'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              KartenPositionBestimmenYAchse'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
     
   function KartenPositionBestimmenXAchse
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           (KartenPositionBestimmenXAchse'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              KartenPositionBestimmenXAchse'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

end KartenPruefungen;
