pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package BefehleImSpiel is

   function Befehle (RasseExtern : in GlobaleDatentypen.Rassen) return Integer;

private

   Wahl : Boolean;
   Nullwert : Boolean;
         
   Taste : Wide_Wide_Character;

   EinheitNummer : Integer;
   StadtNummer : Integer;
   WelcherBefehl : Integer;
   StadtOderEinheit : Integer;
   WahlForschung : Integer;

   procedure EinheitOderStadt (RasseExtern : GlobaleDatentypen.Rassen; Auswahl, StadtNummer, EinheitNummer : in Integer) with
     Pre => StadtNummer in GlobaleVariablen.StadtGebaut'Range (2) and EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2);
   
end BefehleImSpiel;
