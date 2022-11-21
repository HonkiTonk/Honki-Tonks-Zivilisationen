with KartenDatentypen;
with RassenDatentypen;
with StadtDatentypen;
with KartenRecords;
with StadtRecords;
with SpielVariablen;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;

private with SystemRecords;

package StadtSuchenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   use type StadtDatentypen.MaximaleStädteMitNullWert;
   
   function KoordinatenStadtMitRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              ),
                      
       Post => (
                  KoordinatenStadtMitRasseSuchen'Result <= LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern)
               );
   
   function KoordinatenStadtOhneRasseSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.RasseStadtnummerRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   function KoordinatenStadtOhneSpezielleRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.RasseStadtnummerRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure StadtNachNamenSuchen;
   
private
      
   StadtName : SystemRecords.TextEingabeRecord;
   
   Stadt : StadtRecords.RasseStadtnummerRecord;

end StadtSuchenLogik;
