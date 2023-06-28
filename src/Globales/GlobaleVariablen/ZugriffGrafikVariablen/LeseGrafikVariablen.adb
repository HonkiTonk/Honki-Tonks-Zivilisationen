with GrafikVariablen;

package body LeseGrafikVariablen is

   function InformationsfeldBereiche
     (WelcherBereichExtern : in Positive)
      return Sf.Graphics.Rect.sfFloatRect
   is begin
      
      return GrafikVariablen.InformationsfeldBereiche (WelcherBereichExtern);
      
   end InformationsfeldBereiche;

end LeseGrafikVariablen;
