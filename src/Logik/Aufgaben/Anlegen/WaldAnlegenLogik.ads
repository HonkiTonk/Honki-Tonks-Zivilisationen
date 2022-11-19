with KartenDatentypen;
with KartenRecords;

with LeseWeltkarteneinstellungen;

private with KartengrundDatentypen;

package WaldAnlegenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   procedure WaldAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

private

   NeuerGrund : KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum;

end WaldAnlegenLogik;
