with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with Weltkarte;

private with KartengrundDatentypen;

package WaldAnlegenLogik is
   pragma Elaborate_Body;

   procedure WaldAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

private

   NeuerGrund : KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum;

end WaldAnlegenLogik;
