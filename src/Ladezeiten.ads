pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

package Ladezeiten is

   type LadezeitenSpielweltErstellenZeitArray is array (Positive range <>, Positive range <>) of Time;
   LadezeitenSpielweltErstellenZeit : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 2 .. 12);
   Speicherzeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);
   LadenLadezeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);
   SpielStartzeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 2);
   BerechnungenNachZugendeAllerSpielerZeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);
   KIZeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 18);

   procedure LadezeitenSpielweltErstellen (WelcheZeit : in Positive) with
     Global  => (Input => LadezeitenSpielweltErstellenZeit),
     Depends => (null => (LadezeitenSpielweltErstellenZeit, WelcheZeit)),
     Pre     => (WelcheZeit in LadezeitenSpielweltErstellenZeit'Range (2));

   procedure Speichern (WelcheZeit : in Positive) with
     Global  => (Input => LadezeitenSpielweltErstellenZeit),
     Depends => (null => (LadezeitenSpielweltErstellenZeit, WelcheZeit)),
     Pre     => (WelcheZeit in Speicherzeiten'Range (2));

   procedure Laden (WelcheZeit : in Positive) with
     Global  => (Input => LadezeitenSpielweltErstellenZeit),
     Depends => (null => (LadezeitenSpielweltErstellenZeit, WelcheZeit)),
     Pre     => (WelcheZeit in LadenLadezeiten'Range (2));

   procedure SpielStart (WelcheZeit : in Positive) with
     Global  => (Input => LadezeitenSpielweltErstellenZeit),
     Depends => (null => (LadezeitenSpielweltErstellenZeit, WelcheZeit)),
     Pre     => (WelcheZeit in SpielStartzeiten'Range (2));

   procedure BerechnungenNachZugendeAllerSpieler (WelcheZeit : in Positive) with
     Global  => (Input => LadezeitenSpielweltErstellenZeit),
     Depends => (null => (LadezeitenSpielweltErstellenZeit, WelcheZeit)),
     Pre     => (WelcheZeit in BerechnungenNachZugendeAllerSpielerZeiten'Range (2));

   procedure KIZeit (WelcheZeit : in Positive) with
     Global  => (Input => LadezeitenSpielweltErstellenZeit),
     Depends => (null => (LadezeitenSpielweltErstellenZeit, WelcheZeit)),
     Pre     => (WelcheZeit in KIZeiten'Range (2));

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
