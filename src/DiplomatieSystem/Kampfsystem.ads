with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Numerics.Float_Random, KartenDatenbank, VerbesserungenDatenbank, EinheitenDatenbank, GlobaleVariablen, Karten, GlobaleDatentypen;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Numerics.Float_Random, GlobaleDatentypen;

package Kampfsystem is

   function KampfsystemNahkampf (GegnerStadtnummer, RasseAngriff, EinheitenPositionAngriff, RasseVerteidigung, EinheitenPositionVerteidigung : in Integer) return Boolean;

private

   Ergebnis : Boolean;

   Gewählt : Generator;

   VerteidigungBonusDurchStadt : Float;
   VerteidigerBonus : constant Float := 1.25;
   VerteidigungVerteidigungWert : Float;
   VerteidigungAngriffWert : Float;
   AngriffAngriffWert : Float;
   AngriffVerteidigungWert : Float;
   Wert : Float;

   procedure KampfBerechnung (RasseVerteidigung, EinheitNummerVerteidigung : in Integer; AngriffWert, VerteidigungWert : in Float);

   function Kampf (RasseAngriff, EinheitenPositionAngriff, RasseVerteidigung, EinheitenPositionVerteidigung : in Integer; VerteidigungBonus : in Float) return Boolean;
   function Prüfen return Boolean;

end Kampfsystem;
