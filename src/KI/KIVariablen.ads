pragma SPARK_Mode (On);

with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;

package KIVariablen is

   type PositionenArray is array (GlobaleDatentypen.Rassen range <>, Positive range <>, Positive range <>) of GlobaleRecords.AchsenKartenfeldRecord;
   LetzteBewegungen : PositionenArray (GlobaleDatentypen.Rassen'Range, GlobaleVariablen.EinheitenGebaut'Range (2), 1 .. 3) := (others => (others => (others => (0, 0, 0))));
   ZielBewegung : PositionenArray (GlobaleDatentypen.Rassen'Range, GlobaleVariablen.EinheitenGebaut'Range (2), 1 .. 1) := (others => (others => (others => (0, 0, 0))));

   type EinheitenNochBefehleErteilbarArray is array (GlobaleVariablen.EinheitenGebaut'Range (1), GlobaleVariablen.EinheitenGebaut'Range (2)) of Boolean;
   EinheitenNochBefehleErteilbar : EinheitenNochBefehleErteilbarArray := (others => (others => True));

   type EinheitenSchonBefehleErteiltArray is array (GlobaleVariablen.RassenImSpiel'Range) of Natural;
   EinheitenSchonBefehleErteilt : EinheitenSchonBefehleErteiltArray := (others => 0);

end KIVariablen;
