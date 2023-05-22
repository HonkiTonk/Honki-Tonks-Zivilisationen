with TextKonstanten;
with SystemDatentypen;
with TextArrays;

package GlobaleTexte is
   pragma Elaborate_Body;
   
   NameBeschreibungMultiplikator : constant Positive := 2;
   
   SprachenEinlesen : TextArrays.TexteArray (1 .. 100);
            
   Beschäftigungen : TextArrays.TexteArray (1 .. NameBeschreibungMultiplikator * 12) := (others => TextKonstanten.FehlenderText);
   Würdigung : TextArrays.TexteArray (1 .. 1) := (others => TextKonstanten.FehlenderText);
   DiplomatieKI : TextArrays.TexteArray (1 .. 3) := (others => TextKonstanten.FehlenderText);
   Handelsmenü : TextArrays.TexteArray (1 .. 10) := (others => TextKonstanten.FehlenderText);
   DiplomatieStatus : TextArrays.TexteArray (1 .. 4) := (others => TextKonstanten.FehlenderText);
   Angebot : TextArrays.TexteArray (1 .. 2) := (others => TextKonstanten.FehlenderText);
   Ladezeit : TextArrays.TexteArray (SystemDatentypen.LadezeitVorhanden'Range) := (others => TextKonstanten.FehlenderText);
   
end GlobaleTexte;
