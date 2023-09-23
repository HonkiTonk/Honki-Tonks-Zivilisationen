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
      ZusatzwertExtern : in Float)
      return Float
     with
       Pre => (
                 PositionExtern >= 0.00
               and
                 ZusatzwertExtern >= 0.00
              ),
         
       Post => (
                  NeueTextposition'Result > 0.00
               );

end TextberechnungenHoeheGrafik;
