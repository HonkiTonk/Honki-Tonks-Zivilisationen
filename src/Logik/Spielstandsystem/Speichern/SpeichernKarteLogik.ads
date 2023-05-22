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

   procedure Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean);
      
private
   use type KartenDatentypen.Kartenfeld;
   
   GesamteSichtbarkeit : KartenRecords.SichtbarkeitArray;
   
   Sichtbarkeit : SystemDatentypen.Sichtbarkeitszahl;
   
   VorhandeneFeldelemente : SystemDatentypen.FeldelementVorhanden;
      
   Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Enum;
   
   Feldeffekte : KartenRecords.FeldeffektArray;
      
   Fluss : KartenextraDatentypen.Fluss_Enum;
   
   Ressource : KartenextraDatentypen.Ressourcen_Enum;
   
   Weg : KartenverbesserungDatentypen.Weg_Enum;
   
   Verbesserung : KartenverbesserungDatentypen.Verbesserung_Enum;
   
   Einheit : EinheitenRecords.SpeziesEinheitnummerRecord;
     
   Stadt : StadtRecords.SpeziesStadtnummerRecord;
      
   procedure SichtbarkeitSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
      
   procedure BasisgrundSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   procedure VorhandeneFeldelementeSchreiben
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      EinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type);
   
   procedure FeldelementeSchreiben
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      EinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type);
   
end SpeichernKarteLogik;
