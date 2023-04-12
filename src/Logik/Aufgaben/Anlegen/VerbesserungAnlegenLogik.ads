with KartenDatentypen;
with KartenRecords;
with AufgabenDatentypen;

private with KartenverbesserungDatentypen;

with LeseWeltkarteneinstellungen;

package VerbesserungAnlegenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;

   procedure VerbesserungAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      VerbesserungExtern : in AufgabenDatentypen.Einheitenbefehle_Gebilde_Enum)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

private

   WelcheVerbesserung : KartenverbesserungDatentypen.Verbesserung_Gebilde_Enum;

end VerbesserungAnlegenLogik;
