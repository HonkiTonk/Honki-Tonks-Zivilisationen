pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with RueckgabeDatentypen;
with EinheitenRecords;
with SpielVariablen;
with SystemDatentypen;

package DebugmenueSFML is

   procedure Debugmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_Mensch_Enum);

   procedure KarteInfosEinheiten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze);

private

   RückgabeDebugmenü : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   procedure KarteAufdecken
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_Mensch_Enum);

   procedure DiplomatischenStatusÄndern
     (NeuerStatusExtern : in SystemDatentypen.Status_Untereinander_Enum);

end DebugmenueSFML;
