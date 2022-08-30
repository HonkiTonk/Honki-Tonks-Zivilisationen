pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with RassenDatentypen;
with LadezeitenDatentypen;
with SystemDatentypen;

-- Gehört das nicht eher nach Logik? äöü
package Ladezeiten is
   
   -- Die Sachen später nach private verschieben und die Clock, Abfragen, usw. dann in eine Prozedur/Funktion auslagern. äöü
   type SpielweltErstellenArray is array (LadezeitenDatentypen.Spielwelt_Erstellen_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   SpielweltErstellen : SpielweltErstellenArray;
   
   type FortschrittSpielweltArray is array (SpielweltErstellenArray'Range (1)) of LadezeitenDatentypen.Ladefortschritt;
   FortschrittSpielwelt : FortschrittSpielweltArray;
   
   type KIZeitenArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   KIZeiten : KIZeitenArray;
   
   type FortschrittKIArray is array (LadezeitenDatentypen.KI_Rechnet_Enum'Range) of LadezeitenDatentypen.Ladefortschritt;
   FortschrittKI : FortschrittKIArray;
   
   type RundenendeZeitArray is array (SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   RundenendeZeit : RundenendeZeitArray;
   
   FortschrittRundenende : LadezeitenDatentypen.Ladefortschritt;
   
   type SpeichernLadenZeitArray is array (SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   SpeichernLaden : SpeichernLadenZeitArray;
   
   FortschrittSpeichernLaden : LadezeitenDatentypen.Ladefortschritt;

   procedure SpielweltNullsetzen;
   procedure KINullsetzenFortschritt;
   procedure KINullsetzenZeit;
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
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.KI_Rechnet_Enum);
   
   procedure FortschrittKIMaximum
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.KI_Rechnet_Enum);
   
   procedure SpeichernLadenSchreiben
     (SpeichernLadenExtern : in Boolean);
   
private
   
   type FortschrittSchritteArray is array (1 .. 5) of LadezeitenDatentypen.Ladefortschritt;
   FortschrittSchritte : constant FortschrittSchritteArray := (
                                                               1 => 1,
                                                               2 => 1,
                                                               3 => 8,
                                                               4 => 33,
                                                               5 => 33
                                                              );

end Ladezeiten;
