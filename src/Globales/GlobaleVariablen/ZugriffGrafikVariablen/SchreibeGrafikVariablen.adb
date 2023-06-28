with GrafikVariablen;

package body SchreibeGrafikVariablen is

   procedure InformationsfeldBereiche
     (WelcherBereichExtern : in Positive;
      RechteckExtern : in Sf.Graphics.Rect.sfFloatRect)
   is begin
      
      GrafikVariablen.InformationsfeldBereiche (WelcherBereichExtern) := RechteckExtern;
      
   end InformationsfeldBereiche;

end SchreibeGrafikVariablen;
