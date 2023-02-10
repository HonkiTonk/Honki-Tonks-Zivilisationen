with Sf.Graphics;

package TextberechnungenHoeheGrafik is
   pragma Elaborate_Body;
   use type Sf.Graphics.sfText_Ptr;
   
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
   
   function KonstanteTextposition
     (PositionExtern : in Float;
      ZusatzwertExtern : in Float)
      return Float
     with
       Pre => (
                 PositionExtern >= 0.00
               and
                 ZusatzwertExtern >= 0.00
              ),
         
       Post => (
                  KonstanteTextposition'Result > 0.00
               );

end TextberechnungenHoeheGrafik;
