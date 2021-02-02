with GlobaleDatentypen;
use GlobaleDatentypen;

package BefehleImSpiel is

   function Befehle (RasseExtern : in GlobaleDatentypen.Rassen) return Integer;

private

   Wahl : Boolean;
   Nullwert : Boolean;
         
   Taste : Wide_Wide_Character;

   WertEinheit : Integer;
   WertStadt : Integer;
   WelcherBefehl : Integer;
   StadtOderEinheit : Integer;
   WahlForschung : Integer;

   procedure EinheitOderStadt (RasseExtern : GlobaleDatentypen.Rassen; Auswahl, StadtNummer, EinheitNummer : in Integer);
   
end BefehleImSpiel;
