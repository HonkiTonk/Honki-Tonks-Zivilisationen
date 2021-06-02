pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package StadtBauen is

   procedure StadtEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2)
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) > 0);

   procedure StadtBauen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);



   function StadtBauenPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);

   function ErweitertesStadtBauenPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);

private

   Stadtart : GlobaleDatentypen.StadtID;

   StadtNummer : GlobaleDatentypen.MaximaleStädte;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;

   type KIStadtNameArray is array (GlobaleDatentypen.Rassen'Range, 1 .. GlobaleVariablen.StadtGebautArray'Last (2) * 2) of Natural;
   KIStadtName : KIStadtNameArray := (others => (others => 0));

   procedure AmWasser
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer >= GlobaleVariablen.EinheitenGebaut'First (2)
          and
            GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) > 0);



   function HauptstadtPrüfen
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.StadtID
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) > 0),
       Post =>
         (HauptstadtPrüfen'Result > 0);

end StadtBauen;
