pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with RassenDatentypen; use RassenDatentypen;
with LadezeitenDatentypen;
with SystemDatentypen;
with SonstigeVariablen;

package Ladezeiten is
   
   type SpielweltErstellenArray is array (LadezeitenDatentypen.Spielwelt_Erstellen_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   SpielweltErstellen : SpielweltErstellenArray;
   
   type FortschrittSpielweltArray is array (SpielweltErstellenArray'Range (1)) of LadezeitenDatentypen.Ladefortschritt;
   FortschrittSpielwelt : FortschrittSpielweltArray;
   
   type KIZeitenArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   KIZeiten : KIZeitenArray;
   
   type FortschrittKIArray is array (KIZeitenArray'Range (1)) of LadezeitenDatentypen.Ladefortschritt;
   FortschrittKI : FortschrittKIArray;

   procedure SpielweltNullsetzen;
   procedure KINullsetzen;
   procedure FortschrittSpielweltSchreiben
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum);
   
   procedure FortschrittSpielweltMaximum
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum);
   
   procedure FortschrittKISchreiben
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

end Ladezeiten;
