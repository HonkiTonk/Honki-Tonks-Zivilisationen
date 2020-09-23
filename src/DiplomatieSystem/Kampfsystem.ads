with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, KartenDatenbank, VerbesserungenDatenbank, EinheitenDatenbank, GlobaleVariablen, Karten;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

package Kampfsystem is

   function KampfsystemNahkampf (GegnerStadtnummer, RasseAngriff, EinheitenPositionAngriff, RasseVerteidigung, EinheitenPositionVerteidigung : in Integer) return Boolean;

private

   Ergebnis : Boolean;

   VerteidigungBonusDurchStadt : Float;
   VerteidigerBonus : constant Float := 1.25;
   VerteidigungVerteidigungWert : Float;
   VerteidigungAngriffWert : Float;

   function Kampf (RasseAngriff, EinheitenPositionAngriff, RasseVerteidigung, EinheitenPositionVerteidigung : in Integer; VerteidigungBonus : in Float) return Boolean;

end Kampfsystem;
