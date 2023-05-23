with TextKonstanten;
with SystemDatentypen;
with TextArrays;

package Meldungstexte is
   pragma Elaborate_Body;
      
   Zeug : TextArrays.AllgemeinesTextArray (SystemDatentypen.ZeugVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   Frage : TextArrays.AllgemeinesTextArray (SystemDatentypen.FragenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   Meldung : TextArrays.AllgemeinesTextArray (SystemDatentypen.SpielmeldungenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   
end Meldungstexte;
