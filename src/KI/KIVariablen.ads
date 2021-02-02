with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;

package KIVariablen is

   type PositionenArray is array (GlobaleDatentypen.Rassen range <>, Positive range <>, Positive range <>) of GlobaleRecords.AchsenAusKartenfeldRecord;
   LetzteBewegungen : PositionenArray (GlobaleDatentypen.Rassen'Range, GlobaleVariablen.EinheitenGebaut'Range (2), 1 .. 3) := (others => (others => (others => (0, 0, 0))));
   ZielBewegung : PositionenArray (GlobaleDatentypen.Rassen'Range, GlobaleVariablen.EinheitenGebaut'Range (2), 1 .. 1) := (others => (others => (others => (0, 0, 0))));

end KIVariablen;
