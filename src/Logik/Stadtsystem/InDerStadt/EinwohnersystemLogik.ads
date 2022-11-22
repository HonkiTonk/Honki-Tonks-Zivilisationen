private with Sf.System.Vector2;

with RassenDatentypen;
with SpielVariablen;
with StadtRecords;

private with KartenRecords;
private with KartenDatentypen;

with LeseGrenzen;
with LeseRassenbelegung;

package EinwohnersystemLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function EinwohnerZuweisenEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
      
   Stadtfeld : KartenRecords.YXAchsenKartenfeldRecord;
   
   Mausposition : Sf.System.Vector2.sfVector2f;
   
   Kartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure EinwohnerBelegungÄndern
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure EinwohnerEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure EinwohnerZuweisen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

end EinwohnersystemLogik;
