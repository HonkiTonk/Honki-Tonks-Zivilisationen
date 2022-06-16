pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with RassenDatentypen; use RassenDatentypen;
with LadezeitenDatentypen;
with SystemDatentypen;
with SonstigeVariablen;

------------------------------ Gehört das nicht eher nach Logik?
package Ladezeiten is
   
   ------------------------------ Die Sachen später nach private verschieben und die Clock, Abfragen, usw. dann in eine Prozedur/Funktion auslagern.
   type SpielweltErstellenArray is array (LadezeitenDatentypen.Spielwelt_Erstellen_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   SpielweltErstellen : SpielweltErstellenArray;
   
   type FortschrittSpielweltArray is array (SpielweltErstellenArray'Range (1)) of LadezeitenDatentypen.Ladefortschritt;
   FortschrittSpielwelt : FortschrittSpielweltArray;
   
   type KIZeitenArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   KIZeiten : KIZeitenArray;
   
   type FortschrittKIArray is array (KIZeitenArray'Range (1)) of LadezeitenDatentypen.Ladefortschritt;
   FortschrittKI : FortschrittKIArray;
   
   type RundenendeZeitArray is array (SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   RundenendeZeit : RundenendeZeitArray;
   
   FortschrittRundenende : LadezeitenDatentypen.Ladefortschritt;
   
   type SpeichernLadenZeitArray is array (SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   SpeichernLaden : SpeichernLadenZeitArray;
   
   FortschrittSpeichernLaden : LadezeitenDatentypen.Ladefortschritt;

   procedure SpielweltNullsetzen;
   procedure KINullsetzen;
   procedure RundenendeNullsetzen;
   procedure SpeichernLadenNullsetzen;
   procedure RundenendeSchreiben;
   procedure RundenendeMaximum;
   procedure SpeichernLadenMaximum;
   procedure FortschrittSpielweltSchreiben
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum);
   
   procedure FortschrittSpielweltMaximum
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum);
   
   procedure FortschrittKISchreiben
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   procedure FortschrittKIMaximum
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   procedure SpeichernLadenSchreiben
     (SpeichernLadenExtern : in Boolean);
   
private
   
   type FortschrittSchritteArray is array (1 .. 5) of LadezeitenDatentypen.Ladefortschritt;
   FortschrittSchritte : constant FortschrittSchritteArray := (
                                                               1 => 1,
                                                               2 => 25,
                                                               3 => 8,
                                                               4 => 12,
                                                               5 => 12
                                                              );

end Ladezeiten;
