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

   Transportiert : Boolean;
   
   Befehl : GlobaleDatentypen.Tastenbelegung_Enum;

   EinheitNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   EinheitTransportNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   StadtNummer : GlobaleDatentypen.MaximaleStädteMitNullWert;
   
   WelcherBefehl : Positive;
   StadtOderEinheit : Integer;
   AbreißenAuswahl : Integer;
   
   StadtSuchenNachNamen : GlobaleRecords.RassePlatznummerRecord;
   
   procedure AuswahlEinheitStadt
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

   procedure EinheitOderStadt
     (RasseExtern : in GlobaleDatentypen.Rassen;
      AuswahlExtern : in Integer;
      StadtNummerExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
   
   procedure BaueStadt
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
   
   procedure Technologie
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
   
   procedure EinheitBefehle
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
   
   procedure StadtUmbenennen
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
   
   procedure StadtAbreißen
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);
   
end BefehleImSpiel;
