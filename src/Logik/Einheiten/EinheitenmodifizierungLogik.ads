with SpeziesDatentypen;
with KartenDatentypen;
with EinheitenRecords;
with EinheitenDatentypen;
with StadtRecords;
with StadtKonstanten;
with EinheitenKonstanten;

private with StadtDatentypen;
private with AufgabenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with KIDatentypen;

package EinheitenmodifizierungLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   procedure HeilungBewegungspunkteNeueRundeErmitteln
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure HeimatstadtÄndern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   procedure PermanenteKostenÄndern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      VorzeichenWechselExtern : in KartenDatentypen.UmgebungsbereichEins)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 VorzeichenWechselExtern /= 0
              );
   
   
   
   function EinheitAnforderungenErfüllt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

private
   
   Feldeffekt : Boolean;
   
   AktuelleID : EinheitenDatentypen.EinheitenID;
   EinheitID : EinheitenDatentypen.EinheitenID;
   
   AktuelleBeschäftigung : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   
   KIBeschäftigung : KIDatentypen.Einheit_Aufgabe_Enum;
   
   Heimatstadt : StadtDatentypen.MaximaleStädteMitNullWert;
   
   Heilungsrate : constant EinheitenDatentypen.VorhandeneLebenspunkte := 10;
         
   NeueHeimatstadt : StadtRecords.SpeziesStadtnummerRecord;
   
   EinheitNummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;

   procedure HeilungBewegungspunkteNeueRundeSetzen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end EinheitenmodifizierungLogik;
