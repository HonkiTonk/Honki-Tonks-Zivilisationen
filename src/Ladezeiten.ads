pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

package Ladezeiten is

   type LadezeitenSpielweltErstellenZeitArray is array (Positive range <>, Positive range <>) of Time;
   LadezeitenSpielweltErstellenZeit : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 2 .. 12);
   Speicherzeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);
   LadenLadezeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);
   SpielStartzeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);
   BerechnungenNachZugendeAllerSpielerZeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);
   KIZeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 18);

   procedure LadezeitenSpielweltErstellen (WelcheZeit : Positive) with
     Pre => WelcheZeit in LadezeitenSpielweltErstellenZeit'Range (2);

   procedure Speichern (WelcheZeit : in Positive) with
     Pre => WelcheZeit in Speicherzeiten'Range (2);

   procedure Laden (WelcheZeit : in Positive) with
     Pre => WelcheZeit in LadenLadezeiten'Range (2);

   procedure SpielStart (WelcheZeit : in Positive) with
     Pre => WelcheZeit in SpielStartzeiten'Range (2);

   procedure BerechnungenNachZugendeAllerSpieler (WelcheZeit : in Positive) with
     Pre => WelcheZeit in BerechnungenNachZugendeAllerSpielerZeiten'Range (2);

   procedure KIZeit (WelcheZeit : in Positive) with
     Pre => WelcheZeit in KIZeiten'Range (2);

private
   
   Warten : Wide_Wide_Character;

   AufschlagSpielstart : constant Positive := 19; -- Für die Textausgabe
   AufschlagSpeichern : constant Positive := 29;
   AufschlagLaden : constant Positive := 39;

   Gesamtzeit : Float;

end Ladezeiten;
