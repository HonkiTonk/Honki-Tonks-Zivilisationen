pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package KIForschung is

   procedure Forschung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = GlobaleDatentypen.Spieler_KI);
   
private
      
   procedure NeuesForschungsprojekt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum);

end KIForschung;
