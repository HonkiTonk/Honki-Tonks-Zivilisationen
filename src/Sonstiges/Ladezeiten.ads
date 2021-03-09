pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

package Ladezeiten is

   type LadezeitenSpielweltErstellenZeitArray is array (Positive range <>, Positive range <>) of Time;
   LadezeitenSpielweltErstellenZeit : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 12);
   Speicherzeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);
   LadenLadezeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);
   SpielStartzeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 2);
   BerechnungenNachZugendeAllerSpielerZeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);
   KIZeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 18);

   procedure LadezeitenSpielweltErstellen (WelcheZeit : in Positive) with
     Pre => (WelcheZeit <= LadezeitenSpielweltErstellenZeit'Last (2));

   procedure Speichern (WelcheZeit : in Positive) with
     Pre => (WelcheZeit = Speicherzeiten'Last (2));

   procedure Laden (WelcheZeit : in Positive) with
     Pre => (WelcheZeit = LadenLadezeiten'Last (2));

   procedure SpielStart (WelcheZeit : in Positive) with
     Pre => (WelcheZeit <= SpielStartzeiten'Last (2));

   procedure BerechnungenNachZugendeAllerSpieler (WelcheZeit : in Positive) with
     Pre => (WelcheZeit = BerechnungenNachZugendeAllerSpielerZeiten'Last (2));

   procedure KIZeit (WelcheZeit : in Positive) with
     Pre => (WelcheZeit <= KIZeiten'Last (2));

private
                                                 
   Warten : Wide_Wide_Character;

   -- Für die Textausgabe
   AufschlagSpeichern : constant Positive := 12;
   AufschlagLaden : constant Positive := 13;
   AufschlagZwischenDenRunden : constant Positive := 14;
   AufschlagKIRechenzeit : constant Positive := 15;
   AufschlagSpielstart : constant Positive := 16;
   -- Für die Textausgabe

   Gesamtzeit : Float;

end Ladezeiten;
