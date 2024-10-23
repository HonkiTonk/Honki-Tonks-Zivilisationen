with KartenDatentypen;
with KartenRecords;
with AufgabenDatentypen;

with LeseWeltkarteneinstellungen;

package FeldeffektEntfernenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   procedure FeldeffektEntfernen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FeldeffektExtern : in AufgabenDatentypen.Einheitenbefehle_Gelände_Enum)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end FeldeffektEntfernenLogik;
