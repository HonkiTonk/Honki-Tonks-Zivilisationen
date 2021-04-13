pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

package Ladezeiten is

   type LadezeitenSpielweltErstellenZeitArray is array (Positive range <>, Natural range <>) of Time;
   LadezeitenSpielweltErstellenZeit : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 0 .. 11);
   Speicherzeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);
   LadenLadezeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);
   SpielStartzeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 2);
   BerechnungenNachZugendeAllerSpielerZeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 1);
   KIZeiten : LadezeitenSpielweltErstellenZeitArray (1 .. 2, 1 .. 18);

   procedure LadezeitenSpielweltErstellen
     (WelcheZeitExtern : in Natural)
     with
       Pre =>
         (WelcheZeitExtern <= LadezeitenSpielweltErstellenZeit'Last (2));

   procedure Speichern
     (WelcheZeitExtern : in Positive)
     with
       Pre =>
         (WelcheZeitExtern = Speicherzeiten'Last (2));

   procedure Laden
     (WelcheZeitExtern : in Positive)
     with
       Pre =>
         (WelcheZeitExtern = LadenLadezeiten'Last (2));

   procedure SpielStart
     (WelcheZeitExtern : in Positive)
     with
       Pre =>
         (WelcheZeitExtern <= SpielStartzeiten'Last (2));

   procedure BerechnungenNachZugendeAllerSpieler
     (WelcheZeitExtern : in Positive)
     with
       Pre =>
         (WelcheZeitExtern = BerechnungenNachZugendeAllerSpielerZeiten'Last (2));

   procedure KIZeit
     (WelcheZeitExtern : in Positive)
     with
       Pre =>
         (WelcheZeitExtern <= KIZeiten'Last (2));

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
