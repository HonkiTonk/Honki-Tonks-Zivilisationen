with ArraysHTSEB;

with TextKonstanten;

package Sequenzentexte is
   pragma Elaborate_Body;
   
   IntroEnde : constant Positive := 2;
   OutroEnde : constant Positive := 4;
   
   Intro : ArraysHTSEB.AllgemeinesTextArray (1 .. IntroEnde) := (others => TextKonstanten.FehlenderText);
   Outro : ArraysHTSEB.AllgemeinesTextArray (1 .. OutroEnde) := (others => TextKonstanten.FehlenderText);

end Sequenzentexte;
