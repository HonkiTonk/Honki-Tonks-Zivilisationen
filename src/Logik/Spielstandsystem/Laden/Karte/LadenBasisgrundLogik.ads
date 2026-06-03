with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with KartenRecords;
with KartenDatentypen;

private with KartengrundDatentypen;

with LeseWeltkarteneinstellungen;

package LadenBasisgrundLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   function BasisgrundEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 if
                   LadenPrüfenExtern
                     then
                 (KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
                  and
                    KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte)
              );
   
private
   
   Basisgrund : KartengrundDatentypen.Basisgrund_Vorhanden_Enum;

end LadenBasisgrundLogik;
