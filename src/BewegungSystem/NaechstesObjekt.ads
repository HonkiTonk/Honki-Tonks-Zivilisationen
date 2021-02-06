pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

package NaechstesObjekt is

   procedure NächsteEinheitMitBewegungspunkten (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure NächsteEinheit (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure NächsteEinheitOhneBewegungspunkte (RasseExtern : in GlobaleDatentypen.Rassen);
   procedure NächsteStadt (RasseExtern : in GlobaleDatentypen.Rassen);
   
private
   
   AktuelleEinheit : Integer := 1;
   Endwert : Integer;
   Startwert : Integer;
   AktuelleStadt : Integer := 1;

end NaechstesObjekt;
