pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with SystemKonstanten;
with EinheitStadtDatentypen;

package GlobaleTexte is

   type Welche_Datei_Enum is (Leer, Start, Feste_Abfragen, Spiel_Einstellungen, Rassen_Beschreibung_Lang, Menü_Auswahl, Beschreibungen_Kartenfelder_Kurz, Beschreibungen_Kartenfelder_Lang, Fehlermeldungen, Zeug,
                              Fragen, Ladezeiten, Beschreibungen_Einheiten_Kurz, Beschreibungen_Einheiten_Lang, Beschreibungen_Verbesserungen_Kurz, Beschreibungen_Verbesserungen_Lang, Beschreibungen_Gebäude_Kurz,
                              Beschreibungen_Gebäude_Lang, Beschreibungen_Forschung_Kurz, Beschreibungen_Forschung_Lang, Beschreibungen_Beschäftigung_Kurz, Beschreibungen_Beschäftigung_Lang, Städtenamen_KI, Cheat_Menü,
                              Rassen_Beschreibung_Kurz, Beschreibung_Forschung_Ermöglicht, Allgemeine_Informationen, Würdigungen, Diplomatie, Diplomatie_KI, Gewonnen, Handeln);
   
   type Welcher_Abstand_Enum is (Leer, Kleiner_Abstand, Großer_Abstand, Neue_Zeile);
   
   type SprachenEinlesenArray is array (1 .. 100) of Unbounded_Wide_Wide_String;
   SprachenEinlesen : SprachenEinlesenArray;

   type TexteEinlesenArray is array (1 .. SystemDatentypen.TextDateien'Last, 1 .. 93) of Unbounded_Wide_Wide_String;
   TexteEinlesen : TexteEinlesenArray := (others => (others => SystemKonstanten.LeerUnboundedString));
      
   RassenNamenBeschreibungen : constant Positive := 2 * 18;
   
   type TexteArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
   
   Hauptmenü : TexteArray (1 .. 8);
   Spielmenü : TexteArray (1 .. 6);
   Optionsmenü : TexteArray (1 .. 7);
   Grafikmenü : TexteArray (1 .. 1);
   Soundmenü : TexteArray (1 .. 1);
   Steuerungmenü : TexteArray (1 .. 45);
   Sonstigesmenü : TexteArray (1 .. 6);
   Kartengröße : TexteArray (1 .. 14);
   Kartenart : TexteArray (1 .. 10);
   Kartentemperatur : TexteArray (1 .. 10);
   Spieleranzahl : TexteArray (1 .. 6);
   Rassenauswahl : TexteArray (1 .. 23);
   Schwierigkeitsgrad : TexteArray (1 .. 8);
   Kartenform : TexteArray (1 .. 13);
   Ressourcenmenge : TexteArray (1 .. 9);
   JaNein : TexteArray (1 .. 2);
   Rassen : TexteArray (1 .. RassenNamenBeschreibungen);
   Kartenfelder : TexteArray (1 .. 160);
   Einheiten : TexteArray (1 .. RassenNamenBeschreibungen * Positive (EinheitStadtDatentypen.EinheitenID'Last));
   Verbesserungen : TexteArray (1 .. 48);
   Gebäude : TexteArray (1 .. RassenNamenBeschreibungen * Positive (EinheitStadtDatentypen.GebäudeID'Last));
   Forschungen : TexteArray (1 .. RassenNamenBeschreibungen * Positive (EinheitStadtDatentypen.ForschungID'Last));
   Beschäftigungen : TexteArray (1 .. 18);
   StädtenamenKI : TexteArray (1 .. 3);
   Cheatmenü : TexteArray (1 .. 3);
   AllgemeineInformationen : TexteArray (1 .. 16);
   Würdigung : TexteArray (1 .. 1);
   Diplomatiemenü : TexteArray (1 .. 7);
   DiplomatieKI : TexteArray (1 .. 3);
   Endmeldungen : TexteArray (1 .. 3);
   Handelsmenü : TexteArray (1 .. 10);
   DiplomatieStatus : TexteArray (1 .. 4);
   Angebot : TexteArray (1 .. 2);
   Fehlermeldung : TexteArray (1 .. 20);
   Ladezeit : TexteArray (1 .. 32);
   Frage : TexteArray (1 .. 28);
   ZeugSachen : TexteArray (1 .. 67);
   
end GlobaleTexte;
