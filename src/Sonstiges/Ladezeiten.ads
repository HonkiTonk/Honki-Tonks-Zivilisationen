pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleDatentypen;

package Ladezeiten is

   
   type Spielwelt_Erstellen_Zeit_Enum is (Leer, Gesamtzeit, Generiere_Ebene_Oberfläche, Generiere_Küstengewässer, Generiere_Flüsse, Generiere_Landschaft_Ebene_Oberfläche, Generiere_Ressourcen, Generiere_Ebene_Himmel,
                                          Generiere_Ebene_Weltraum, Generiere_Ebene_Unterirdisch, Generiere_Ebene_Planeteninneres, Kartenfelder_Bewerten, Spieler_Platzieren);
   subtype Spielwelt_Erstellen_Zeit_Verwendet_Enum is Spielwelt_Erstellen_Zeit_Enum range Gesamtzeit .. Spielwelt_Erstellen_Zeit_Enum'Last;
   subtype Gesamtzeit_Enum is Spielwelt_Erstellen_Zeit_Verwendet_Enum range Generiere_Ebene_Oberfläche .. Spielwelt_Erstellen_Zeit_Verwendet_Enum'Last;
   
   type SpielweltErstellenZeitArray is array (Spielwelt_Erstellen_Zeit_Verwendet_Enum'Range, GlobaleDatentypen.Anfang_Ende_Enum'Range) of Time;
   SpielweltErstellenZeit : SpielweltErstellenZeitArray;
   
   type Einzelne_Zeiten_Enum is (Startzeit, Zwischen_Runden, Speicherzeit, Ladezeit);
   type EinzelneZeitenArray is array (Einzelne_Zeiten_Enum'Range, GlobaleDatentypen.Anfang_Ende_Enum'Range) of Time;
   EinzelneZeiten : EinzelneZeitenArray;
   
   type KIZeitenArray is array (GlobaleDatentypen.Rassen_Enum, GlobaleDatentypen.Anfang_Ende_Enum'Range) of Time;
   KIZeiten : KIZeitenArray;

   procedure LadezeitenSpielweltErstellen
     (WelcheZeitExtern : in Spielwelt_Erstellen_Zeit_Verwendet_Enum);
   
   procedure AnzeigeEinzelneZeit
     (WelcheZeitExtern : in Einzelne_Zeiten_Enum);
   
   procedure AnzeigeKIZeit
     (WelcheZeitExtern : in GlobaleDatentypen.Rassen_Enum);

private

   -- Für die Textausgabe
   type AufschlagArray is array (Einzelne_Zeiten_Enum'Range) of Positive;
   Aufschlag : constant AufschlagArray := (
                                           Startzeit       => 13,
                                           Zwischen_Runden => 14,
                                           Speicherzeit    => 15,
                                           Ladezeit        => 16
                                          );
   
   type KITextArray is array (GlobaleDatentypen.Rassen_Enum'Range) of Positive;
   KIText : KITextArray := (35, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34);

   GesamtzeitSpielweltErstellen : Float;
   GesamtzeitKI : Float;

end Ladezeiten;
