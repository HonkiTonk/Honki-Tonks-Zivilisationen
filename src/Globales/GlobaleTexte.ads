pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; 
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleDatentypen;
use GlobaleDatentypen;

package GlobaleTexte is
   
   -- Für Rassentexte
   type Rassen_Text_Enum is (Nicht_Vorhanden, Beschreibung, Einheiten_Kurz, Einheiten_Lang, Forschung_Ermöglicht, Forschung_Kurz, Forschung_Lang, Gebäude_Kurz, Gebäude_Lang);
   
   for Rassen_Text_Enum use (Nicht_Vorhanden => 0, Beschreibung => 1, Einheiten_Kurz => 2, Einheiten_Lang => 3, Forschung_Ermöglicht => 4, Forschung_Kurz => 5, Forschung_Lang => 6, Gebäude_Kurz => 7, Gebäude_Lang => 8);
   
   subtype Rassen_Text_Existiert_Enum is Rassen_Text_Enum range Beschreibung .. Gebäude_Lang;
   
   type TexteRassenEinlesenArray is array (GlobaleDatentypen.Rassen'Range,
                                           Rassen_Text_Existiert_Enum'Range,
                                           GlobaleDatentypen.KartenverbesserungEinheitenID'First + 1 .. GlobaleDatentypen.KartenverbesserungEinheitenID'Last)of Unbounded_Wide_Wide_String;
   TexteRassenEinlesen : TexteRassenEinlesenArray := (others => (others => (others => To_Unbounded_Wide_Wide_String (Source => "|"))));
   -- Für Rassentexte
   
   
   
   -- Für Spieleinstellungen
   type Spieleinstellungen_Text_Enum is (Nicht_Vorhanden, Spieleinstellungen_Größe, Spieleinstellungen_Kartenart, Spieleinstellungen_Kartentemperatur, Spieleinstellungen_Rassennamen,
                                         Spieleinstellungen_Schwierigkeitsgrad, Spieleinstellungen_Spieleranzahl);
   
   for Spieleinstellungen_Text_Enum use (Nicht_Vorhanden => 0, Spieleinstellungen_Größe => 1, Spieleinstellungen_Kartenart => 2, Spieleinstellungen_Kartentemperatur => 3, Spieleinstellungen_Rassennamen => 4,
                                         Spieleinstellungen_Schwierigkeitsgrad => 5, Spieleinstellungen_Spieleranzahl => 6);
   
   subtype Spieleinstellungen_Text_Existiert_Enum is Spieleinstellungen_Text_Enum range Spieleinstellungen_Größe .. Spieleinstellungen_Spieleranzahl;
   
   type TexteSpieleinstellungenArray is array (Spieleinstellungen_Text_Existiert_Enum'Range, 1 .. 22) of Unbounded_Wide_Wide_String;
   TexteSpieleinstellungen : TexteSpieleinstellungenArray := (others => (others => To_Unbounded_Wide_Wide_String (Source => "|")));
   -- Für Spieleinstellungen
   
   
   
   -- Für Optionen
   type Optionen_Text_Enum is (Nicht_Vorhanden, Optionen_Allgemein, Optionen_Sonstiges, Optionen_Steuerung);
   
   for Optionen_Text_Enum use (Nicht_Vorhanden => 0, Optionen_Allgemein => 1, Optionen_Sonstiges => 2, Optionen_Steuerung => 3);
   
   subtype Optionen_Text_Existiert_Enum is Optionen_Text_Enum range Optionen_Allgemein .. Optionen_Steuerung;
   
   type TexteOptionenArray is array (Optionen_Text_Existiert_Enum'Range, 1 .. 43) of Unbounded_Wide_Wide_String;
   TexteOptionen : TexteOptionenArray := (others => (others => To_Unbounded_Wide_Wide_String (Source => "|")));
   -- Für Optionen
   
   
   
   -- Für Alles Andere
   type Alles_Andere_Text_Enum is (Nicht_Vorhanden, Allgemeine_Informationen, Beschäftigung_Kurz, Beschäftigung_Lang, Cheat_Menü, Fehlermeldungen, Feste_Abfragen, Fragen, Ja_Nein, Kartenfelder_Kurz,
                                   Kartenfelder_Lang, Ladezeiten, Menüauswahl, Rassen_Beschreibung, Städtenamen_KI, Start, Verbesserungen_Kurz, Verbesserungen_Lang, Würdigungen, Zeug);
   
   for Alles_Andere_Text_Enum use (Nicht_Vorhanden => 0, Allgemeine_Informationen => 1, Beschäftigung_Kurz => 2, Beschäftigung_Lang => 3, Cheat_Menü => 4, Fehlermeldungen => 5, Feste_Abfragen => 6, Fragen => 7,
                                   Ja_Nein => 8, Kartenfelder_Kurz => 9, Kartenfelder_Lang => 10, Ladezeiten => 11, Menüauswahl => 12, Rassen_Beschreibung => 13, Städtenamen_KI => 14, Start => 15,
                                   Verbesserungen_Kurz => 16, Verbesserungen_Lang => 17, Würdigungen => 18, Zeug => 19);
   
   subtype Alles_Andere_Text_Existiert_Enum is Alles_Andere_Text_Enum range Allgemeine_Informationen .. Zeug;
   
   type TexteAllesAndereArray is array (Alles_Andere_Text_Existiert_Enum'Range, 1 .. 50) of Unbounded_Wide_Wide_String;
   TexteAllesAndere : TexteAllesAndereArray := (others => (others => To_Unbounded_Wide_Wide_String (Source => "|")));
   -- Für Alles Andere
   
   
   
   type SprachenEinlesenArray is array (1 .. 100) of Unbounded_Wide_Wide_String;
   SprachenEinlesen : SprachenEinlesenArray;

end GlobaleTexte;
