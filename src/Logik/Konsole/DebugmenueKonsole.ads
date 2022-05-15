pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with EinheitenRecords;
with SpielVariablen;
with StadtRecords;

package DebugmenueKonsole is

   DebugSieg : Boolean := False;
   FeindlicheInformationenSehen : Boolean := False;
   
   procedure Menü
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
   
   procedure KarteInfosFeld
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_Mensch_Enum);
   
   procedure KarteStadtInfos
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze);
   
private
   
   ErsteAnzeige : Boolean;

   procedure Informationen;

end DebugmenueKonsole;
