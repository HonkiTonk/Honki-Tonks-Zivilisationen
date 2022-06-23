pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO;

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
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure KarteInfosEinheiten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
              );

private

   RückgabeDebugmenü : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   WelcherText : Positive;

   Zwischenzeit : Float;
   Gesamtzeit : Float;

   procedure KarteAufdecken
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure DiplomatischenStatusÄndern
     (NeuerStatusExtern : in SystemDatentypen.Status_Untereinander_Enum);

   procedure LadezeitenAnzegien;

   package AnzeigeFloat is new Ada.Wide_Wide_Text_IO.Float_IO (Float);

end DebugmenueSFML;
