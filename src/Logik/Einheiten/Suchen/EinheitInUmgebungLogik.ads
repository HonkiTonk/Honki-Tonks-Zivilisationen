private with RassenDatentypen;
private with KartenDatentypen;
private with EinheitenRecords;
private with KartenRecords;

private with LeseRassenbelegung;
private with LeseWeltkarteneinstellungen;

package EinheitInUmgebungLogik is
   pragma Elaborate_Body;

   procedure EinheitInUmgebung;
   
private
   use type RassenDatentypen.Rassen_Enum;
   use type KartenDatentypen.Kartenfeld;
   use type RassenDatentypen.Spieler_Enum;
      
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   AndereEinheit : EinheitenRecords.RasseEinheitnummerRecord;
   
   procedure UmgebungStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure UmgebungEinheit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function EinheitFinden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      UmgebungExtern : in KartenDatentypen.Sichtweite;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

end EinheitInUmgebungLogik;
