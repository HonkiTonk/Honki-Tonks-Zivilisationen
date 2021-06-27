pragma SPARK_Mode (On);

with GebaeudeDatenbank;

package body ZugriffGebaeudeDatenbank is

   -- Mit ID
   function GrafikMitID
     (RasseExtern : in GlobaleDatentypen.Rassen;
      IDExtern : in GlobaleDatentypen.GebäudeID)
      return Wide_Wide_Character
   is begin

      return GebaeudeDatenbank.GebäudeListe (RasseExtern, IDExtern).GebäudeGrafik;

   end GrafikMitID;




   -- Mit ID

end ZugriffGebaeudeDatenbank;
