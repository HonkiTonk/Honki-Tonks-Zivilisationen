with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenDatentypen;
with StadtRecords;
with EinheitenKonstanten;
with ProduktionDatentypen;

private with StadtDatentypen;
private with AufgabenDatentypen;
private with KampfDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with KIDatentypen;

package EinheitenmodifizierungLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type ProduktionDatentypen.Produktion;

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
      VorzeichenwechselExtern : in ProduktionDatentypen.Vorzeichenwechsel)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 VorzeichenwechselExtern /= 0
              );

private
   
   Feldeffekt : Boolean;
   
   AktuelleID : EinheitenDatentypen.EinheitenIDVorhanden;
   EinheitID : EinheitenDatentypen.EinheitenIDVorhanden;
   
   AktuelleBeschäftigung : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   
   KIBeschäftigung : KIDatentypen.Einheit_Aufgabe_Enum;
   
   Heimatstadt : StadtDatentypen.MaximaleStädteMitNullWert;
   
   Heilungsrate : constant KampfDatentypen.LebenspunkteVorhanden := 10;
         
   NeueHeimatstadt : StadtRecords.SpeziesStadtnummerRecord;
   
   EinheitNummer : EinheitenDatentypen.Einheitenbereich;

end EinheitenmodifizierungLogik;
