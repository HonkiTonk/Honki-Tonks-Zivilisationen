with KartenDatentypen;
with KartenKonstanten;
with KartenRecords;

with LeseWeltkarteneinstellungen;

package KartenkoordinatenberechnungssystemLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;
   use type KartenDatentypen.Ebene;

   function Kartenkoordinatenberechnungssystem
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      LogikGrafikExtern : in Boolean)
      return KartenRecords.AchsenKartenfeldNaturalRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              ),
           
       Post => (
                (if
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
                  Kartenkoordinatenberechnungssystem'Result.YAchse <= LeseWeltkarteneinstellungen.YAchse
                and
                  Kartenkoordinatenberechnungssystem'Result.XAchse <= LeseWeltkarteneinstellungen.XAchse
               );
   
private
   
   type NeueKoordinateArray is array (Boolean'Range) of KartenRecords.AchsenKartenfeldNaturalRecord;
   NeueKoordinate : NeueKoordinateArray;
   
end KartenkoordinatenberechnungssystemLogik;
