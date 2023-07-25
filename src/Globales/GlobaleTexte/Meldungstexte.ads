with TextKonstanten;
with TextnummernKonstanten;
with TextArrays;

package Meldungstexte is
   pragma Elaborate_Body;
   
   Zeug : TextArrays.AllgemeinesTextArray (TextnummernKonstanten.ZeugVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   Frage : TextArrays.AllgemeinesTextArray (TextnummernKonstanten.FragenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   Meldung : TextArrays.AllgemeinesTextArray (TextnummernKonstanten.SpielmeldungenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   
end Meldungstexte;
