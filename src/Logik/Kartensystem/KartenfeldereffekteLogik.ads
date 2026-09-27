with KartenRecords;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package KartenfeldereffekteLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   function FeldeffektVorhanden
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end KartenfeldereffekteLogik;
