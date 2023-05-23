with TextArrays;

package Spieltexte is
   pragma Preelaborate;
   
   IntroEnde : constant Positive := 1;
   OutroEnde : constant Positive := 4;
   
   Intro : TextArrays.AllgemeinesTextArray (1 .. IntroEnde);
   Outro : TextArrays.AllgemeinesTextArray (1 .. OutroEnde);

end Spieltexte;
