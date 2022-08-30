pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextKonstanten;

package Kartentexte is
   
   NameBeschreibungMultiplikator : constant Positive := 2;
   WegartenMultiplikator : constant Positive := 3;
   FlussartenMultiplikator : constant Positive := 3;

   type TexteArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
      
   Kartenfelder : TexteArray (1 .. NameBeschreibungMultiplikator * 29) := (others => TextKonstanten.FehlenderText);
   Kartenflüsse : TexteArray (1 .. NameBeschreibungMultiplikator * FlussartenMultiplikator * 16) := (others => TextKonstanten.FehlenderText);
   Kartenressourcen : TexteArray (1 .. NameBeschreibungMultiplikator * 7) := (others => TextKonstanten.FehlenderText);
   
   -- Hier auch zweimal Enumlänge? äöü
   Verbesserungen : TexteArray (1 .. NameBeschreibungMultiplikator * 5) := (others => TextKonstanten.FehlenderText);
   Wege : TexteArray (1 .. NameBeschreibungMultiplikator * WegartenMultiplikator * 16) := (others => TextKonstanten.FehlenderText);

end Kartentexte;
