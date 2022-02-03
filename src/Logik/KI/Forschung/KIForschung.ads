pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with SystemKonstanten;

package KIForschung is

   procedure Forschung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.SpielerKIKonstante);
   
private
      
   procedure NeuesForschungsprojekt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

end KIForschung;
