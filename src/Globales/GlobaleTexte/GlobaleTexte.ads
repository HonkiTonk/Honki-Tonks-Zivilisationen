pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with EinheitStadtDatentypen;
with SystemKonstanten;

package GlobaleTexte is
      
   -- type Welcher_Abstand_Enum is (Leer, Kleiner_Abstand, Großer_Abstand, Neue_Zeile);
   
   type SprachenEinlesenArray is array (1 .. 100) of Unbounded_Wide_Wide_String;
   SprachenEinlesen : SprachenEinlesenArray;
   
   -------------------- Gibt es einen Weg die Anzahl der Elemente eines Enum subtypes zu erfahren ohne sie selbst zu berechnen?
   RassenAnzahlDoppelt : constant Positive := 2 * 18;
   
   FehlenderText : constant Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => " |ÄÖÜ Hier wurde kein Text eingelesen ÜÖÄ| ");
   
   type TexteArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
   
   -- Plus eins beim Hauptmenü, da dort noch auf Wiedersehen eingebaut ist wegen der Konsole.
   Hauptmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Haupt_Menü_Enum) + 1) := (others => FehlenderText);
   Spielmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Spiel_Menü_Enum)) := (others => FehlenderText);
   
   
   Optionsmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Optionen_Menü_Enum)) := (others => FehlenderText);
   Einstellungsmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Einstellungen_Menü_Enum)) := (others => FehlenderText);
   Editoren : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Editoren_Menü_Enum)) := (others => FehlenderText);
   
   Grafikmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Grafik_Menü_Enum)) := (others => FehlenderText);
   Soundmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Sound_Menü_Enum)) := (others => FehlenderText);
   Steuerungmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Steuerung_Menü_Enum)) := (others => FehlenderText);
   Sonstigesmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Sonstiges_Menü_Enum)) := (others => FehlenderText);
   
   Kartengröße : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Kartengröße_Menü_Enum)) := (others => FehlenderText);
   Kartenart : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Kartenart_Menü_Enum)) := (others => FehlenderText);
   Kartentemperatur : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Kartentemperatur_Menü_Enum)) := (others => FehlenderText);
   Rassenauswahl : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Rassen_Menü_Enum)) := (others => FehlenderText);
   Schwierigkeitsgrad : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Schwierigkeitsgrad_Menü_Enum)) := (others => FehlenderText);
   Kartenform : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Kartenform_Menü_Enum)) := (others => FehlenderText);
   Ressourcenmenge : TexteArray (1 .. SystemKonstanten.EndeMenü (SystemDatentypen.Kartenressourcen_Menü_Enum)) := (others => FehlenderText);

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
   
end GlobaleTexte;
