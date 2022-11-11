with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;

private with EinheitenRecords;
private with KartenRecords;
private with SpielVariablen;
private with Weltkarte;

package EinheitInUmgebungLogik is
   pragma Elaborate_Body;

   procedure EinheitInUmgebung;
   
private
      
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   AndereEinheit : EinheitenRecords.RasseEinheitnummerRecord;
   
   procedure UmgebungStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure UmgebungEinheit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function EinheitFinden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      UmgebungExtern : in KartenDatentypen.Sichtweite;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end EinheitInUmgebungLogik;
