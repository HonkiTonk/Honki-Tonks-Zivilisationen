with TextKonstanten;
with TextArrays;

package GlobaleTexte is
   pragma Elaborate_Body;
   
   -- Solche Sachen die in mehreren Datei gebraucht werden mal in einer Datei zusammenfassen? äöü
   SprachenEinlesen : TextArrays.AllgemeinesTextArray (1 .. 100);
            
   
   DiplomatieKI : TextArrays.AllgemeinesTextArray (1 .. 3) := (others => TextKonstanten.FehlenderText);
   DiplomatieStatus : TextArrays.AllgemeinesTextArray (1 .. 4) := (others => TextKonstanten.FehlenderText);
   Angebot : TextArrays.AllgemeinesTextArray (1 .. 2) := (others => TextKonstanten.FehlenderText);
   
end GlobaleTexte;
