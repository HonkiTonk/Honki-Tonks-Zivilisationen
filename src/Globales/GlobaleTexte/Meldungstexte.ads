with TextKonstanten;
with TextnummernKonstanten;
with TextArrays;

package Meldungstexte is
   pragma Elaborate_Body;
   
   -- beim Umbenennen auch gleich mal alles rauswerfen was ich nicht brauche. äöü
   Zeug : TextArrays.AllgemeinesTextArray (TextnummernKonstanten.ZeugVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   Frage : TextArrays.AllgemeinesTextArray (TextnummernKonstanten.FragenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   -- Das hier im speziellen und den Rest im allgemeinen noch einmal besser benennen. äöü
   Meldung : TextArrays.AllgemeinesTextArray (TextnummernKonstanten.SpielmeldungenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   
   Würdigung : TextArrays.AllgemeinesTextArray (1 .. 3) := (others => TextKonstanten.FehlenderText);
   
end Meldungstexte;
