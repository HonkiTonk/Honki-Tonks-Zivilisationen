with GlobaleRecords, GlobaleDatentypen, GlobaleVariablen;

package KIVariablen is

   type LetzteBewegungenArray is array (GlobaleDatentypen.Rassen'Range, GlobaleVariablen.EinheitenGebaut'Range (2), 1 .. 3) of GlobaleRecords.AchsenAusKartenfeld;
   LetzteBewegungen : LetzteBewegungenArray := (others => (others => (others => (0, 0, 0))));

end KIVariablen;
