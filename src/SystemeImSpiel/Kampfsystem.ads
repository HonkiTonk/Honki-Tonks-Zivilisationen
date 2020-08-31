with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, KartenDatenbank, VerbesserungenDatenbank, EinheitenDatenbank, GlobaleVariablen;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

package Kampfsystem is

   function KampfsystemNahkampf (RasseAngriff, EinheitenPositionAngriff, RasseVerteidigung, EinheitenPositionVerteidigung : in Integer) return Boolean;

end Kampfsystem;
