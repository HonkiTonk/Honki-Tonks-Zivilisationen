pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package Anzeige is
   
   type TextBauenRecord is record
      
      Text : Unbounded_Wide_Wide_String;
      Nummer : Natural;
      
   end record;

   type TextBauenNeuArray is array (GlobaleDatentypen.KartenverbesserungEinheitenID'First + 1 .. GlobaleDatentypen.KartenverbesserungEinheitenID'Last) of TextBauenRecord;
   TextBauenNeu : TextBauenNeuArray;



   type TextForschungRecord is record
      
      Text : Unbounded_Wide_Wide_String;
      Nummer : Natural;
      
   end record;
   
   type TextForschungArray is array (GlobaleVariablen.Wichtiges (1).Erforscht'Range) of TextForschungRecord;
   TextForschung : TextForschungArray;

   procedure AnzeigeStadt (AktuelleAuswahl : in Positive);
   procedure AnzeigeLangerTextNeu (ÜberschriftDatei, TextDatei : in GlobaleDatentypen.WelcheDatei_Enum; ÜberschriftZeile : in Natural; ErsteZeile, LetzteZeile : in Positive;
                                   AbstandAnfang, AbstandEnde : in GlobaleDatentypen.WelcherAbstand_Enum) with
     Pre => (ErsteZeile <= LetzteZeile and (if ÜberschriftDatei = GlobaleDatentypen.Leer then ÜberschriftZeile = 0) and (if ÜberschriftZeile = 0 then ÜberschriftDatei = GlobaleDatentypen.Leer)
             and TextDatei /= GlobaleDatentypen.Leer);

   procedure AnzeigeForschung (AktuelleAuswahl : in Positive);
   procedure AnzeigeSprache (AktuelleAuswahl, ErsteZeile, LetzteZeile : in Positive);

   procedure AnzeigeOhneAuswahlNeu (ÜberschriftDatei, TextDatei : in GlobaleDatentypen.WelcheDatei_Enum; ÜberschriftZeile : in Natural; ErsteZeile, LetzteZeile : in Positive;
                                    AbstandAnfang, AbstandMitte, AbstandEnde : in GlobaleDatentypen.WelcherAbstand_Enum) with
     Pre => (ErsteZeile <= LetzteZeile and (if ÜberschriftDatei = GlobaleDatentypen.Leer then ÜberschriftZeile = 0) and (if ÜberschriftZeile = 0 then ÜberschriftDatei = GlobaleDatentypen.Leer)
             and TextDatei /= GlobaleDatentypen.Leer);

   procedure EinzeiligeAnzeigeOhneAuswahl (TextDatei : in GlobaleDatentypen.WelcheDatei_Enum; TextZeile : in Positive);

   procedure AnzeigeMitAuswahlNeu (FrageDatei, TextDatei : in GlobaleDatentypen.WelcheDatei_Enum; FrageZeile, ErsteZeile, LetzteZeile, AktuelleAuswahl : in Natural) with
     Pre => (ErsteZeile <= LetzteZeile and (if FrageDatei = GlobaleDatentypen.Leer then FrageZeile = 0) and (if FrageZeile = 0 then FrageDatei = GlobaleDatentypen.Leer) and TextDatei /= GlobaleDatentypen.Leer);

   -- Bei Änderung der Dateien GlobaleDatentypen.WelcheDatei_Enum beachten!
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

   Zeichengrenze : constant Positive := 100;
      
   LängsterText : Integer;
   Wert : Integer;
   N : Integer;
   
   Teilung : Float;

   TextNeu : Unbounded_Wide_Wide_String;
   
   type WelcheDateienWelcheTexteRecord is record
            
      TextDatei : GlobaleDatentypen.TextDateien;

      TextAnfangZeile : GlobaleDatentypen.TextZeilen;
      TextEndeZeile : GlobaleDatentypen.TextZeilen;
      
   end record;
   
   type WelcheDateienWelcheTexteArray is array (0 .. 21, 0 .. 84) of WelcheDateienWelcheTexteRecord;
   WelcheDateienWelcheTexte : constant WelcheDateienWelcheTexteArray := (others => (others => (0, 0, 0)));

end Anzeige;
