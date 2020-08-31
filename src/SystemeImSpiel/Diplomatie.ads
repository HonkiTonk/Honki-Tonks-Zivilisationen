with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, GlobaleVariablen;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

package Diplomatie is

   procedure DiplomatieAuswählen;
   procedure KriegDurchDirektenAngriff (AngreifendeRasse, VerteidigendeRasse : in Integer);

   function DiplomatischenStatusPrüfen (AngreifendeRasse, VerteidigendeRasse : in Integer) return Integer;

private



end Diplomatie;
