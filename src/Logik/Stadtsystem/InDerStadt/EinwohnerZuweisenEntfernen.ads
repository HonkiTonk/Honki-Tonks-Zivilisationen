pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with KartenRecords;
with KartenDatentypen;
with SonstigeVariablen;
with StadtRecords;

package EinwohnerZuweisenEntfernen is

   procedure EinwohnerZuweisenEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   NutzbarerBereich : KartenDatentypen.Kartenfeld;
   RelativeCursorPositionY : KartenDatentypen.Kartenfeld;
   RelativeCursorPositionX : KartenDatentypen.Kartenfeld;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure EinwohnerBelegungÄndern
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure EinwohnerEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure EinwohnerZuweisen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
               and
                 SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

end EinwohnerZuweisenEntfernen;
