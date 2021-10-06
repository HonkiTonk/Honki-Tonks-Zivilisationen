pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with GlobaleVariablen;

package KIForschung is

   procedure Forschung
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_KI);
   
private
      
   procedure NeuesForschungsprojekt
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum);

end KIForschung;
