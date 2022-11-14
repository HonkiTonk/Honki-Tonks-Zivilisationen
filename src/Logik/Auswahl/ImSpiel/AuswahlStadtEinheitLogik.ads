with RassenDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with SpielVariablen;

private with EinheitenRecords;

package AuswahlStadtEinheitLogik is
   pragma Elaborate_Body;
   use type StadtDatentypen.MaximaleStädteMitNullWert;
   use type RassenDatentypen.Spieler_Enum;
   
   function AuswahlStadtEinheit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtNummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
      return Integer
     with
       Pre => (
                 StadtNummerExtern <= SpielVariablen.Grenzen (RasseExtern).Städtegrenze
               and
                 EinheitNummerExtern in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
         
   AktuelleAuswahl : Integer;
   
   WelcheAuswahl : EinheitenRecords.AuswahlRecord;

end AuswahlStadtEinheitLogik;
