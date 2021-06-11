pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package KIForschung is

   procedure Forschung
     (RasseExtern : in GlobaleDatentypen.Rassen)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = 2);
   
private
   
   AnforderungVorhanden : Natural;
   AnforderungErfüllt : Natural;

end KIForschung;
