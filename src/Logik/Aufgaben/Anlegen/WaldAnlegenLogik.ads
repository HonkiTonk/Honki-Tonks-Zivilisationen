with KartenDatentypen;
with KartenRecords;

with LeseWeltkarteneinstellungen;

private with KartengrundDatentypen;

package WaldAnlegenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   procedure WaldAnlegen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

private

   NeuerGrund : KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum;

end WaldAnlegenLogik;
