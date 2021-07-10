pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen;
use GlobaleDatentypen;

with Karten;
use Karten;

package KartenPruefungen is
   
   function KartenPositionBestimmenAufteilung
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
                      KartenPositionBestimmenAufteilung'Result.YAchse = 0
                        then
                          KartenPositionBestimmenAufteilung'Result.XAchse = 0)
            and
              (if
                         KartenPositionBestimmenAufteilung'Result.XAchse = 0
                           then
                             KartenPositionBestimmenAufteilung'Result.YAchse = 0)
            and
              KartenPositionBestimmenAufteilung'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              KartenPositionBestimmenAufteilung'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function KartenPositionXZylinder
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      -- Der ZusatzYAbstandExtern ist für <=, also z. B. 1 für <= Karten.KartenArray'First (2) oder 4 für <= Karten.KartenArray'First (2) + 3
      ZusatzYAbstandExtern : in GlobaleDatentypen.KartenfeldPositivMitNullwert)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           ((if
                      KartenPositionXZylinder'Result.YAchse = 0
                        then
                          KartenPositionXZylinder'Result.XAchse = 0)
            and
              (if
                         KartenPositionXZylinder'Result.XAchse = 0
                           then
                             KartenPositionXZylinder'Result.YAchse = 0)
            and
              KartenPositionXZylinder'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              KartenPositionXZylinder'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function KartenPositionYZylinder
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      -- Der ZusatzYAbstandExtern ist für <=, also z. B. 1 für <= Karten.KartenArray'First (2) oder 4 für <= Karten.KartenArray'First (2) + 3
      ZusatzYAbstandExtern : in GlobaleDatentypen.KartenfeldPositivMitNullwert)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           ((if
                      KartenPositionYZylinder'Result.YAchse = 0
                        then
                          KartenPositionYZylinder'Result.XAchse = 0)
            and
              (if
                         KartenPositionYZylinder'Result.XAchse = 0
                           then
                             KartenPositionYZylinder'Result.YAchse = 0)
            and
              KartenPositionYZylinder'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              KartenPositionYZylinder'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function KartenPositionTorus
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      -- Der ZusatzYAbstandExtern ist für <=, also z. B. 1 für <= Karten.KartenArray'First (2) oder 4 für <= Karten.KartenArray'First (2) + 3
      ZusatzYAbstandExtern : in GlobaleDatentypen.KartenfeldPositivMitNullwert)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           ((if
                      KartenPositionTorus'Result.YAchse = 0
                        then
                          KartenPositionTorus'Result.XAchse = 0)
            and
              (if
                         KartenPositionTorus'Result.XAchse = 0
                           then
                             KartenPositionTorus'Result.YAchse = 0)
            and
              KartenPositionTorus'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              KartenPositionTorus'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function KartenPositionKugel
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      -- Der ZusatzYAbstandExtern ist für <=, also z. B. 1 für <= Karten.KartenArray'First (2) oder 4 für <= Karten.KartenArray'First (2) + 3
      ZusatzYAbstandExtern : in GlobaleDatentypen.KartenfeldPositivMitNullwert)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           ((if
                      KartenPositionKugel'Result.YAchse = 0
                        then
                          KartenPositionKugel'Result.XAchse = 0)
            and
              (if
                         KartenPositionKugel'Result.XAchse = 0
                           then
                             KartenPositionKugel'Result.YAchse = 0)
            and
              KartenPositionKugel'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              KartenPositionKugel'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
   function KartenPositionViereck
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      -- Der ZusatzYAbstandExtern ist für <=, also z. B. 1 für <= Karten.KartenArray'First (2) oder 4 für <= Karten.KartenArray'First (2) + 3
      ZusatzYAbstandExtern : in GlobaleDatentypen.KartenfeldPositivMitNullwert)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße),
         Post =>
           ((if
                      KartenPositionViereck'Result.YAchse = 0
                        then
                          KartenPositionViereck'Result.XAchse = 0)
            and
              (if
                         KartenPositionViereck'Result.XAchse = 0
                           then
                             KartenPositionViereck'Result.YAchse = 0)
            and
              KartenPositionViereck'Result.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
            and
              KartenPositionViereck'Result.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
   
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
