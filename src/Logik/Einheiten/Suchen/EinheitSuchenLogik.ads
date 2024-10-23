with KartenDatentypen;
with SpeziesDatentypen;
with EinheitenDatentypen;
with KartenRecords;
with EinheitenRecords;
with SystemDatentypen;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package EinheitSuchenLogik is
   pragma Elaborate_Body;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   use type SpeziesDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.Einheitenbereich;

   function KoordinatenEinheitMitSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return EinheitenDatentypen.Einheitenbereich
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
                      
       Post => (
                  KoordinatenEinheitMitSpeziesSuchen'Result <= LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
               );

   function KoordinatenEinheitOhneSpeziesSuchen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return EinheitenRecords.SpeziesEinheitnummerRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function KoordinatenEinheitOhneSpezielleSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return EinheitenRecords.SpeziesEinheitnummerRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function TransporterladungSuchen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LadungsnummerExtern : in EinheitenDatentypen.Einheitenbereich)
      return Boolean;
   
private
   
   Transporterkapazität : EinheitenDatentypen.Transportplätze;
   
   type TransporternummerArray is array (SystemDatentypen.Task_Enum'Range) of EinheitenDatentypen.Einheitenbereich;
   Transporternummer : TransporternummerArray;
   
   type EinheitArray is array (SystemDatentypen.Task_Enum'Range) of EinheitenRecords.SpeziesEinheitnummerRecord;
   Einheit : EinheitArray;
   
   
   
   function TransporterverschachtelungDurchgehen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return EinheitenRecords.SpeziesEinheitnummerRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
end EinheitSuchenLogik;
