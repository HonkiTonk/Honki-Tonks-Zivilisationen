pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package BefehleImSpiel is

   function Befehle
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return Integer
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1),
         Post =>
           (Befehle'Result in -1_000 .. 5);

private

   Wahl : Boolean;
   Nullwert : Boolean;
   Transportiert : Boolean;
         
   Befehl : Wide_Wide_Character;

   EinheitNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   EinheitTransportNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   StadtNummer : GlobaleDatentypen.MaximaleStädteMitNullWert;
   
   WelcherBefehl : Positive;
   StadtOderEinheit : Integer;
   WahlForschung : Integer;
   MenüAufruf : Integer;
   AbreißenAuswahl : Integer;
   
   StadtSuchenNachNamen : GlobaleRecords.RassePlatznummerRecord;

   procedure EinheitOderStadt
     (RasseExtern : in GlobaleDatentypen.Rassen;
      AuswahlExtern : in Integer;
      StadtNummerExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
   
end BefehleImSpiel;
