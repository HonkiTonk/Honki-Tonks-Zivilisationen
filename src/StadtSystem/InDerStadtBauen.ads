pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package InDerStadtBauen is

   procedure Bauen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) = 1));

   procedure BauzeitEinzeln (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) /= 0));

   procedure BauzeitAlle;

private



   Taste : Wide_Wide_Character;

   WasGebautWerdenSoll : Natural;
   Ende : Positive;
   AktuelleAuswahl : Positive := 1;

   function BauobjektAuswählen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Natural with
     Pre  => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) = 1)),
     Post => (BauobjektAuswählen'Result in 0 .. 99_999);

   function AuswahlStadt (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Natural with
     Pre => (StadtRasseNummer.Platznummer in GlobaleVariablen.StadtGebaut'Range (2) and StadtRasseNummer.Rasse in GlobaleDatentypen.Rassen
             and (if StadtRasseNummer.Rasse > 0 then GlobaleVariablen.RassenImSpiel (StadtRasseNummer.Rasse) = 1));

end InDerStadtBauen;
