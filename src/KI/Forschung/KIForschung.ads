pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with SystemDatentypen;
with GlobaleVariablen;

package KIForschung is

   procedure Forschung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_KI);
   
private
      
   procedure NeuesForschungsprojekt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

end KIForschung;
