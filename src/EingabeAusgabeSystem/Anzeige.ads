with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, GlobaleVariablen;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

package Anzeige is
   
   procedure Anzeige (WelcherText, AktuelleAuswahl : in Integer);
   procedure AnzeigeStadt (AktuelleAuswahl : in Integer);
   procedure AnzeigeLangerText (WelcherText, WelcheZeile : in Integer);
   procedure AnzeigeForschung (AktuelleAuswahl : in Integer);

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

private
   
   Taste : Wide_Wide_Character;
      
   LängsterText : Integer := 1;
   Wert : Integer;
   N : Integer;
   
   Teilung : Float;
   
   Text : Wide_Wide_String (1 .. 1000);

end Anzeige;
