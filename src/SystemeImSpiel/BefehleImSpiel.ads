pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package BefehleImSpiel is

   function Befehle
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return Integer
     with
       Pre  => (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1),
       Post => (Befehle'Result in -1_000 .. 5);

private

   Wahl : Boolean;
   Nullwert : Boolean;
   Transportiert : Boolean;
         
   Taste : Wide_Wide_Character;

   EinheitNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   EinheitTransportNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   StadtNummer : GlobaleDatentypen.MaximaleStädteMitNullWert;
   
   WelcherBefehl : Integer;
   StadtOderEinheit : Integer;
   WahlForschung : Integer;

   procedure EinheitOderStadt
     (RasseExtern : in GlobaleDatentypen.Rassen;
      AuswahlExtern : in Integer;
      StadtNummerExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
     with
       Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
   
end BefehleImSpiel;
