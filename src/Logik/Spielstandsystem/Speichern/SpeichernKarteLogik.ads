with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with KartenRecords;
private with EinheitenRecords;
private with StadtRecords;
private with KartengrundDatentypen;
private with KartenextraDatentypen;
private with KartenverbesserungDatentypen;
private with KartenDatentypen;
private with SpeziesDatentypen;

private with LeseWeltkarteneinstellungen;

package SpeichernKarteLogik is
   pragma Elaborate_Body;

   procedure Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean);
      
private
   use type KartenDatentypen.Kartenfeld;
   
   GesamteSichtbarkeit : KartenRecords.SichtbarkeitArray;
   
   Sichtbarkeit : KartenRecords.Sichtbarkeitszahl;
   
   SichtbarkeitAnfang : SpeziesDatentypen.Spezies_Verwendet_Enum;
   SichtbarkeitEnde : SpeziesDatentypen.Spezies_Verwendet_Enum;
      
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
   
   procedure ZusatzgrundSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   procedure FlussSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   procedure RessourcenSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   procedure WegSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
end SpeichernKarteLogik;
