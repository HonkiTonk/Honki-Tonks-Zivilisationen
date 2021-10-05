pragma SPARK_Mode (On);

with SystemDatentypen, GlobaleVariablen, EinheitStadtRecords, SystemKonstanten, SonstigeDatentypen, EinheitStadtDatentypen;
use SystemDatentypen, SonstigeDatentypen, EinheitStadtDatentypen;

package BefehleImSpiel is

   function Befehle
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Integer
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch),
         Post =>
           (Befehle'Result in SystemKonstanten.RundeBeendenKonstante .. 5);

private

   Transportiert : Boolean;
   AufgabeDurchführen : Boolean;
   NullWert : Boolean;
   
   Befehl : SystemDatentypen.Tastenbelegung_Enum;

   EinheitNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   EinheitTransportNummer : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   StadtNummer : EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   
   StadtOderEinheit : Integer;
   
   StadtSuchenNachNamen : EinheitStadtRecords.RassePlatznummerRecord;
   
   procedure AuswahlEinheitStadt
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);

   procedure EinheitOderStadt
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      AuswahlExtern : in Integer;
      StadtNummerExtern : in EinheitStadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitStadtDatentypen.MaximaleEinheitenMitNullWert);
   
   procedure BaueStadt
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure Technologie
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure EinheitBefehle
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      BefehlExtern : in SystemDatentypen.Tastenbelegung_Befehle_Enum);
   
   procedure StadtUmbenennen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure StadtAbreißen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);
   
   procedure AuswahlEinheitTransporter
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure StadtBetreten
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure EinheitSteuern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
end BefehleImSpiel;
