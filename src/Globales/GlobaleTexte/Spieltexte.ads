with TextKonstanten;
with TextnummernKonstanten;
with TextArrays;
with AufgabenDatentypen;

package Spieltexte is
   pragma Elaborate_Body;
   
   -- Beim Umbenennen auch gleich mal alles rauswerfen was ich nicht brauche. äöü
   Zeug : TextArrays.AllgemeinesTextArray (TextnummernKonstanten.ZeugVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   Fragen : TextArrays.AllgemeinesTextArray (TextnummernKonstanten.FragenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   -- Das hier im speziellen und den Rest im allgemeinen noch einmal besser benennen. äöü
   Meldungen : TextArrays.AllgemeinesTextArray (TextnummernKonstanten.SpielmeldungenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   
   Stadtbefehle : TextArrays.AllgemeinesTextArray (1 .. 6) := (others => TextKonstanten.FehlenderText);
   Beschäftigungen : TextArrays.AllgemeinesTextArray (1 .. 2 * (AufgabenDatentypen.Einheiten_Aufgaben_Enum'Pos (AufgabenDatentypen.Einheiten_Aufgaben_Enum'Last) + 1)) := (others => TextKonstanten.FehlenderText);
   
   Ladezeit : TextArrays.AllgemeinesTextArray (TextnummernKonstanten.LadezeitVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   
   Würdigung : TextArrays.AllgemeinesTextArray (1 .. 3) := (others => TextKonstanten.FehlenderText);
   
end Spieltexte;
