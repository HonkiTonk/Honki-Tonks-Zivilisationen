with RassenDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with SpielVariablen;

private with EinheitenRecords;

with LeseGrenzen;

package AuswahlStadtEinheitLogik is
   pragma Elaborate_Body;
   use type StadtDatentypen.MaximaleStädteMitNullWert;
   use type RassenDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   function AuswahlStadtEinheit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StadtNummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return Integer
     with
       Pre => (
                 StadtNummerExtern <= LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern)
               and
                 EinheitNummerExtern <= LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern)
               and
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
private
         
   AktuelleAuswahl : Integer;
   
   WelcheAuswahl : EinheitenRecords.AuswahlRecord;

end AuswahlStadtEinheitLogik;
