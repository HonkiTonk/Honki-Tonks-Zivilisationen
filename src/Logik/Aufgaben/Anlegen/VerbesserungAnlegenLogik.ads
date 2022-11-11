with KartenDatentypen; use KartenDatentypen;
with KartenRecords;
with AufgabenDatentypen;
with Weltkarte;

private with KartenverbesserungDatentypen;

package VerbesserungAnlegenLogik is
   pragma Elaborate_Body;

   procedure VerbesserungAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      VerbesserungExtern : in AufgabenDatentypen.Einheitenbefehle_Gebilde_Enum)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              );

private

   WelcheVerbesserung : KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum;

end VerbesserungAnlegenLogik;
