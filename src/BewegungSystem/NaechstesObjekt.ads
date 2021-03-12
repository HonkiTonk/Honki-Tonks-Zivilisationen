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
   
   AktuelleEinheit : GlobaleDatentypen.MaximaleEinheiten := 1;
   Endwert : GlobaleDatentypen.MaximaleEinheiten;
   Startwert : GlobaleDatentypen.MaximaleEinheiten;
   AktuelleStadt : GlobaleDatentypen.MaximaleStädte := 1;

end NaechstesObjekt;
