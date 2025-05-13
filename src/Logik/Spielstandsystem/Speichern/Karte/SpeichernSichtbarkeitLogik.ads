with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with KartenDatentypen;
with KartenRecords;

private with SystemDatentypen;
private with SpeziesDatentypen;

with LeseWeltkarteneinstellungen;

package SpeichernSichtbarkeitLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;

   function Sichtbarkeit
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
      
private
   
   SichtbarkeitVorhanden : SystemDatentypen.EinByte;
   AktuelleSichtbarkeit : SystemDatentypen.EinByte;
   
   GesamteSichtbarkeit : KartenRecords.SichtbarkeitArray;
   
   
   
   function SpeziesanzahlErmitteln
     return SpeziesDatentypen.SpeziesnummernVorhanden;
   
   function AchtSpezies
     return Boolean;
   
   function SechzehnSpezies
     return Boolean;
   
   function AchtzehnSpezies
     return Boolean;

end SpeichernSichtbarkeitLogik;
