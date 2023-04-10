with SpeziesDatentypen;
with StadtDatentypen;
with StadtRecords;
with EinheitenRecords;
with EinheitenDatentypen;
with StadtKonstanten;
with EinheitenKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

package MeldungenSetzenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure MeldungenRundenende
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure StadtmeldungSetzen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EreignisExtern : in StadtDatentypen.Stadt_Meldungen_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
              );
   
   procedure EinheitmeldungSetzen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      EreignisExtern : in EinheitenDatentypen.Einheit_Meldung_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
              );
   
private
   
   StadtMeldung : StadtDatentypen.Stadt_Meldung_Art_Enum;
   
   EinheitMeldung : EinheitenDatentypen.Einheit_Meldung_Art_Enum;

end MeldungenSetzenLogik;
