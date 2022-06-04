pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with MenueDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with SystemKonstanten;
with ForschungenDatentypen;

package GlobaleTexte is
   
   NameBeschreibungMultiplikator : constant Positive := 2;
   WegartenMultiplikator : constant Positive := 3;
   FlussartenMultiplikator : constant Positive := 3;
   
   -------------------- Gibt es einen Weg die Anzahl der Elemente eines Enum subtypes zu erfahren ohne sie selbst zu berechnen?
   RassenAnzahlBeschreibung : constant Positive := NameBeschreibungMultiplikator * 18;
      
   -- type Welcher_Abstand_Enum is (Leer, Kleiner_Abstand, Großer_Abstand, Neue_Zeile);
   
   type SprachenEinlesenArray is array (1 .. 100) of Unbounded_Wide_Wide_String;
   SprachenEinlesen : SprachenEinlesenArray;
   
   FehlenderText : constant Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => " |ÄÖÜ Hier wurde kein Text eingelesen ÜÖÄ| ");
   
   type TexteArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
   
   -- Einfache Auswahl, keine Überschrift und kein Zusatztext.
   -- + 1 beim Hauptmenü, da dort noch auf Wiedersehen eingebaut ist wegen der Terminal.
   Hauptmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Haupt_Menü_Enum)) := (others => FehlenderText);
   Spielmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Spiel_Menü_Enum)) := (others => FehlenderText);
                               
   -- Einfache Auswahl und kein Zusatztext.
   Optionsmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Optionen_Menü_Enum)) := (others => FehlenderText);
   Einstellungsmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Einstellungen_Menü_Enum)) := (others => FehlenderText);
   Editoren : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Editoren_Menü_Enum)) := (others => FehlenderText);
   Sonstigesmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Sonstiges_Menü_Enum)) := (others => FehlenderText);
   Debugmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Debug_Menü_Enum)) := (others => FehlenderText);
                               
   -- Einfache Auswahl.
   Kartengröße : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Kartengröße_Menü_Enum)) := (others => FehlenderText);
   Kartenart : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Kartenart_Menü_Enum)) := (others => FehlenderText);
   Kartentemperatur : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Kartentemperatur_Menü_Enum)) := (others => FehlenderText);
   Rassenauswahl : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Rassen_Menü_Enum)) := (others => FehlenderText);
   Schwierigkeitsgrad : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Schwierigkeitsgrad_Menü_Enum)) := (others => FehlenderText);
   Ressourcenmenge : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Kartenressourcen_Menü_Enum)) := (others => FehlenderText);
                                
   -- Komplexe Auswahl.
   Kartenpole : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Kartenpole_Menü_Enum)) := (others => FehlenderText);
   Kartenform : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Kartenform_Menü_Enum)) := (others => FehlenderText);
   
   
   
   -- Unsortiert.
   Grafikmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Grafik_Menü_Enum)) := (others => FehlenderText);
   Soundmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Sound_Menü_Enum)) := (others => FehlenderText);
   Steuerungmenü : TexteArray (1 .. SystemKonstanten.EndeMenü (MenueDatentypen.Steuerung_Menü_Enum)) := (others => FehlenderText);
   
   

   JaNein : TexteArray (1 .. 2) := (others => FehlenderText);
   
   -- Text im Spiel.
   Rassen : TexteArray (1 .. RassenAnzahlBeschreibung) := (others => FehlenderText);
   
   Kartenfelder : TexteArray (1 .. NameBeschreibungMultiplikator * 29) := (others => FehlenderText);
   Kartenflüsse : TexteArray (1 .. NameBeschreibungMultiplikator * FlussartenMultiplikator * 16) := (others => FehlenderText);
   Kartenressourcen : TexteArray (1 .. NameBeschreibungMultiplikator * 7) := (others => FehlenderText);
   
   Einheiten : TexteArray (1 .. RassenAnzahlBeschreibung * Positive (EinheitenDatentypen.EinheitenID'Last)) := (others => FehlenderText);
   
   --------------------- Hier auch zweimal Enumlänge?
   Verbesserungen : TexteArray (1 .. NameBeschreibungMultiplikator * 8) := (others => FehlenderText);
   Wege : TexteArray (1 .. NameBeschreibungMultiplikator * WegartenMultiplikator * 16) := (others => FehlenderText);
   
   Gebäude : TexteArray (1 .. RassenAnzahlBeschreibung * Positive (StadtDatentypen.GebäudeID'Last)) := (others => FehlenderText);
   Forschungen : TexteArray (1 .. RassenAnzahlBeschreibung * Positive (ForschungenDatentypen.ForschungID'Last)) := (others => FehlenderText);
   Beschäftigungen : TexteArray (1 .. NameBeschreibungMultiplikator * 11) := (others => FehlenderText);
   StädtenamenKI : TexteArray (1 .. 3) := (others => FehlenderText);
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
   Frage : TexteArray (1 .. 44) := (others => FehlenderText);
   Zeug : TexteArray (1 .. 69) := (others => FehlenderText);
   
end GlobaleTexte;
