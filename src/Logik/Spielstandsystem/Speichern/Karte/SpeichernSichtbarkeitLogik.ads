with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

with KartenDatentypen;
with KartenRecords;
with SpeziesDatentypen;

private with KartenArrays;

with LeseWeltkarteneinstellungen;

package SpeichernSichtbarkeitLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   
   procedure Leersetzung;
   
   procedure Sichtbarkeitsbelegung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FelderanzahlExtern : in Positive)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   
   
   function Aufteilung
     (DateiSpeichernExtern : in File_Type)
      return Boolean;
   
   function SpeicherverbrauchErmitteln
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.SpeziesnummernVorhanden)
      return Positive
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
      
private
   
   Speicherverbrauch : Natural;
   
   SichtbarSpezies : SpeziesDatentypen.SpeziesnummernBasis;
   UnsichtbarSpezies : SpeziesDatentypen.SpeziesnummernBasis;
   VorhandeneSpezies : SpeziesDatentypen.SpeziesnummernBasis;
   
   SichtbarkeitGesamt : KartenArrays.SichtbarkeitGesamtArray;
   
   GesamteSichtbarkeit : KartenRecords.SichtbarkeitArray;
      
   AktuelleSichtbarkeit : SystemDatentypenHTSEB.EinByte;
   SichtbarkeitVorhanden : SystemDatentypenHTSEB.EinByte;
   
   AktuelleSichtbarkeitVorzeichen : SystemDatentypenHTSEB.EinByteVorzeichen;
   SichtbarkeitVorhandenVorzeichen : SystemDatentypenHTSEB.EinByteVorzeichen;
   
   
   
   function SichtbarkeitSchreiben
     (DateiSpeichernExtern : in File_Type;
      SichtbarkeitExtern : in KartenArrays.SichtbarkeitGesamtArray;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean;

end SpeichernSichtbarkeitLogik;
