with ArraysHTSEB;
with TextKonstantenHTSEB;

with TextnummernKonstanten;
with AufgabenDatentypen;

package Spieltexte is
   pragma Elaborate_Body;
   
   -- Beim Umbenennen auch gleich mal alles rauswerfen was ich nicht brauche. äöü
   Fragen : ArraysHTSEB.AllgemeinesTextArray (TextnummernKonstanten.FragenVorhanden'Range) := (others => TextKonstantenHTSEB.FehlenderText);
   
   -- Das hier im speziellen und den Rest im allgemeinen noch einmal besser benennen. äöü
   Meldungen : ArraysHTSEB.AllgemeinesTextArray (TextnummernKonstanten.SpielmeldungenVorhanden'Range) := (others => TextKonstantenHTSEB.FehlenderText);
   
   Würdigungen : ArraysHTSEB.AllgemeinesTextArray (1 .. 3) := (others => TextKonstantenHTSEB.FehlenderText);
   
   Zeug : ArraysHTSEB.AllgemeinesTextArray (TextnummernKonstanten.ZeugVorhanden'Range) := (others => TextKonstantenHTSEB.FehlenderText);
   
   Stadtbefehle : ArraysHTSEB.AllgemeinesTextArray (1 .. 6) := (others => TextKonstantenHTSEB.FehlenderText);
   
   Ladezeiten : ArraysHTSEB.AllgemeinesTextArray (TextnummernKonstanten.LadezeitVorhanden'Range) := (others => TextKonstantenHTSEB.FehlenderText);
   
   Beschäftigungen : ArraysHTSEB.AllgemeinesTextArray (1 .. 2 * (AufgabenDatentypen.Einheiten_Aufgaben_Enum'Pos (AufgabenDatentypen.Einheiten_Aufgaben_Enum'Last) + 1)) := (others => TextKonstantenHTSEB.FehlenderText);
   
end Spieltexte;
