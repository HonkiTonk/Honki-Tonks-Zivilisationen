with KartenDatentypen;
with KartenRecords;

with LeseWeltkarteneinstellungen;

package RodenAnlegenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   procedure RodenAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
end RodenAnlegenLogik;
