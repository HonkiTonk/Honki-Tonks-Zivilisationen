with KartenDatentypen;
with KartenRecords;
with Weltkarte;

package RodenAnlegenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   procedure RodenAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );
   
end RodenAnlegenLogik;
