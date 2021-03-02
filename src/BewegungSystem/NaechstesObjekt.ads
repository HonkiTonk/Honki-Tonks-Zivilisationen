pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package NaechstesObjekt is

   procedure NächsteEinheitMitBewegungspunkten (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

   procedure NächsteEinheit (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

   procedure NächsteEinheitOhneBewegungspunkte (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

   procedure NächsteStadt (RasseExtern : in GlobaleDatentypen.Rassen) with
     Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);
   
private
   
   AktuelleEinheit : Integer := 1;
   Endwert : Integer;
   Startwert : Integer;
   AktuelleStadt : Integer := 1;

end NaechstesObjekt;
