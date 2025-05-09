with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with KartenRecords;
private with EinheitenRecords;
private with StadtRecords;
private with KartengrundDatentypen;
private with KartenextraDatentypen;
private with KartenverbesserungDatentypen;
private with KartenDatentypen;
private with SystemDatentypen;

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
   
   SichtbarkeitVorhanden : SystemDatentypen.EinByte;
   AktuelleSichtbarkeit : SystemDatentypen.EinByte;
   
   FeldeffekteVorhanden : SystemDatentypen.EinByte;
   AktuellerFeldeffekt : SystemDatentypen.EinByte;
   
   FeldelementeVorhanden : SystemDatentypen.EinByte;
      
   Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Enum;
      
   Fluss : KartenextraDatentypen.Fluss_Enum;
   
   Ressource : KartenextraDatentypen.Ressourcen_Enum;
   
   Weg : KartenverbesserungDatentypen.Weg_Enum;
   
   Verbesserung : KartenverbesserungDatentypen.Verbesserung_Enum;
   
   Feldeffekte : KartenRecords.FeldeffektArray;
   
   Einheit : EinheitenRecords.SpeziesEinheitnummerRecord;
     
   Stadt : StadtRecords.SpeziesStadtnummerRecord;
   
   GesamteSichtbarkeit : KartenRecords.SichtbarkeitArray;
   
   
      
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
   
   function VorhandeneFeldelemente
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      EinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean;
   
   function Feldelemente
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      EinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean;
   
end SpeichernKarteLogik;
