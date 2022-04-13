pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with SystemDatentypen;

package LadezeitenDatentypen is

   ------------------------- Nach GlobaleDatentypen verschieben, nach einer Überarbeitung.
   type Spielwelt_Erstellen_Zeit_Enum is (
                                          Leer_Enum,
                                          
                                          Gesamtzeit_Enum, Generiere_Normal_Himmel_Weltraum_Planeteninneres_Enum, Generiere_Küstengewässer_Enum, Generiere_Landschaft_Ebene_Oberfläche_Enum,
                                          Generiere_Unterwasser_Unterirdisch_Enum, Generiere_Flüsse_Enum, Generiere_Ressourcen_Enum, Kartenfelder_Bewerten_Enum, Spieler_Platzieren_Enum
                                         );
   subtype Spielwelt_Erstellen_Zeit_Verwendet_Enum is Spielwelt_Erstellen_Zeit_Enum range Gesamtzeit_Enum .. Spielwelt_Erstellen_Zeit_Enum'Last;
   subtype Gesamtzeit_Erstellen_Enum is Spielwelt_Erstellen_Zeit_Verwendet_Enum range Generiere_Normal_Himmel_Weltraum_Planeteninneres_Enum .. Spielwelt_Erstellen_Zeit_Verwendet_Enum'Last;
   
   type SpielweltErstellenZeitArray is array (Spielwelt_Erstellen_Zeit_Verwendet_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   SpielweltErstellenZeit : SpielweltErstellenZeitArray;
   
   type Einzelne_Zeiten_Enum is (
                                 Startzeit_Enum, Zwischen_Runden_Enum, Speicherzeit_Enum, Ladezeit_Enum
                                );
   type EinzelneZeitenArray is array (Einzelne_Zeiten_Enum'Range, SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   EinzelneZeiten : EinzelneZeitenArray;
   
   type KIZeitenArray is array (SystemDatentypen.Rassen_Enum, SystemDatentypen.Anfang_Ende_Enum'Range) of Time;
   KIZeiten : KIZeitenArray;
   
   -- Für die Textausgabe, irgendwann einmal an das neue Textsystem anpassen.
   type AufschlagArray is array (Einzelne_Zeiten_Enum'Range) of Positive;
   Aufschlag : constant AufschlagArray := (
                                           Startzeit_Enum       => 10,
                                           Zwischen_Runden_Enum => 11,
                                           Speicherzeit_Enum    => 12,
                                           Ladezeit_Enum        => 13
                                          );
   
   type KITextArray is array (SystemDatentypen.Rassen_Enum'Range) of Positive;
   KIText : KITextArray := (
                            SystemDatentypen.Keine_Rasse_Enum      => 32,
                            SystemDatentypen.Menschen_Enum         => 14,
                            SystemDatentypen.Kasrodiah_Enum        => 15,
                            SystemDatentypen.Lasupin_Enum          => 16,
                            SystemDatentypen.Lamustra_Enum         => 17,
                            SystemDatentypen.Manuky_Enum           => 18,
                            SystemDatentypen.Suroka_Enum           => 19,
                            SystemDatentypen.Pryolon_Enum          => 20,
                            SystemDatentypen.Talbidahr_Enum        => 21,
                            SystemDatentypen.Moru_Phisihl_Enum     => 22,
                            SystemDatentypen.Larinos_Lotaris_Enum  => 23,
                            SystemDatentypen.Carupex_Enum          => 24,
                            SystemDatentypen.Alary_Enum            => 25,
                            SystemDatentypen.Tesorahn_Enum         => 26,
                            SystemDatentypen.Natries_Zermanis_Enum => 27,
                            SystemDatentypen.Tridatus_Enum         => 28,
                            SystemDatentypen.Senelari_Enum         => 29,
                            SystemDatentypen.Aspari_2_Enum         => 30,
                            SystemDatentypen.Ekropa_Enum           => 31
                           );

end LadezeitenDatentypen;
