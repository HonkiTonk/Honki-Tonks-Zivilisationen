with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with EinheitenRecords;
with EinheitenDatentypen;
with SpielVariablen;
with StadtRecords;

private with StadtDatentypen;
private with AufgabenDatentypen;

private with KIDatentypen;

package EinheitenmodifizierungLogik is
   pragma Elaborate_Body;

   procedure HeilungBewegungspunkteNeueRundeErmitteln;
   
   procedure HeimatstadtÄndern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure PermanenteKostenÄndern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      VorzeichenWechselExtern : in KartenDatentypen.UmgebungsbereichEins)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 VorzeichenWechselExtern /= 0
              );
   
   
   
   function EinheitAnforderungenErfüllt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

private
   
   AktuelleID : EinheitenDatentypen.EinheitenID;
   EinheitID : EinheitenDatentypen.EinheitenID;
   
   AktuelleBeschäftigung : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   
   KIBeschäftigung : KIDatentypen.Einheit_Aufgabe_Enum;
   
   Heimatstadt : StadtDatentypen.MaximaleStädteMitNullWert;
   
   Heilungsrate : constant EinheitenDatentypen.VorhandeneLebenspunkte := 10;
      
   NeueHeimatstadt : StadtRecords.RasseStadtnummerRecord;
   
   EinheitNummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;

   procedure HeilungBewegungspunkteNeueRundeSetzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end EinheitenmodifizierungLogik;
