pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextKonstanten;

package Meldungstexte is
      
   type TexteArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
      
   Zeug : TexteArray (1 .. 76) := (others => TextKonstanten.FehlenderText);
   Frage : TexteArray (1 .. 46) := (others => TextKonstanten.FehlenderText);
   Meldung : TexteArray (1 .. 15) := (others => TextKonstanten.FehlenderText);
   
end Meldungstexte;
