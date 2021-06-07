pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen, GlobaleRecords;

package Karte is

   procedure AnzeigeKarte
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

private

   StehtDrauf : Boolean;

   -- MöglicheAngriffsfelder : constant Wide_Wide_Character := '■'; -- Später für Fernkampfeinheiten wieder einbauen?
   Verteidigungsbonus : GlobaleDatentypen.GrundwerteNRGWVA;
   Nahrungsgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Ressourcengewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Geldgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Wissensgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;

   EinheitNummer : GlobaleDatentypen.MaximaleEinheiten;

   SichtweiteFestlegen : Integer;
   BewegungsfeldFestlegen : Integer;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;

   RasseUndPlatznummer : GlobaleRecords.RassePlatznummerRecord;

   type SichtweitenArray is array (1 .. 3) of GlobaleRecords.AchsenKartenfeldPositivRecord;

   Sichtweiten : constant SichtweitenArray := (1 => (0, 6, 8), -- Hier noch was für die Sichtweite einfügen, vor allem in den Himmel. Eventuell auch von der Technologie abhängig machen.
                                               2 => (0, 6, 20),
                                               3 => (0, 6, 35));

   -- Muss immer eins kleiner sein als Sichtweiten
   Bewegungsfeld : constant SichtweitenArray := (1 => (0, 5, 7), -- Hier noch was für die Bewegung einfügen und von der Technologie abhängig machen.
                                                 2 => (0, 5, 19),
                                                 3 => (0, 5, 34));

   procedure Information
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1);

end Karte;
