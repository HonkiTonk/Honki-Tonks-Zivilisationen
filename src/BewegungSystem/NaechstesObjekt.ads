pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package NaechstesObjekt is

   type Bewegungspunkte is (Hat_Bewegungspunkte, Keine_Bewegungspunkte, Egal_Bewegeungspunkte);

   procedure NächsteEinheit
     (RasseExtern : in GlobaleDatentypen.Rassen;
      BewegungspunkteExtern : in Bewegungspunkte)
     with
       Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);

   procedure NächsteStadt
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre => (GlobaleVariablen.RassenImSpiel (RasseExtern) /= 0);
   
private

   SchleifenBegrenzung : GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   
   type AktuelleEinheitArray is array (GlobaleDatentypen.Rassen'Range) of GlobaleDatentypen.MaximaleEinheitenMitNullWert;
   AktuelleEinheit : AktuelleEinheitArray := (others => 0);

   type AktuelleStadtArray is array (GlobaleDatentypen.Rassen'Range) of GlobaleDatentypen.MaximaleStädteMitNullWert;
   AktuelleStadt : AktuelleStadtArray := (others => 0);

end NaechstesObjekt;
