pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with SpielVariablen;
with SonstigeVariablen;
with ProduktionDatentypen;

with KIDatentypen;

package KIAufgabenPlanung is
   
   procedure AufgabeErmitteln
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   procedure AufgabeUmsetzen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
private
      
   AufgabeDurchführen : Boolean;
      
   GewählteAufgabe : KIDatentypen.Einheit_Aufgabe_Enum;
   
   type WichtigkeitArray is array (KIDatentypen.Einheit_Aufgabe_Enum'Range) of ProduktionDatentypen.ProduktionSonstiges;
   Wichtigkeit : WichtigkeitArray;
   
   procedure AufgabeFestlegen
     (GewählteAufgabeExtern : in KIDatentypen.Einheit_Aufgabe_Enum;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_KI_Enum);
   
   procedure EinheitSpezifischeAufgabenErmitteln
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);
   
   procedure AufgabenSortieren;
   
end KIAufgabenPlanung;
