pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package Spieltexte is

   -- Das hier mal in irgendeine globale Datentypdatei auslagern und dann für alle Texte die Unbounded String verwenden nutzen? äöü
   type TexteArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
   
   IntroEnde : constant Positive := 1;
   OutroEnde : constant Positive := 4;
   
   Intro : TexteArray (1 .. IntroEnde);
   Outro : TexteArray (1 .. OutroEnde);

end Spieltexte;