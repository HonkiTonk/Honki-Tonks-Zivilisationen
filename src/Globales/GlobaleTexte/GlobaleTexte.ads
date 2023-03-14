with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextKonstanten;
with SystemDatentypen;

package GlobaleTexte is
   pragma Elaborate_Body;
   
   NameBeschreibungMultiplikator : constant Positive := 2;
      
   type TexteArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
   
   SprachenEinlesen : TexteArray (1 .. 100);
            
   Beschäftigungen : TexteArray (1 .. NameBeschreibungMultiplikator * 12) := (others => TextKonstanten.FehlenderText);
   Würdigung : TexteArray (1 .. 1) := (others => TextKonstanten.FehlenderText);
   DiplomatieKI : TexteArray (1 .. 3) := (others => TextKonstanten.FehlenderText);
   Handelsmenü : TexteArray (1 .. 10) := (others => TextKonstanten.FehlenderText);
   DiplomatieStatus : TexteArray (1 .. 4) := (others => TextKonstanten.FehlenderText);
   Angebot : TexteArray (1 .. 2) := (others => TextKonstanten.FehlenderText);
   Ladezeit : TexteArray (SystemDatentypen.LadezeitVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   
end GlobaleTexte;
