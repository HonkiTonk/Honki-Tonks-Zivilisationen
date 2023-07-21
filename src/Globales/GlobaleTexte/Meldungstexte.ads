with TextKonstanten;
with TextnummernKonstanten;
with TextArrays;

package Meldungstexte is
   pragma Elaborate_Body;
   
   Zeug : TextArrays.AllgemeinesTextArray (TextnummernKonstanten.ZeugVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   Frage : TextArrays.AllgemeinesTextArray (TextnummernKonstanten.FragenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   Meldung : TextArrays.AllgemeinesTextArray (TextnummernKonstanten.SpielmeldungenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   
   ZeugLängstes : TextArrays.AllgemeinesTextArray (Zeug'Range) := (others => TextKonstanten.FehlenderText);
   FrageLängstes : TextArrays.AllgemeinesTextArray (Frage'Range) := (others => TextKonstanten.FehlenderText);
   MeldungLängstes : TextArrays.AllgemeinesTextArray (Meldung'Range) := (others => TextKonstanten.FehlenderText);
   
end Meldungstexte;
