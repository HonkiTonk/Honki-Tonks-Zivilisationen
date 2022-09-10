pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;

private with KartengrundDatentypen;

with Karten;

package WaldAnlegenLogik is

   procedure WaldAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );

private

   NeuerGrund : KartengrundDatentypen.Kartengrund_Vorhanden_Enum;

end WaldAnlegenLogik;
