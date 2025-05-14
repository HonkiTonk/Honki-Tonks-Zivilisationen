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
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function SpeziesanzahlErmitteln
     return SpeziesDatentypen.SpeziesnummernVorhanden;
      
private
   
   AktuellerBereich : Positive;
   
   VorhandeneSpezies : SpeziesDatentypen.Speziesnummern;
   
   AktuelleSichtbarkeit : SystemDatentypenHTSEB.EinByte;
   
   GesamteSichtbarkeit : KartenRecords.SichtbarkeitArray;
   
   type SichtbarkeitArray is array (1 .. 3) of SystemDatentypenHTSEB.EinByte;
   SichtbarkeitVorhanden : SichtbarkeitArray;

end SpeichernSichtbarkeitLogik;
