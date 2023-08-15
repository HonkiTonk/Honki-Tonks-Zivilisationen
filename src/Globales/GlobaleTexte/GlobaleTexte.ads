with TextKonstanten;
with TextArrays;
with TextnummernKonstanten;

package GlobaleTexte is
   pragma Elaborate_Body;
   
   NameBeschreibungMultiplikator : constant Positive := 2;
   
   SprachenEinlesen : TextArrays.AllgemeinesTextArray (1 .. 100);
            
   Beschäftigungen : TextArrays.AllgemeinesTextArray (1 .. NameBeschreibungMultiplikator * 12) := (others => TextKonstanten.FehlenderText);
   Würdigung : TextArrays.AllgemeinesTextArray (1 .. 1) := (others => TextKonstanten.FehlenderText);
   DiplomatieKI : TextArrays.AllgemeinesTextArray (1 .. 3) := (others => TextKonstanten.FehlenderText);
   DiplomatieStatus : TextArrays.AllgemeinesTextArray (1 .. 4) := (others => TextKonstanten.FehlenderText);
   Angebot : TextArrays.AllgemeinesTextArray (1 .. 2) := (others => TextKonstanten.FehlenderText);
   Ladezeit : TextArrays.AllgemeinesTextArray (TextnummernKonstanten.LadezeitVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   
end GlobaleTexte;
