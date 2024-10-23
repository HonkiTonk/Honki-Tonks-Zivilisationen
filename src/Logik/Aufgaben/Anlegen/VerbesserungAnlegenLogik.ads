with KartenDatentypen;
with KartenRecords;
with AufgabenDatentypen;

private with KartenverbesserungDatentypen;

with LeseWeltkarteneinstellungen;

package VerbesserungAnlegenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   procedure VerbesserungAnlegen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VerbesserungExtern : in AufgabenDatentypen.Einheitenbefehle_Gebilde_Enum)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

private

   WelcheVerbesserung : KartenverbesserungDatentypen.Verbesserung_Gebilde_Enum;

end VerbesserungAnlegenLogik;
