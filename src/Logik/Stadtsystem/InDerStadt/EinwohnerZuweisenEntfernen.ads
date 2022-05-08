pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with SpielVariablen;
with KartenRecords;
with KartenDatentypen;
with SonstigeVariablen;

package EinwohnerZuweisenEntfernen is

   procedure EinwohnerZuweisenEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = RassenDatentypen.Spieler_Mensch_Enum);
   
private
   
   NutzbarerBereich : KartenDatentypen.Kartenfeld;
   RelativeCursorPositionY : KartenDatentypen.Kartenfeld;
   RelativeCursorPositionX : KartenDatentypen.Kartenfeld;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure EinwohnerBelegungÄndern
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);
   
   procedure EinwohnerEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);
   
   procedure EinwohnerZuweisen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord);

end EinwohnerZuweisenEntfernen;
