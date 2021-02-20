pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Text_IO;
use Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Text_IO;

with GlobaleVariablen, GlobaleDatentypen;

package Anzeige is
   
   type TextBauenRecord is record
      
      Text : Unbounded_Wide_Wide_String;
      Nummer : Integer;
      
   end record;

   type TextBauenArray is array (GlobaleVariablen.TexteEinlesenNeuArray'First (2) .. 2 * GlobaleVariablen.TexteEinlesenNeuArray'Last (2) + 1) of TextBauenRecord;
   TextBauen : TextBauenArray;

   type TextForschungRecord is record
      
      Text : Unbounded_Wide_Wide_String;
      Nummer : Integer;
      
   end record;
   
   type TextForschungArray is array (GlobaleVariablen.Wichtiges (1).Erforscht'Range) of TextForschungRecord;
   TextForschung : TextForschungArray;

   procedure AnzeigeStadt (AktuelleAuswahl : in Positive);
   procedure AnzeigeLangerText (WelcherText, WelcheZeile : in Positive);
   procedure AnzeigeForschung (AktuelleAuswahl : in Positive);

   procedure AnzeigeOhneAuswahlNeu;

   procedure AnzeigeOhneAuswahl (ÜberschriftDatei, ÜberschriftZeile, TextDatei, ErsteZeile, LetzteZeile : Natural ; MitNew_LineMittendrin : in Integer; MitNew_LineAmEnde : in Ada.Wide_Wide_Text_IO.Count) with
     Pre => (ErsteZeile <= LetzteZeile and (if ÜberschriftDatei = 0 then ÜberschriftZeile = 0) and (if ÜberschriftZeile = 0 then ÜberschriftDatei = 0));

   procedure EinzeiligeAnzeigeOhneAuswahl (TextDatei, TextZeile : in Positive);

   procedure AnzeigeMitAuswahl (FrageDatei, FrageZeile, TextDatei, ErsteZeile, LetzteZeile, AktuelleAuswahl : in Natural) with
     Pre => (ErsteZeile <= LetzteZeile and (if FrageDatei = 0 then FrageZeile = 0) and (if FrageZeile = 0 then FrageDatei = 0));

   procedure FehlerAnzeigen (FehlerNummer : in Positive);

   -- Dateien nicht einfach ändern!!!
   -- Datei 0 = 0, sollte niemals von Anzeige aufgerufen werden!
   -- Datei 1 = 1Start
   -- Datei 2 = 2FesteAbfragen
   -- Datei 3 = 3SpielEinstellungen
   -- Datei 4 = 4Rassenbeschreibung
   -- Datei 5 = 5MenueAuswahl
   -- Datei 6 = 6BeschreibungenKartenfelderKurz
   -- Datei 7 = 7BeschreibungenKartenfelderLang
   -- Datei 8 = 8Fehlermeldungen
   -- Datei 9 = 9Zeug
   -- Datei 10 = 10Fragen
   -- Datei 11 = 11Ladezeiten
   -- Datei 12 = 12BeschreibungenEinheitenKurz
   -- Datei 13 = 13BeschreibungenEinheitenLang
   -- Datei 14 = 14BeschreibungenVerbesserungenKurz
   -- Datei 15 = 15BeschreibungenVerbesserungenLang
   -- Datei 16 = 16BeschreibungenGebäudeKurz
   -- Datei 17 = 17BeschreibungenGebäudeLang
   -- Datei 18 = 18BeschreibungenForschungKurz
   -- Datei 19 = 19BeschreibungenForschungLang
   -- Datei 20 = 20BeschreibungenBeschäftigungKurz
   -- Datei 21 = 21BeschreibungenBeschäftigungLang
   -- Datei 22 = 22StädtenamenKI

private
   
   Taste : Wide_Wide_Character;
      
   LängsterText : Integer := 1;
   Wert : Integer;
   N : Integer;
   
   Teilung : Float;
   
   Text : Wide_Wide_String (1 .. 1_000);
   
   type WelcheDateienWelcheTexteRecord is record
            
      TextDatei : GlobaleDatentypen.TextDateien;

      TextAnfangZeile : GlobaleDatentypen.TextZeilen;
      TextEndeZeile : GlobaleDatentypen.TextZeilen;
      
   end record;
   
   type WelcheDateienWelcheTexteArray is array (0 .. 21, 0 .. 84) of WelcheDateienWelcheTexteRecord;
   WelcheDateienWelcheTexte : constant WelcheDateienWelcheTexteArray := (others => (others => (0, 0, 0)));

end Anzeige;
