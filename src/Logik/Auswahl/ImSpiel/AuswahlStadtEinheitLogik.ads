with SpeziesDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;

private with EinheitenRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package AuswahlStadtEinheitLogik is
   pragma Elaborate_Body;
   use type StadtDatentypen.Städtebereich;
   use type SpeziesDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.Einheitenbereich;
   
   function AuswahlStadtEinheit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      StadtnummerExtern : in StadtDatentypen.Städtebereich;
      EinheitNummerExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
      return Integer
     with
       Pre => (
                 StadtnummerExtern <= LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)
               and
                 EinheitNummerExtern <= LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
         
   AktuelleAuswahl : Integer;
   
   WelcheAuswahl : EinheitenRecords.AuswahlRecord;

end AuswahlStadtEinheitLogik;
