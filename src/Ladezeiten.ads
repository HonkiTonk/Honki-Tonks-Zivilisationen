with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Calendar, Ada.Float_Text_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Calendar;

with GlobaleVariablen;

package Ladezeiten is

   procedure Ladezeiten (WelcheZeit : Integer);

private
   
   Warten : Wide_Wide_Character;

   Gesamtzeit : Float;

end Ladezeiten;
