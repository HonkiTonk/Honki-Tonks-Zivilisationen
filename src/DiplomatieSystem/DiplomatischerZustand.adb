pragma SPARK_Mode (On);

package body DiplomatischerZustand is

   procedure KriegDurchDirektenAngriff
     (AngreifendeRasseExtern, VerteidigendeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      GlobaleVariablen.Diplomatie (AngreifendeRasseExtern, VerteidigendeRasseExtern) := GlobaleDatentypen.Krieg;
      GlobaleVariablen.Diplomatie (VerteidigendeRasseExtern, AngreifendeRasseExtern) := GlobaleDatentypen.Krieg;
      
   end KriegDurchDirektenAngriff;



   function DiplomatischenStatusPrüfen
     (EigeneRasseExtern, FremdeRasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.Status_Untereinander_Enum
   is begin
      
      return GlobaleVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern);
      
   end DiplomatischenStatusPrüfen;

end DiplomatischerZustand;
