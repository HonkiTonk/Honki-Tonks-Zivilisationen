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

   SichtweiteFestlegen : Positive;
   BewegungsfeldFestlegen : Positive;

   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;


   type SichtweitenArray is array (1 .. 3) of GlobaleRecords.AchsenKartenfeldPositivRecord;

   -- Hier noch was für die Sichtweite einfügen, vor allem in den Himmel. Eventuell auch von der Technologie abhängig machen.
   Sichtweiten : constant SichtweitenArray := (1 => (0, 6, 8),
                                               2 => (0, 6, 20),
                                               3 => (0, 6, 35));

   -- Muss immer eins kleiner sein als Sichtweiten
   -- Hier noch was für die Bewegung einfügen und von der Technologie abhängig machen.
   Bewegungsfeld : constant SichtweitenArray := (1 => (0, 5, 7),
                                                 2 => (0, 5, 19),
                                                 3 => (0, 5, 34));

   procedure CursorPositionAltFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen;
      BewegungsfeldFestlegenExtern : in Positive)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 1
          and
            BewegungsfeldFestlegenExtern <= Bewegungsfeld'Last);

end Karte;
