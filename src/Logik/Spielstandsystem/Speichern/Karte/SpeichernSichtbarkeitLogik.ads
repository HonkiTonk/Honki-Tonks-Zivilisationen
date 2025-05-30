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
   
   function Aufteilung
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
   
   SichtbarSpezies : SpeziesDatentypen.Speziesnummern;
   UnsichtbarSpezies : SpeziesDatentypen.Speziesnummern;
   VorhandeneSpezies : SpeziesDatentypen.Speziesnummern;
   
   AktuelleSichtbarkeit : SystemDatentypenHTSEB.EinByte;
   SichtbarkeitVorhanden : SystemDatentypenHTSEB.EinByte;
   
   AktuelleSichtbarkeitVorzeichen : SystemDatentypenHTSEB.EinByteVorzeichen;
   SichtbarkeitVorhandenVorzeichen : SystemDatentypenHTSEB.EinByteVorzeichen;
   
   AktuelleSichtbarkeitZweiByte : SystemDatentypenHTSEB.ZweiByte;
   SichtbarkeitVorhandenZweiByte : SystemDatentypenHTSEB.ZweiByte;
   
   GesamteSichtbarkeit : KartenRecords.SichtbarkeitArray;
   
   
   
   function SichtbarkeitEinByte
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function SichtbarkeitZweiByte
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function SichtbarkeitVorzeichen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.SpeziesnummernVorhanden;
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end SpeichernSichtbarkeitLogik;
