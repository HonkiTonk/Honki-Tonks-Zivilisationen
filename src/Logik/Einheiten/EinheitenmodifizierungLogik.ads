with SpeziesDatentypen;
with KartenDatentypen;
with EinheitenRecords;
with EinheitenDatentypen;
with StadtRecords;
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

   procedure HeilungBewegungspunkteNeueRunde
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
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

end EinheitenmodifizierungLogik;
