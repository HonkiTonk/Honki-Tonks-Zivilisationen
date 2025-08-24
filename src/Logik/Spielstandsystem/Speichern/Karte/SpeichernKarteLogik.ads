with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

private with KartenRecords;
private with StadtRecords;
private with KartengrundDatentypen;
private with KartenextraDatentypen;
private with KartenverbesserungDatentypen;
private with KartenDatentypen;
private with SpeziesDatentypen;

private with LeseWeltkarteneinstellungen;

package SpeichernKarteLogik is
   pragma Elaborate_Body;

   function Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
      return Boolean;
      
private
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   AnzahlFelder : Natural;
   
   VorhandeneSpezies : SpeziesDatentypen.Speziesnummern;
   
   FeldeffekteVorhanden : SystemDatentypenHTSEB.EinByte;
   AktuellerFeldeffekt : SystemDatentypenHTSEB.EinByte;
   
   FeldelementeVorhanden : SystemDatentypenHTSEB.EinByte;
   AktuellesFeldelement : SystemDatentypenHTSEB.EinByte;
   
   type ZusatzgrundArray is array (0 .. 7) of KartengrundDatentypen.Zusatzgrund_Enum;
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
   
end SpeichernKarteLogik;
