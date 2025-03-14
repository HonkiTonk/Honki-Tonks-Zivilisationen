with ArraysHTSEB;
with TextKonstantenHTSEB;

package Sequenzentexte is
   pragma Elaborate_Body;
   
   IntroEnde : constant Positive := 2;
   OutroEnde : constant Positive := 4;
   
   Intro : ArraysHTSEB.AllgemeinesTextArray (1 .. IntroEnde) := (others => TextKonstantenHTSEB.FehlenderText);
   Outro : ArraysHTSEB.AllgemeinesTextArray (1 .. OutroEnde) := (others => TextKonstantenHTSEB.FehlenderText);

end Sequenzentexte;
