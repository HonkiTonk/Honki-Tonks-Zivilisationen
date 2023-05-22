with TextKonstanten;
with SystemDatentypen;
with TextArrays;

package Meldungstexte is
   pragma Elaborate_Body;
      
   Zeug : TextArrays.TexteArray (SystemDatentypen.ZeugVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   Frage : TextArrays.TexteArray (SystemDatentypen.FragenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   Meldung : TextArrays.TexteArray (SystemDatentypen.SpielmeldungenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   
end Meldungstexte;
