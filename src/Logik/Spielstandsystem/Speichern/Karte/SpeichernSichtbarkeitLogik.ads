with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

with KartenDatentypen;
with KartenRecords;
with SpeziesDatentypen;

with LeseWeltkarteneinstellungen;

package SpeichernSichtbarkeitLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   function Sichtbarkeit
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.Speziesnummern;
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
      
private
   
   VorhandeneSpezies : SpeziesDatentypen.Speziesnummern;
   
   AktuelleSichtbarkeit : SystemDatentypenHTSEB.EinByte;
   SichtbarkeitVorhanden : SystemDatentypenHTSEB.EinByte;
   
   GesamteSichtbarkeit : KartenRecords.SichtbarkeitArray;

end SpeichernSichtbarkeitLogik;
