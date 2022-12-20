with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with TextKonstanten;
with SystemDatentypen;

package Meldungstexte is
   pragma Elaborate_Body;
      
   type TexteArray is array (Positive range <>) of Unbounded_Wide_Wide_String;
      
   Zeug : TexteArray (SystemDatentypen.ZeugVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   Frage : TexteArray (SystemDatentypen.FragenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   Meldung : TexteArray (SystemDatentypen.SpielmeldungenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   
end Meldungstexte;
