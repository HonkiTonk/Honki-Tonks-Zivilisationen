pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen, GlobaleRecords;
use GlobaleDatentypen;

package InDerStadtBauen is

   procedure Bauen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch);

private

   PermanenteGebäudeWerte : Boolean;

   AktuelleAuswahl : GlobaleDatentypen.KartenverbesserungEinheitenID;
   Ende : GlobaleDatentypen.KartenverbesserungEinheitenID;

   WasGebautWerdenSoll : Natural;
   Befehl : Natural;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;

   procedure AnzeigeEinheiten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);

   procedure AnzeigeGebäude
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);

   procedure MöglicheGebäudeErmitteln
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);

   procedure MöglicheEinheitenErmitteln
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord);

   procedure PermanenteKostenGebäude
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);

   procedure PermanenteKostenEinheiten
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);



   function BauobjektAuswählen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_Mensch),
         Post =>
           (BauobjektAuswählen'Result <= 99_999);

   function AuswahlBauprojekt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural;

end InDerStadtBauen;
