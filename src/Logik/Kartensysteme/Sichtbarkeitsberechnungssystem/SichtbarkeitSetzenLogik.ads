with RassenDatentypen;
with KartenRecords;
with SpielVariablen;
with Weltkarte;
with KartenDatentypen;

private with StadtRecords;
private with EinheitenRecords;
private with KartengrundDatentypen;

package SichtbarkeitSetzenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   
   procedure SichtbarkeitSetzen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

   procedure EbenenBerechnungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 KoordinatenExtern.YAchse in Weltkarte.KarteArray'First (2) .. Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse in Weltkarte.KarteArray'First (3) .. Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
      
   EAchseAnfang : KartenDatentypen.EbeneVorhanden;
   EAchseEnde : KartenDatentypen.EbeneVorhanden;

   Basisgrund : KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
   Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum;

   FremdeStadt : StadtRecords.RasseStadtnummerRecord;

   FremdeEinheit : EinheitenRecords.RasseEinheitnummerRecord;

end SichtbarkeitSetzenLogik;
