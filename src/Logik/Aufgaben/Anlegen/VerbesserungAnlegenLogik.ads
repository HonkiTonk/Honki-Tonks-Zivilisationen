pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with AufgabenDatentypen;

private with KartenverbesserungDatentypen;

with Karten;

package VerbesserungAnlegenLogik is

   procedure VerbesserungAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      VerbesserungExtern : in AufgabenDatentypen.Einheitenbefehle_Gebilde_Enum)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );

private

   WelcheVerbesserung : KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum;

end VerbesserungAnlegenLogik;
