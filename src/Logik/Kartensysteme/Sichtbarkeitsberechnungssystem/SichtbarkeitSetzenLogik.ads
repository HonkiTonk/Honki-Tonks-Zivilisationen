with SpeziesDatentypen;
with KartenRecords;
with KartenKonstanten;
with KartenDatentypen;

private with StadtRecords;
private with EinheitenRecords;
private with KartengrundDatentypen;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

package SichtbarkeitSetzenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   procedure SichtbarkeitSetzen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   procedure EbenenBerechnungen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
      
   EAchseAnfang : KartenDatentypen.EbeneVorhanden;
   EAchseEnde : KartenDatentypen.EbeneVorhanden;

   Basisgrund : KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
   Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum;

   FremdeStadt : StadtRecords.SpeziesStadtnummerRecord;

   FremdeEinheit : EinheitenRecords.SpeziesEinheitnummerRecord;

end SichtbarkeitSetzenLogik;
