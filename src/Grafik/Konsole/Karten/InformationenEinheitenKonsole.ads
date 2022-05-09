pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO;

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;
with EinheitenDatentypen;
with SonstigeVariablen;

package InformationenEinheitenKonsole is

   procedure Einheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
private
   
   ErsteAnzeige : Boolean;
   
   IDEinheit : EinheitenDatentypen.EinheitenID;
   
   EinheitNummer : EinheitenDatentypen.MaximaleEinheiten;
   
   PlatzhalterText : Wide_Wide_String (1 .. 1);
   
   EinheitRasseNummer : EinheitenRecords.RasseEinheitnummerRecord;
   
   function Allgemeines
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenRecords.RasseEinheitnummerRecord;
   
   procedure Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord);
   
   procedure Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord);
   
   procedure Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord);
   
   procedure Beschäftigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord);
   
   procedure Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord);
   
   procedure Angriff
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord);
   
   procedure Verteidigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord);
   
   procedure Rang
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord);
   
   procedure Heimatstadt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord);
   
   procedure AktuelleVerteidigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord);
   
   procedure AktuellerAngriff
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord);
   
   procedure Ladung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord);
   
   procedure DebugInformationen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord);
   
   package AnzeigeBewegungFloat is new Ada.Wide_Wide_Text_IO.Float_IO (EinheitenDatentypen.VorhandeneBewegungspunkte);

end InformationenEinheitenKonsole;
