pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, EinheitStadtRecords, SystemKonstanten;
use GlobaleDatentypen;

package BefehleImSpiel is

   function Befehle
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_Mensch),
         Post =>
           (Befehle'Result in SystemKonstanten.RundeBeendenKonstante .. 5);

private

   Transportiert : Boolean;
   AufgabeDurchführen : Boolean;
   NullWert : Boolean;
   
   Befehl : GlobaleDatentypen.Tastenbelegung_Enum;

   EinheitNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   EinheitTransportNummer : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   StadtNummer : GlobaleDatentypen.MaximaleStädteMitNullWert;
   
   StadtOderEinheit : Integer;
   
   StadtSuchenNachNamen : EinheitStadtRecords.RassePlatznummerRecord;
   
   procedure AuswahlEinheitStadt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);

   procedure EinheitOderStadt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      AuswahlExtern : in Integer;
      StadtNummerExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in GlobaleDatentypen.MaximaleEinheitenMitNullWert);
   
   procedure BaueStadt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure Technologie
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure EinheitBefehle
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      BefehlExtern : in GlobaleDatentypen.Tastenbelegung_Befehle_Enum);
   
   procedure StadtUmbenennen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure StadtAbreißen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);
   
   procedure AuswahlEinheitTransporter
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure StadtBetreten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure EinheitSteuern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
end BefehleImSpiel;
