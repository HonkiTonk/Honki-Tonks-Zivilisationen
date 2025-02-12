private with SystemRecordsHTSEB;

with KartenDatentypen;
with SpeziesDatentypen;
with StadtDatentypen;
with KartenRecords;
with StadtRecords;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package StadtSuchenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   use type StadtDatentypen.Städtebereich;
   
   function KoordinatenStadtMitSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return StadtDatentypen.Städtebereich
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
                      
       Post => (
                  KoordinatenStadtMitSpeziesSuchen'Result <= LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)
               );
   
   function KoordinatenStadtOhneSpeziesSuchen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return StadtRecords.SpeziesStadtnummerRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function KoordinatenStadtOhneSpezielleSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return StadtRecords.SpeziesStadtnummerRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure StadtNachNamenSuchen;
   
private
      
   StadtName : SystemRecordsHTSEB.TextEingabeRecord;
   
   Stadt : StadtRecords.SpeziesStadtnummerRecord;

end StadtSuchenLogik;
