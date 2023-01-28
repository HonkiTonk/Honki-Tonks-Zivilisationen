with KartenRecords;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package KartenfeldereffekteLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   function FeldeffektVorhanden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

end KartenfeldereffekteLogik;
