with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;
with EinheitenDatentypen;

private with KartenRecords;
private with KartenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package EinheitentransporterLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.EinheitenbereichBasis;
   
   procedure TransporterEntladen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 TransporterExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => TransporterExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => TransporterExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure LadungsnummerAnpassen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LadungsnummerAltExtern : in EinheitenDatentypen.EinheitenbereichVorhanden;
      LadungsnummerNeuExtern : in EinheitenDatentypen.EinheitenbereichBasis)
     with
       Pre => (
                 TransporterExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => TransporterExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => TransporterExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LadungsnummerAltExtern <= LeseGrenzen.Einheitengrenze (SpeziesExtern => TransporterExtern.Spezies)
               and
                 LadungsnummerNeuExtern <= LeseGrenzen.Einheitengrenze (SpeziesExtern => TransporterExtern.Spezies)
              );
   
   procedure LadungAnpassen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 TransporterExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => TransporterExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => TransporterExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
     
     
   
   function TransporterGroßGenug
     (LadungExtern : in EinheitenDatentypen.EinheitenIDBasis;
      TransporterExtern : in EinheitenDatentypen.EinheitenIDBasis;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function KannTransportiertWerden
     (LadungExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 LadungExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => LadungExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => LadungExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 TransporterExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => TransporterExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => TransporterExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function BelegtePlätze
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TransportkapazitätExtern : in EinheitenDatentypen.TransportplätzeBasis)
      return EinheitenDatentypen.TransportplätzeBasis
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   use type KartenDatentypen.SenkrechteBasis;
   use type KartenDatentypen.WaagerechteBasis;
   
   Transporterkapazität : EinheitenDatentypen.TransportplätzeBasis;
   AktuelleLadungsmenge : EinheitenDatentypen.TransportplätzeBasis;
   
   TransporterID : EinheitenDatentypen.EinheitenIDBasis;
   LadungID : EinheitenDatentypen.EinheitenIDBasis;
   
   AktuelleLadung : EinheitenDatentypen.EinheitenbereichBasis;
   
   EinheitVorhanden : EinheitenRecords.SpeziesEinheitnummerRecord;
   
   TransporterKoordinaten : KartenRecords.KartenfeldNaturalRecord;
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   
   procedure TransporterUmgebung
     (TranspoterKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      LadungExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 LadungExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => LadungExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => LadungExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 TranspoterKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 TranspoterKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   
   
   function Entladung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      LadungExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
                  return Boolean
     with
       Pre => (
                 LadungExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => LadungExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => LadungExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

end EinheitentransporterLogik;
