with Sf.Graphics.Rect;

package SchreibeGrafikVariablen is

   procedure InformationsfeldBereiche
     (WelcherBereichExtern : in Positive;
      RechteckExtern : in Sf.Graphics.Rect.sfFloatRect)
     with
       Pre => (
                 RechteckExtern.left >= 0.00
               and
                 RechteckExtern.top >= 0.00
               and
                 RechteckExtern.width >= 0.00
               and
                 RechteckExtern.height >= 0.00
              );

end SchreibeGrafikVariablen;
