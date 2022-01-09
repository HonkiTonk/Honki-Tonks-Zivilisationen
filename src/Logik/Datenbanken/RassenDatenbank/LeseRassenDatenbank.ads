pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;

package LeseRassenDatenbank is

   function RassenAggressivität
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   function RassenExpansion
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   function RassenWissenschaft
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   function RassenProduktion
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   function RassenWirtschaft
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   function RassenBewirtschaftung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.MaximaleStädteMitNullWert
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   function RassenGültigeStaatsform
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      StaatsformExtern : SystemDatentypen.Staatsform_Enum)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);

end LeseRassenDatenbank;
