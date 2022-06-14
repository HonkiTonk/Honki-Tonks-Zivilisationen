pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with LadezeitenDatentypen;
with SystemDatentypen;

package Ladezeiten is
   
   type SpielweltErstellenArray is array (LadezeitenDatentypen.Spielwelt_Erstellen_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   SpielweltErstellen : SpielweltErstellenArray;
   
   type FortschrittSpielweltArray is array (SpielweltErstellenArray'Range (1)) of LadezeitenDatentypen.Ladefortschritt;
   FortschrittSpielwelt : FortschrittSpielweltArray;

   procedure Nullsetzen;
   
   procedure FortschrittSpielweltSchreiben
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum);

end Ladezeiten;
