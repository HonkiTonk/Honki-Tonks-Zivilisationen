with ArraysHTSEB;

with TextKonstanten;
with TextnummernKonstanten;
with AufgabenDatentypen;

package Spieltexte is
   pragma Elaborate_Body;
   
   -- Beim Umbenennen auch gleich mal alles rauswerfen was ich nicht brauche. äöü
   Fragen : ArraysHTSEB.AllgemeinesTextArray (TextnummernKonstanten.FragenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   
   -- Das hier im speziellen und den Rest im allgemeinen noch einmal besser benennen. äöü
   Meldungen : ArraysHTSEB.AllgemeinesTextArray (TextnummernKonstanten.SpielmeldungenVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   
   Würdigungen : ArraysHTSEB.AllgemeinesTextArray (1 .. 3) := (others => TextKonstanten.FehlenderText);
   
   Zeug : ArraysHTSEB.AllgemeinesTextArray (TextnummernKonstanten.ZeugVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   
   Stadtbefehle : ArraysHTSEB.AllgemeinesTextArray (1 .. 6) := (others => TextKonstanten.FehlenderText);
   
   Ladezeiten : ArraysHTSEB.AllgemeinesTextArray (TextnummernKonstanten.LadezeitVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   
   Beschäftigungen : ArraysHTSEB.AllgemeinesTextArray (1 .. 2 * (AufgabenDatentypen.Einheiten_Aufgaben_Enum'Pos (AufgabenDatentypen.Einheiten_Aufgaben_Enum'Last) + 1)) := (others => TextKonstanten.FehlenderText);
   
end Spieltexte;
