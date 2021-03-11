pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package Karten is

   LeererWertWeltkarte : constant GlobaleRecords.KartenRecord := (0, False, (others => False), -- 1. Wert = Kartengrund, 2. Wert = Ist da ein Hügel?, 3. Wert = Welche Rasse kann was sehen
                                                                  0, 0, 0, 0, -- 4. Wert = Welcher Fluss, 5. Wert = Welche Straße, 6. Wert = Welche Verbesserung, 7. Wert = Welche Ressource
                                                                  0, 0); -- 8. Wert = Durch welche Stadt welcher Rasse belegter Grund, 9. Wert = Felderbewertung

   type WeltkarteArray is array (GlobaleDatentypen.EbeneVorhanden'Range, GlobaleDatentypen.KartenfeldPositiv'Range, GlobaleDatentypen.KartenfeldPositiv'Range) of GlobaleRecords.KartenRecord;
   Weltkarte : WeltkarteArray := (others => (others => (others => LeererWertWeltkarte)));

   type StadtkarteArray is array (GlobaleDatentypen.Stadtfeld'Range, GlobaleDatentypen.Stadtfeld'Range) of Integer;
   Stadtkarte : StadtkarteArray := (others => (others => (0)));

   type KartengrößenRecord is record

      YAchsenGröße : GlobaleDatentypen.KartenfeldPositiv;
      XAchsenGröße : GlobaleDatentypen.KartenfeldPositiv;
      Ressourcenmenge : Natural;

   end record;

   type KartengrößenArray is array (1 .. 10) of KartengrößenRecord;
   Kartengrößen : KartengrößenArray := ((20, 20, 12), (40, 40, 50), (80, 80, 200), (120, 80, 300), (120, 160, 600), (160, 160, 800), (240, 240, 1_800), (320, 320, 3200), (1_000, 1_000, 31_250), (1, 1, 1));

   Kartengröße : Positive;

end Karten;
