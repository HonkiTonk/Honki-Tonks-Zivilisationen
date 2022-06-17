pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;
with KartenRecords;

with Karten;

package Kartenkoordinatenberechnungssystem is

   function Kartenkoordinatenberechnungssystem
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre =>
         (KoordinatenExtern.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
          and
            KoordinatenExtern.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse),
           
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
              Kartenkoordinatenberechnungssystem'Result.YAchse <= Karten.Kartenparameter.Kartengröße.YAchse
            and
              Kartenkoordinatenberechnungssystem'Result.XAchse <= Karten.Kartenparameter.Kartengröße.XAchse);
   
private
   
   type NeueKoordinateArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenRecords.AchsenKartenfeldNaturalRecord;
   NeueKoordinate : NeueKoordinateArray;
   
end Kartenkoordinatenberechnungssystem;
