pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;

package RassenAllgemein is

   function Rassenname
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
     with
       Post => (
                  Rassenname'Result'Length > 0
               );
   
   function BeschreibungRasse
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
     with
       Post => (
                  BeschreibungRasse'Result'Length > 0
               );

end RassenAllgemein;
