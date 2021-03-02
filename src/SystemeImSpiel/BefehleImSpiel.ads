pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package BefehleImSpiel is

   function Befehle (RasseExtern : in GlobaleDatentypen.Rassen) return Integer with
     Pre  => (RasseExtern in GlobaleDatentypen.Rassen'Range and GlobaleVariablen.RassenImSpiel (RasseExtern) = 1),
     Post => (Befehle'Result in -1_000 .. 1);

private

   Wahl : Boolean;
   Nullwert : Boolean;
         
   Taste : Wide_Wide_Character;

   EinheitNummer : Integer;
   StadtNummer : Integer;
   WelcherBefehl : Integer;
   StadtOderEinheit : Integer;
   WahlForschung : Integer;

   procedure EinheitOderStadt (RasseExtern : in GlobaleDatentypen.Rassen; Auswahl, StadtNummer, EinheitNummer : in Integer) with
     Pre => (StadtNummer in GlobaleVariablen.StadtGebaut'Range (2) and EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) and GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
   
end BefehleImSpiel;
