pragma SPARK_Mode (On);

with SonstigeDatentypen, GlobaleVariablen, EinheitStadtRecords, KartenRecords, EinheitStadtDatentypen;
use SonstigeDatentypen;

package InDerStadtBauen is

   procedure Bauen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_Mensch);

private

   Ende : EinheitStadtDatentypen.MinimimMaximumID;

   WasGebautWerdenSoll : Natural;
   Befehl : Natural;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

   procedure MöglicheGebäudeErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

   procedure MöglicheEinheitenErmitteln
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);



   function BauobjektAuswählen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SonstigeDatentypen.Spieler_Mensch),
         Post =>
           (BauobjektAuswählen'Result <= 99_999);

   function AuswahlBauprojekt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Natural;

end InDerStadtBauen;
