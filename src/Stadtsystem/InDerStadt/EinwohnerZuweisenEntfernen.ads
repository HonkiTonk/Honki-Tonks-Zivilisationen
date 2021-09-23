pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package EinwohnerZuweisenEntfernen is

   procedure EinwohnerZuweisenEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch);
   
private
   
   NutzbarerBereich : GlobaleDatentypen.Kartenfeld;
   RelativeCursorPositionY : GlobaleDatentypen.Kartenfeld;
   RelativeCursorPositionX : GlobaleDatentypen.Kartenfeld;
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;
   
   procedure EinwohnerBelegungÄndern
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure EinwohnerEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);
   
   procedure EinwohnerZuweisen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);

end EinwohnerZuweisenEntfernen;
