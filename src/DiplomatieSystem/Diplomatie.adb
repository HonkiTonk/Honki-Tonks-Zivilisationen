package body Diplomatie is

   procedure DiplomatieAuswählen is
   begin
      
      null;
      
   end DiplomatieAuswählen;



   procedure KriegDurchDirektenAngriff (AngreifendeRasse, VerteidigendeRasse : in Integer) is
   begin
      
      GlobaleVariablen.Diplomatie (AngreifendeRasse, VerteidigendeRasse) := -1;
      GlobaleVariablen.Diplomatie (VerteidigendeRasse, AngreifendeRasse) := -1;
      
   end KriegDurchDirektenAngriff;



   function DiplomatischenStatusPrüfen (AngreifendeRasse, VerteidigendeRasse : in Integer) return Integer is
   begin
      
      return GlobaleVariablen.Diplomatie (AngreifendeRasse, VerteidigendeRasse);
      
   end DiplomatischenStatusPrüfen;

end Diplomatie;
