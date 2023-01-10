with KartenDatentypen;
with SpeziesDatentypen;
with EinheitenDatentypen;
with KartenRecords;
with EinheitenRecords;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package EinheitSuchenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Kartenfeld;
   use type SpeziesDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;

   function KoordinatenEinheitMitSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
                      
       Post => (
                  KoordinatenEinheitMitSpeziesSuchen'Result <= LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
               );

   function KoordinatenEinheitOhneSpeziesSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenRecords.SpeziesEinheitnummerRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );

   function KoordinatenEinheitOhneSpezielleSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenRecords.SpeziesEinheitnummerRecord
     with
       Pre => (
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function TransporterladungSuchen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LadungsnummerExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
      return Boolean;
   
private
   
   Transporterkapazität : EinheitenDatentypen.Transportplätze;
   
   type TransporternummerArray is array (Boolean'Range) of EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   Transporternummer : TransporternummerArray;
   
   type EinheitArray is array (Boolean'Range) of EinheitenRecords.SpeziesEinheitnummerRecord;
   Einheit : EinheitArray;
   
   
   
   function TransporterverschachtelungDurchgehen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenRecords.SpeziesEinheitnummerRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
end EinheitSuchenLogik;
