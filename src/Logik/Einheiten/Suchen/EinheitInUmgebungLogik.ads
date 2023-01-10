private with SpeziesDatentypen;
private with KartenDatentypen;
private with EinheitenRecords;
private with KartenRecords;

private with LeseSpeziesbelegung;
private with LeseWeltkarteneinstellungen;

package EinheitInUmgebungLogik is
   pragma Elaborate_Body;

   procedure EinheitInUmgebung;
   
private
   use type SpeziesDatentypen.Spezies_Enum;
   use type KartenDatentypen.Kartenfeld;
   use type SpeziesDatentypen.Spieler_Enum;
      
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   AndereEinheit : EinheitenRecords.SpeziesEinheitnummerRecord;
   
   procedure UmgebungStadt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure UmgebungEinheit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function EinheitFinden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      UmgebungExtern : in KartenDatentypen.Sichtweite;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end EinheitInUmgebungLogik;
