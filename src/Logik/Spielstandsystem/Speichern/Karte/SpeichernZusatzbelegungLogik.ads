with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

with KartenRecords;
with KartenDatentypen;

private with KartengrundDatentypen;
private with KartenextraDatentypen;
private with KartenverbesserungDatentypen;
private with StadtRecords;

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
   
   type ZusatzgrundArray is array (SystemDatentypenHTSEB.AchtElemente) of KartengrundDatentypen.Zusatzgrund_Enum;
   Zusatzgrund : ZusatzgrundArray;
   
   type FlussArray is array (ZusatzgrundArray'Range) of KartenextraDatentypen.Fluss_Enum;
   Fluss : FlussArray;
   
   type RessourceArray is array (ZusatzgrundArray'Range) of KartenextraDatentypen.Ressourcen_Enum;
   Ressource : RessourceArray;
   
   type WegArray is array (ZusatzgrundArray'Range) of KartenverbesserungDatentypen.Weg_Enum;
   Weg : WegArray;
   
   type VerbesserungArray is array (ZusatzgrundArray'Range) of KartenverbesserungDatentypen.Verbesserung_Enum;
   Verbesserung : VerbesserungArray;
   
   type StadtArray is array (ZusatzgrundArray'Range) of StadtRecords.SpeziesStadtnummerRecord;
   Stadt : StadtArray;
   
   type FeldeffekteArray is array (ZusatzgrundArray'Range) of KartenRecords.FeldeffektArray;
   Feldeffekte : FeldeffekteArray;
   
   
   
   function ZusatzgrundSchreiben
     (ZusatzgrundExtern : in ZusatzgrundArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean;
   
   function FlussSchreiben
     (FlussExtern : in FlussArray;
      DateiSpeichernExtern : in File_Type)
      return Boolean;
   
   function RessourceSchreiben
     (RessourceExtern : in RessourceArray;
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
