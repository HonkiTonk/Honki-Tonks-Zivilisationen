with Sf.Graphics.Rect;

package LeseGrafikVariablen is

   function InformationsfeldBereiche
     (WelcherBereichExtern : in Positive)
      return Sf.Graphics.Rect.sfFloatRect
     with
       Post => (
                  InformationsfeldBereiche'Result.left >= 0.00
                and
                  InformationsfeldBereiche'Result.top >= 0.00
                and
                  InformationsfeldBereiche'Result.width >= 0.00
                and
                  InformationsfeldBereiche'Result.height >= 0.00
               );

end LeseGrafikVariablen;
