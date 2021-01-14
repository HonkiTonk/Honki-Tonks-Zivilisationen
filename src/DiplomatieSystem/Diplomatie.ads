with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, GlobaleDatentypen;

package Diplomatie is

   procedure DiplomatieAuswählen;
   procedure KriegDurchDirektenAngriff (AngreifendeRasse, VerteidigendeRasse : in Integer)
     with Pre => AngreifendeRasse in GlobaleDatentypen.RassenImSpielArray'Range and VerteidigendeRasse in GlobaleDatentypen.RassenImSpielArray'Range;

   function DiplomatischenStatusPrüfen (AngreifendeRasse, VerteidigendeRasse : in Integer) return Integer
     with Pre => AngreifendeRasse in GlobaleDatentypen.RassenImSpielArray'Range and VerteidigendeRasse in GlobaleDatentypen.RassenImSpielArray'Range;

private



end Diplomatie;
