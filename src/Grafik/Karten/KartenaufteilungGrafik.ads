private with Sf.System.Vector2;

with RassenDatentypen;
with EinheitenDatentypen;
with EinheitenRecords;
with SpielVariablen;
with StadtRecords;

with LeseGrenzen;
with LeseRassenbelegung;

package KartenaufteilungGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   procedure Weltkarte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer <= LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure Stadtkarte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   RechtsLinksBefehlsanzeige : Boolean;
   
   Position : Sf.System.Vector2.sfVector2f;

end KartenaufteilungGrafik;
