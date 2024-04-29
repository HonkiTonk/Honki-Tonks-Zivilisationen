package TextberechnungenHoeheGrafik is
   pragma Elaborate_Body;
   
   function WinzigerZeilenabstand
     return Float
     with
       Post => (
                  WinzigerZeilenabstand'Result >= 0.00
               );
   
   function Zeilenabstand
     return Float
     with
       Post => (
                  Zeilenabstand'Result >= 0.00
               );
   
   function KleinerZeilenabstand
     return Float
     with
       Post => (
                  KleinerZeilenabstand'Result >= 0.00
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
   
   
   
   function NeueTextpositionOhneTexthöhe
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
                  NeueTextpositionOhneTexthöhe'Result > 0.00
               );
     
     
   
   function Leerzeilen
     (LeerzeilenExtern : in Natural;
      PositionExtern : in Float)
      return Float
     with
       Pre => (
                 PositionExtern >= 0.00
              ),
         
       Post => (
                  Leerzeilen'Result >= 0.00
               );
   
private
   
   LeereZeilen : Natural;
   
   NeuePosition : Float;

end TextberechnungenHoeheGrafik;
