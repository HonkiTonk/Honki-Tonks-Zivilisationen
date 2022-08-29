pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextKonstanten;

package GlobaleTexte is
   
   NameBeschreibungMultiplikator : constant Positive := 2;
   WegartenMultiplikator : constant Positive := 3;
   FlussartenMultiplikator : constant Positive := 3;
   
   
   
   type TexteArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
   
   SprachenEinlesen : TexteArray (1 .. 100);
      
   Kartenfelder : TexteArray (1 .. NameBeschreibungMultiplikator * 29) := (others => TextKonstanten.FehlenderText);
   Kartenflüsse : TexteArray (1 .. NameBeschreibungMultiplikator * FlussartenMultiplikator * 16) := (others => TextKonstanten.FehlenderText);
   Kartenressourcen : TexteArray (1 .. NameBeschreibungMultiplikator * 7) := (others => TextKonstanten.FehlenderText);
   
   -- Hier auch zweimal Enumlänge? äöü
   Verbesserungen : TexteArray (1 .. NameBeschreibungMultiplikator * 5) := (others => TextKonstanten.FehlenderText);
   Wege : TexteArray (1 .. NameBeschreibungMultiplikator * WegartenMultiplikator * 16) := (others => TextKonstanten.FehlenderText);
   
   Beschäftigungen : TexteArray (1 .. NameBeschreibungMultiplikator * 11) := (others => TextKonstanten.FehlenderText);
   AllgemeineInformationen : TexteArray (1 .. 16) := (others => TextKonstanten.FehlenderText);
   Würdigung : TexteArray (1 .. 1) := (others => TextKonstanten.FehlenderText);
   DiplomatieKI : TexteArray (1 .. 3) := (others => TextKonstanten.FehlenderText);
   Endmeldungen : TexteArray (1 .. 3) := (others => TextKonstanten.FehlenderText);
   Handelsmenü : TexteArray (1 .. 10) := (others => TextKonstanten.FehlenderText);
   DiplomatieStatus : TexteArray (1 .. 4) := (others => TextKonstanten.FehlenderText);
   Angebot : TexteArray (1 .. 2) := (others => TextKonstanten.FehlenderText);
   Fehlermeldung : TexteArray (1 .. 20) := (others => TextKonstanten.FehlenderText);
   Ladezeit : TexteArray (1 .. 16) := (others => TextKonstanten.FehlenderText);
   Frage : TexteArray (1 .. 45) := (others => TextKonstanten.FehlenderText);
   Zeug : TexteArray (1 .. 76) := (others => TextKonstanten.FehlenderText);
   
end GlobaleTexte;
