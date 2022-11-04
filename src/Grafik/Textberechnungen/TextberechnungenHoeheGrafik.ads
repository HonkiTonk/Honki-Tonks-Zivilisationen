pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;

package TextberechnungenHoeheGrafik is
   pragma Elaborate_Body;
   
   function ZeilenabstandVariabel
     return Float
     with
       Post => (
                  ZeilenabstandVariabel'Result > 0.00
               );
   
   function KleinerZeilenabstandVariabel
     return Float
     with
       Post => (
                  KleinerZeilenabstandVariabel'Result > 0.00
               );
   
   function NeueTextposition
     (PositionExtern : in Float;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      ZusatzwertExtern : in Float)
      return Float
     with
       Pre => (
                 PositionExtern >= 0.00
               and
                 ZusatzwertExtern >= 0.00
               and
                 TextAccessExtern /= null
              ),
         
       Post => (
                  NeueTextposition'Result > 0.00
               );

end TextberechnungenHoeheGrafik;
