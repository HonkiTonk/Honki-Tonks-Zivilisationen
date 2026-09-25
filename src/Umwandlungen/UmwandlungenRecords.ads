with KartenRecords;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package UmwandlungenRecords is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   function KartenfeldVorhandenNatural
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     return KartenRecords.KartenfeldNaturalRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   pragma Inline (KartenfeldVorhandenNatural);

end UmwandlungenRecords;
