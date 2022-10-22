pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextKonstanten;

package GlobaleTexte is
   
   NameBeschreibungMultiplikator : constant Positive := 2;
      
   type TexteArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
   
   SprachenEinlesen : TexteArray (1 .. 100);
            
   Beschäftigungen : TexteArray (1 .. NameBeschreibungMultiplikator * 11) := (others => TextKonstanten.FehlenderText);
   AllgemeineInformationen : TexteArray (1 .. 16) := (others => TextKonstanten.FehlenderText);
   Würdigung : TexteArray (1 .. 1) := (others => TextKonstanten.FehlenderText);
   DiplomatieKI : TexteArray (1 .. 3) := (others => TextKonstanten.FehlenderText);
   Handelsmenü : TexteArray (1 .. 10) := (others => TextKonstanten.FehlenderText);
   DiplomatieStatus : TexteArray (1 .. 4) := (others => TextKonstanten.FehlenderText);
   Angebot : TexteArray (1 .. 2) := (others => TextKonstanten.FehlenderText);
   Ladezeit : TexteArray (1 .. 15) := (others => TextKonstanten.FehlenderText);
   
end GlobaleTexte;
