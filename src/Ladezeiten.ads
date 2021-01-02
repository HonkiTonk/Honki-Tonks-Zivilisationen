with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Calendar, Ada.Float_Text_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Calendar;

with GlobaleVariablen;

package Ladezeiten is

   procedure LadezeitenSpielweltErstellen (WelcheZeit : Integer);
   procedure Speichern (WelcheZeit : Integer);
   procedure Laden (WelcheZeit : Integer);
   procedure SpielStart (WelcheZeit : Integer);

   type LadezeitenSpielweltErstellenZeitArray is array (1 .. 2, 2 .. 13) of Time;
   LadezeitenSpielweltErstellenZeit : LadezeitenSpielweltErstellenZeitArray;
   -- Speicherzeiten : LadezeitenSpielweltErstellenZeitArray;
   -- LadenLadezeiten : LadezeitenSpielweltErstellenZeitArray;
   -- SpielStartzeiten : LadezeitenSpielweltErstellenZeitArray;

private
   
   Warten : Wide_Wide_Character;

   Gesamtzeit : Float;

end Ladezeiten;
