with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

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

   procedure AnzeigeNeu (AuswahlOderAnzeige : in Boolean; AktuelleAuswahl, FrageDatei, FrageZeile, TextDatei, ErsteZeile, LetzteZeile : in Natural) with
     Pre => ErsteZeile <= LetzteZeile;

private
   
   Taste : Wide_Wide_Character;
      
   LängsterText : Integer := 1;
   Wert : Integer;
   N : Integer;
   
   Teilung : Float;
   
   Text : Wide_Wide_String (1 .. 1_000);

end Anzeige;
