with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, GlobaleDatentypen;

package Anzeige is
      
   type TextBauenRecord is record
      
      Text : Unbounded_Wide_Wide_String;
      Nummer : Integer;
      
   end record;

   type TextBauenArray is array (GlobaleVariablen.TexteEinlesenArray'First (2) .. 2 * GlobaleVariablen.TexteEinlesenArray'Last (2) + 1) of TextBauenRecord;
   TextBauen : TextBauenArray;

   type TextForschungRecord is record
      
      Text : Unbounded_Wide_Wide_String;
      Nummer : Integer;
      
   end record;
   
   type TextForschungArray is array (GlobaleVariablen.Wichtiges (1).Erforscht'Range) of TextForschungRecord;
   TextForschung : TextForschungArray;

   procedure Anzeige (WelcherText, AktuelleAuswahl : in Integer);
   procedure AnzeigeStadt (AktuelleAuswahl : in Positive);
   procedure AnzeigeLangerText (WelcherText, WelcheZeile : in Positive);
   procedure AnzeigeForschung (AktuelleAuswahl : in Positive);
   procedure RassenBeschreibung (WelcheRasse : in GlobaleDatentypen.Rassen);
   procedure Zeug (WelchesZeug : in Positive);
   procedure Fehlermeldungen (WelcheFehlermeldung : in Positive);
   procedure WelcheAuswahl (WasWurdeGewählt : in Positive);
   procedure TexteEinlesenAusgabe (WelcheDatei, WelcherText : in Positive);

   procedure AnzeigeNeu (AuswahlOderAnzeige : in Boolean; FrageDatei, FrageZeile, TextDatei, ErsteZeile, LetzteZeile : in Integer)     
     with Pre => FrageDatei >= 0 and FrageZeile >= 0 and TextDatei >= 0 and ErsteZeile >= 0 and LetzteZeile >= 0 and ErsteZeile <= LetzteZeile;

private
   
   Taste : Wide_Wide_Character;
      
   LängsterText : Integer := 1;
   Wert : Integer;
   N : Integer;
   
   Teilung : Float;
   
   Text : Wide_Wide_String (1 .. 1_000);

end Anzeige;
