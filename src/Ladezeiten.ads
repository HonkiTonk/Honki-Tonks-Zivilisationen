with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Calendar, Ada.Float_Text_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Calendar;

with GlobaleVariablen;

package Ladezeiten is

   procedure LadezeitenSpielweltErstellen (WelcheZeit : Integer)
     with Pre => WelcheZeit >= 1;
   procedure Speichern (WelcheZeit : Integer)
     with Pre => WelcheZeit >= 1;
   procedure Laden (WelcheZeit : Integer)
     with Pre => WelcheZeit >= 1;
   procedure SpielStart (WelcheZeit : Integer)
     with Pre => WelcheZeit >= 1;

   type LadezeitenSpielweltErstellenZeitArray is array (Positive range <>, Positive range <>) of Time;
   LadezeitenSpielweltErstellenZeit : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 2 .. 12);
   Speicherzeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);
   LadenLadezeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);
   SpielStartzeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);

private
   
   Warten : Wide_Wide_Character;

   AufschlagSpielstart : constant Integer := 19;
   AufschlagSpeichern : constant Integer := 29;
   AufschlagLaden : constant Integer := 39;

   Gesamtzeit : Float;

end Ladezeiten;
