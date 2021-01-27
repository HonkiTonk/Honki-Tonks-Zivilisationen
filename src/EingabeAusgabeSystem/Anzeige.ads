with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

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

   procedure AnzeigeNeu (AuswahlOderAnzeige : in Boolean; AktuelleAuswahl, FrageDatei, FrageZeile, TextDatei, ErsteZeile, LetzteZeile : in Natural) with
     Pre => ErsteZeile <= LetzteZeile;

   procedure EinfacheAnzeige (Mit_Line : in Boolean; Datei, Eintrag : in Positive);

private
   
   Taste : Wide_Wide_Character;
      
   LängsterText : Integer := 1;
   Wert : Integer;
   N : Integer;
   
   Teilung : Float;
   
   Text : Wide_Wide_String (1 .. 1_000);
 
   type Test is record
      
      Zieldatei : Positive;
      Zielzeile : Positive;
      
   end record;
   
   type JaArray is array (1 .. 3, 1 .. 18) of Test;
   -- 1 = Wachstum, 2 = BewegungssystemCursor, 3 = KarteStadt
   Ja : constant JaArray := (1 => (1 => (9, 29), others => (100, 100)),
                             2 => (1 => (9, 30), 2 => (9, 31), others => (100, 100)),
                             3 => (1 => (9, 34), 2 => (9, 20), 3 => (9, 21), 4 => (9, 22), 5 => (9, 23), 6 => (9, 1), 7 => (9, 2), 8 => (9, 3), 9 => (9, 4), 10 => (9, 5),
                                   11 => (9, 6), 12 => (9, 7), 13 => (9, 8), 14 => (9, 9), 15 => (9, 10), 16 => (9, 11), 17 => (9, 12), 18 => (9, 28), others => (100, 100)));



   type WelcheDateienWelcheTexteRecord is record
            
      TextDatei : GlobaleDatentypen.TextDateien;

      TextAnfangZeile : GlobaleDatentypen.TextZeilen;
      TextEndeZeile : GlobaleDatentypen.TextZeilen;
      
   end record;
   
   type WelcheDateienWelcheTexteArray is array (0 .. 21, 0 .. 84) of WelcheDateienWelcheTexteRecord;
   WelcheDateienWelcheTexte : constant WelcheDateienWelcheTexteArray := (others => (others => (0, 0, 0)));

end Anzeige;
