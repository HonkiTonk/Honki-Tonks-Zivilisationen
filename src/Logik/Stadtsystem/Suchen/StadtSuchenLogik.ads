with KartenDatentypen;
with SpeziesDatentypen;
with StadtDatentypen;
with KartenRecords;
with StadtRecords;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

private with SystemRecords;

package StadtSuchenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;
   use type StadtDatentypen.MaximaleStädteMitNullWert;
   
   function KoordinatenStadtMitSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
                      
       Post => (
                  KoordinatenStadtMitSpeziesSuchen'Result <= LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)
               );
   
   function KoordinatenStadtOhneSpeziesSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.SpeziesStadtnummerRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   function KoordinatenStadtOhneSpezielleSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.SpeziesStadtnummerRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure StadtNachNamenSuchen;
   
private
      
   StadtName : SystemRecords.TextEingabeRecord;
   
   Stadt : StadtRecords.SpeziesStadtnummerRecord;

end StadtSuchenLogik;
