pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with EinheitStadtDatentypen;
with TextKonstanten;

package GlobaleTexte is

   ------------------- Die foglenden zwei Enums werden später eh gelöscht/ersetzt, also kann ich mir das Hinzufügen von _Enum hier sparen.
   type Welche_Datei_Enum is (Leer, Start, Feste_Abfragen, Spiel_Einstellungen, Rassen_Beschreibung_Lang, Menü_Auswahl, Beschreibungen_Kartenfelder_Kurz, Beschreibungen_Kartenfelder_Lang, Fehlermeldungen, Zeug,
                              Fragen, Ladezeiten, Beschreibungen_Einheiten_Kurz, Beschreibungen_Einheiten_Lang, Beschreibungen_Verbesserungen_Kurz, Beschreibungen_Verbesserungen_Lang, Beschreibungen_Gebäude_Kurz,
                              Beschreibungen_Gebäude_Lang, Beschreibungen_Forschung_Kurz, Beschreibungen_Forschung_Lang, Beschreibungen_Beschäftigung_Kurz, Beschreibungen_Beschäftigung_Lang, Städtenamen_KI, Cheat_Menü,
                              Rassen_Beschreibung_Kurz, Beschreibung_Forschung_Ermöglicht, Allgemeine_Informationen, Würdigungen, Diplomatie, Diplomatie_KI, Gewonnen, Handeln);
   
   type Welcher_Abstand_Enum is (Leer, Kleiner_Abstand, Großer_Abstand, Neue_Zeile);
   
   type SprachenEinlesenArray is array (1 .. 100) of Unbounded_Wide_Wide_String;
   SprachenEinlesen : SprachenEinlesenArray;

   type TexteEinlesenArray is array (1 .. SystemDatentypen.TextDateien'Last, 1 .. 93) of Unbounded_Wide_Wide_String;
   TexteEinlesen : TexteEinlesenArray := (others => (others => TextKonstanten.LeerUnboundedString));
   
   -------------------- Gibt es einen Weg die Anzahl der Elemente eines Enum subtypes zu erfahren ohne sie selbst zu berechnen?
   RassenAnzahlDoppelt : constant Positive := 2 * 18;
   
   FehlenderText : constant Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => " |ÄÖÜ Hier wurde kein Text eingelesen ÜÖÄ| ");
   
   type TexteArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
   
   Hauptmenü : TexteArray (1 .. 7) := (others => FehlenderText);
   Spielmenü : TexteArray (1 .. 7) := (others => FehlenderText);
   
   Optionsmenü : TexteArray (1 .. 8) := (others => FehlenderText);
   
   Grafikmenü : TexteArray (1 .. 15) := (others => FehlenderText);
   Soundmenü : TexteArray (1 .. 7) := (others => FehlenderText);
   Steuerungmenü : TexteArray (1 .. 91) := (others => FehlenderText);
   Sonstigesmenü : TexteArray (1 .. 13) := (others => FehlenderText);
   Kartengröße : TexteArray (1 .. 31) := (others => FehlenderText);
   Kartenart : TexteArray (1 .. 19) := (others => FehlenderText);
   Kartentemperatur : TexteArray (1 .. 19) := (others => FehlenderText);
   Rassenauswahl : TexteArray (1 .. 47) := (others => FehlenderText);
   Schwierigkeitsgrad : TexteArray (1 .. 15) := (others => FehlenderText);
   Kartenform : TexteArray (1 .. 27) := (others => FehlenderText);
   Ressourcenmenge : TexteArray (1 .. 19) := (others => FehlenderText);
   JaNein : TexteArray (1 .. 2) := (others => FehlenderText);
   Rassen : TexteArray (1 .. RassenAnzahlDoppelt) := (others => FehlenderText);
   
   --------------------- Könnte man hier nicht auch zweimal die Ranges der jeweiligen Enums als Länge angeben?
   Kartenfelder : TexteArray (1 .. 160) := (others => FehlenderText);
   Kartenflüsse : TexteArray (1 .. 96) := (others => FehlenderText);
   Kartenressourcen : TexteArray (1 .. 14) := (others => FehlenderText);
   
   Einheiten : TexteArray (1 .. RassenAnzahlDoppelt * Positive (EinheitStadtDatentypen.EinheitenID'Last)) := (others => FehlenderText);
   
   --------------------- Hier auch zweimal Enumlänge?
   Verbesserungen : TexteArray (1 .. 16) := (others => FehlenderText);
   Wege : TexteArray (1 .. 32) := (others => FehlenderText);
   
   Gebäude : TexteArray (1 .. RassenAnzahlDoppelt * Positive (EinheitStadtDatentypen.GebäudeID'Last)) := (others => FehlenderText);
   Forschungen : TexteArray (1 .. RassenAnzahlDoppelt * Positive (EinheitStadtDatentypen.ForschungID'Last)) := (others => FehlenderText);
   Beschäftigungen : TexteArray (1 .. 18) := (others => FehlenderText);
   StädtenamenKI : TexteArray (1 .. 3) := (others => FehlenderText);
   Debugmenü : TexteArray (1 .. 3) := (others => FehlenderText);
   AllgemeineInformationen : TexteArray (1 .. 16) := (others => FehlenderText);
   Würdigung : TexteArray (1 .. 1) := (others => FehlenderText);
   Diplomatiemenü : TexteArray (1 .. 7) := (others => FehlenderText);
   DiplomatieKI : TexteArray (1 .. 3) := (others => FehlenderText);
   Endmeldungen : TexteArray (1 .. 3) := (others => FehlenderText);
   Handelsmenü : TexteArray (1 .. 10) := (others => FehlenderText);
   DiplomatieStatus : TexteArray (1 .. 4) := (others => FehlenderText);
   Angebot : TexteArray (1 .. 2) := (others => FehlenderText);
   Fehlermeldung : TexteArray (1 .. 20) := (others => FehlenderText);
   Ladezeit : TexteArray (1 .. 32) := (others => FehlenderText);
   Frage : TexteArray (1 .. 35) := (others => FehlenderText);
   ZeugSachen : TexteArray (1 .. 67) := (others => FehlenderText);
   Editoren : TexteArray (1 .. 17) := (others => FehlenderText);
   
end GlobaleTexte;
