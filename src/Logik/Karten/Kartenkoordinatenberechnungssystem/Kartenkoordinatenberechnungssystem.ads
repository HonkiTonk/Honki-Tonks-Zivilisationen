pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;
with KartenRecords;

with Karten;

package Kartenkoordinatenberechnungssystem is

   function Kartenkoordinatenberechnungssystem
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldPositivRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße),
           
         Post =>
           ((if
                      Kartenkoordinatenberechnungssystem'Result.YAchse = KartenKonstanten.LeerYAchse
                        then
              (Kartenkoordinatenberechnungssystem'Result.XAchse = KartenKonstanten.LeerXAchse
               and
                 Kartenkoordinatenberechnungssystem'Result.EAchse = KartenKonstanten.LeerEAchse)
           )
            and
              (if
                         Kartenkoordinatenberechnungssystem'Result.XAchse = KartenKonstanten.LeerXAchse
                           then
                 (Kartenkoordinatenberechnungssystem'Result.YAchse = KartenKonstanten.LeerYAchse
                  and
                    Kartenkoordinatenberechnungssystem'Result.EAchse = KartenKonstanten.LeerEAchse)
              )
            and
              (if
                         Kartenkoordinatenberechnungssystem'Result.EAchse = KartenKonstanten.LeerEAchse
                           then
                 (Kartenkoordinatenberechnungssystem'Result.YAchse = KartenKonstanten.LeerYAchse
                  and
                    Kartenkoordinatenberechnungssystem'Result.XAchse = KartenKonstanten.LeerXAchse)
              )
            and
              Kartenkoordinatenberechnungssystem'Result.YAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
            and
              Kartenkoordinatenberechnungssystem'Result.XAchse <= Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße);
   
private
   
   type NeueKoordinateArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenRecords.AchsenKartenfeldPositivRecord;
   NeueKoordinate : NeueKoordinateArray;
   
end Kartenkoordinatenberechnungssystem;
