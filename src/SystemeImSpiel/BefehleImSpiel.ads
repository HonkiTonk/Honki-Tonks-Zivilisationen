pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package BefehleImSpiel is

   function Befehle (RasseExtern : in GlobaleDatentypen.Rassen) return Integer with
     Pre  => (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1),
     Post => (Befehle'Result in -1_000 .. 5);

private

   Wahl : Boolean;
   Nullwert : Boolean;
         
   Taste : Wide_Wide_Character;

   EinheitNummer : Natural;
   StadtNummer : Natural;
   
   WelcherBefehl : Integer;
   StadtOderEinheit : Integer;
   WahlForschung : Integer;

   procedure EinheitOderStadt (RasseExtern : in GlobaleDatentypen.Rassen; Auswahl : in Integer; StadtNummer, EinheitNummer : in Natural) with
     Pre => (StadtNummer <= GlobaleVariablen.StadtGebaut'Last (2) and EinheitNummer <= GlobaleVariablen.EinheitenGebaut'Last (2) and GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
   
end BefehleImSpiel;
