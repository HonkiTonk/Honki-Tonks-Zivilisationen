with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with KartenRecords;
with KartenDatentypen;

private with KartengrundDatentypen;

with LeseWeltkarteneinstellungen;

package SpeichernBasisgrundLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
      
   function Basisgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
private
   
   Kerngrund : KartengrundDatentypen.Basisgrund_Kernfläche_Enum;

end SpeichernBasisgrundLogik;
