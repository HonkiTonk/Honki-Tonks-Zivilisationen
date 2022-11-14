with KartenDatentypen;
with KartenKonstanten;
with KartenRecords;
with Weltkarte;

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
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
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
                  Kartenkoordinatenberechnungssystem'Result.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
                and
                  Kartenkoordinatenberechnungssystem'Result.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               );
   
private
   
   type NeueKoordinateArray is array (Boolean'Range, KartenDatentypen.EbeneVorhanden'Range) of KartenRecords.AchsenKartenfeldNaturalRecord;
   NeueKoordinate : NeueKoordinateArray;
   
end KartenkoordinatenberechnungssystemLogik;
