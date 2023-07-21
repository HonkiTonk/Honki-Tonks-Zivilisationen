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
   Handelsmenü : TextArrays.AllgemeinesTextArray (1 .. 10) := (others => TextKonstanten.FehlenderText);
   DiplomatieStatus : TextArrays.AllgemeinesTextArray (1 .. 4) := (others => TextKonstanten.FehlenderText);
   Angebot : TextArrays.AllgemeinesTextArray (1 .. 2) := (others => TextKonstanten.FehlenderText);
   Ladezeit : TextArrays.AllgemeinesTextArray (TextnummernKonstanten.LadezeitVorhanden'Range) := (others => TextKonstanten.FehlenderText);
            
   BeschäftigungenLängstes : TextArrays.AllgemeinesTextArray (Beschäftigungen'Range) := (others => TextKonstanten.FehlenderText);
   WürdigungLängstes : TextArrays.AllgemeinesTextArray (Würdigung'Range) := (others => TextKonstanten.FehlenderText);
   DiplomatieKILängstes : TextArrays.AllgemeinesTextArray (DiplomatieKI'Range) := (others => TextKonstanten.FehlenderText);
   HandelsmenüLängstes : TextArrays.AllgemeinesTextArray (Handelsmenü'Range) := (others => TextKonstanten.FehlenderText);
   DiplomatieStatusLängstes : TextArrays.AllgemeinesTextArray (DiplomatieStatus'Range) := (others => TextKonstanten.FehlenderText);
   AngebotLängstes : TextArrays.AllgemeinesTextArray (Angebot'Range) := (others => TextKonstanten.FehlenderText);
   LadezeitLängstes : TextArrays.AllgemeinesTextArray (Ladezeit'Range) := (others => TextKonstanten.FehlenderText);
   
end GlobaleTexte;
