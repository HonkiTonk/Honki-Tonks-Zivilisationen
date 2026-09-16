with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

with KartenRecords;
with KartenDatentypen;

private with KartenzusatzgrundDatentypen;
private with KartenfluesseDatentypen;
private with KartenverbesserungDatentypen;
private with StadtRecords;
private with KartenArrays;
private with KartenrohstoffeDatentypen;
private with KartenwegeDatentypen;

with LeseWeltkarteneinstellungen;

package SpeichernZusatzbelegungLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   
   procedure Leersetzung;
   
   procedure ZusätzeAbfragen
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
   
private
      
   FeldeffekteVorhanden : SystemDatentypenHTSEB.EinByte;
   AktuellerFeldeffekt : SystemDatentypenHTSEB.EinByte;
   
   FeldelementeVorhanden : SystemDatentypenHTSEB.EinByte;
   AktuellesFeldelement : SystemDatentypenHTSEB.EinByte;
   
   type ZusatzgrundArray is array (SystemDatentypenHTSEB.AchtElemente'Range) of KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   Zusatzgrund : ZusatzgrundArray;
   
   type FlussArray is array (ZusatzgrundArray'Range) of KartenfluesseDatentypen.Fluss_Enum;
   Fluss : FlussArray;
   
   type RohstoffeArray is array (ZusatzgrundArray'Range) of KartenrohstoffeDatentypen.Rohstoffe_Enum;
   Rohstoffe : RohstoffeArray;
   
   type WegArray is array (ZusatzgrundArray'Range) of KartenwegeDatentypen.Weg_Enum;
   Weg : WegArray;
   
   type VerbesserungArray is array (ZusatzgrundArray'Range) of KartenverbesserungDatentypen.Verbesserungen_Enum;
   Verbesserung : VerbesserungArray;
   
   type StadtArray is array (ZusatzgrundArray'Range) of StadtRecords.SpeziesStadtnummerRecord;
   Stadt : StadtArray;
   
   type FeldeffekteArray is array (ZusatzgrundArray'Range) of KartenArrays.FeldeffektArray;
   Feldeffekte : FeldeffekteArray;
   
   
   
   function ZusatzgrundSchreiben
     (ZusatzgrundExtern : in ZusatzgrundArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean;
   
   function FlussSchreiben
     (FlussExtern : in FlussArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean;
   
   function RohstoffSchreiben
     (RohstoffeExtern : in RohstoffeArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean;
   
   function WegSchreiben
     (WegExtern : in WegArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean;
   
   function VerbesserungSchreiben
     (VerbesserungExtern : in VerbesserungArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean;
   
   function StadtSchreiben
     (StadtExtern : in StadtArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean;
   
   function FeldeffekteSchreiben
     (FeldeffekteExtern : in FeldeffekteArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean;

end SpeichernZusatzbelegungLogik;
