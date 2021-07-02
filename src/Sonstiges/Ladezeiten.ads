pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

package Ladezeiten is

   type LadezeitenArray is array (Positive range <>, Positive range <>) of Time;
   SpielweltErstellenZeit : LadezeitenArray (1 .. 12, 1 .. 2);
   
   -- 1. Startzeit
   -- 2. Zeit zwischen den Runden
   -- 3. Zeit zum Speichern
   -- 4. Zeit zum Laden
   EinzelneZeiten : LadezeitenArray (1 .. 4, 1 .. 2);
                                                      
   KIZeiten : LadezeitenArray (1 .. 19, 1 .. 2);

   procedure LadezeitenSpielweltErstellen
     (WelcheZeitExtern : in Positive);
   
   procedure AnzeigeEinzelneZeit
     (WelcheZeitExtern : in Positive);
   
   procedure AnzeigeKIZeit
     (WelcheZeitExtern : in Positive);

private

   -- Für die Textausgabe
   type AufschlagArray is array (EinzelneZeiten'Range (1)) of Positive;
   Aufschlag : constant AufschlagArray := (1 => 13,
                                           2 => 14,
                                           3 => 15,
                                           4 => 16);
   
   KIAufschlag : constant Positive := 16;
   -- Für die Textausgabe

   GesamtzeitSpielweltErstellen : Float;
   GesamtzeitKI : Float;

end Ladezeiten;
