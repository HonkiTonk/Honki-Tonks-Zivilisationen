pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package InDerStadtBauen is

   procedure Bauen (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = 1));

   procedure BauzeitEinzeln (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= 0));

   procedure BauzeitAlle;

private

   type RassenAufschlagArray is array (GlobaleDatentypen.Rassen'Range) of Natural;
   RassenAufschlagGebäude : constant RassenAufschlagArray := (1 => 0,
                                                               2 => 0,
                                                               3 => 0,
                                                               4 => 0,
                                                               5 => 0,
                                                               6 => 0,
                                                               7 => 0,
                                                               8 => 0,
                                                               9 => 0,
                                                               10 => 0,
                                                               11 => 0,
                                                               12 => 0,
                                                               13 => 0,
                                                               14 => 0,
                                                               15 => 0,
                                                               16 => 0,
                                                               17 => 0,
                                                               18 => 0);

   RassenAufschlagEinheiten : constant RassenAufschlagArray := (1 => 0,
                                                                2 => 0,
                                                                3 => 0,
                                                                4 => 0,
                                                                5 => 0,
                                                                6 => 0,
                                                                7 => 0,
                                                                8 => 0,
                                                                9 => 0,
                                                                10 => 0,
                                                                11 => 0,
                                                                12 => 0,
                                                                13 => 0,
                                                                14 => 0,
                                                                15 => 0,
                                                                16 => 0,
                                                                17 => 0,
                                                                18 => 0);

   Taste : Wide_Wide_Character;

   AktuelleAuswahl : GlobaleDatentypen.KartenverbesserungEinheitenID;
   Ende : GlobaleDatentypen.KartenverbesserungEinheitenID;

   WasGebautWerdenSoll : Natural;

   function BauobjektAuswählen (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Natural with
     Pre  => (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummerExtern.Rasse in GlobaleDatentypen.Rassen
              and (if StadtRasseNummerExtern.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = 1)),
     Post => (BauobjektAuswählen'Result <= 99_999);

end InDerStadtBauen;
