with SpeziesDatentypen;
with EinheitenDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with KartenRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package TransporterBeladenEntladenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   function IstTransporterBeladbar
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 TransporterExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => TransporterExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => TransporterExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function TransporterBeladen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
      return Boolean
     with
       Pre => (
                 TransporterExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => TransporterExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => TransporterExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure EinheitAusladen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
     with
       Pre => (
                 TransporterExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => TransporterExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => TransporterExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure LadungSortieren
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 TransporterExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => TransporterExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => TransporterExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   AlterTransporter : EinheitenDatentypen.Einheitenbereich;
   
   FreierPlatzNummer : EinheitenDatentypen.Transportplätze;
   Transporterkapazität : EinheitenDatentypen.Transportplätze;
   
   NeueKoordinaten : KartenRecords.KartenfeldNaturalRecord;

end TransporterBeladenEntladenLogik;
