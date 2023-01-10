with SpeziesDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;

private with EinheitenRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package AuswahlStadtEinheitLogik is
   pragma Elaborate_Body;
   use type StadtDatentypen.MaximaleStädteMitNullWert;
   use type SpeziesDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   function AuswahlStadtEinheit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      StadtNummerExtern : in StadtDatentypen.MaximaleStädteMitNullWert;
      EinheitNummerExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return Integer
     with
       Pre => (
                 StadtNummerExtern <= LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)
               and
                 EinheitNummerExtern <= LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
         
   AktuelleAuswahl : Integer;
   
   WelcheAuswahl : EinheitenRecords.AuswahlRecord;

end AuswahlStadtEinheitLogik;
