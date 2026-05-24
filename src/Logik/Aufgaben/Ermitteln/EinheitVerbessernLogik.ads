with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;
with EinheitenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

package EinheitVerbessernLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function VerbesserungEinheit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function EinheitVerbesserbar
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.EinheitenIDBasis
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   AktuelleTransporterkapazität : EinheitenDatentypen.TransportplätzeBasis;
   NeueTransporterkapazität : EinheitenDatentypen.TransportplätzeBasis;
   
   NeueEinheitenID : EinheitenDatentypen.EinheitenIDBasis;
   EinheitenIDVerbesserbar : EinheitenDatentypen.EinheitenIDBasis;
   
   Transporternummer : EinheitenDatentypen.EinheitenbereichBasis;
   
   
   
   function WeiterhinTransportierbar
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueIDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function LaderaumAusreichend
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueIDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end EinheitVerbessernLogik;
