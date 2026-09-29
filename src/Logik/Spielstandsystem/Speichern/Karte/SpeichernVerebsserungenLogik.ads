with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with KartenRecords;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

package SpeichernVerebsserungenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;

   function Verbesserungen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end SpeichernVerebsserungenLogik;
