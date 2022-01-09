pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;

package KIForschung is

   procedure Forschung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_KI);
   
private
      
   procedure NeuesForschungsprojekt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

end KIForschung;
