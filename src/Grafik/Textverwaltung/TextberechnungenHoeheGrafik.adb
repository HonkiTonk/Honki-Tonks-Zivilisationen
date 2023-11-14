with Sf.Graphics.Text;

with TextaccessVariablen;

with FensterGrafik;

package body TextberechnungenHoeheGrafik is
   
   function WinzigerZeilenabstand
     return Float
   is begin
      
      return FensterGrafik.AktuelleAuflösung.y / 200.00;
      
   end WinzigerZeilenabstand;
   
   
   
   function KleinerZeilenabstand
     return Float
   is begin
      
      return 1.50 * FensterGrafik.AktuelleAuflösung.y / 100.00;
      
   end KleinerZeilenabstand;
   
   
   
   function Zeilenabstand
     return Float
   is begin
      
      return 3.50 * FensterGrafik.AktuelleAuflösung.y / 100.00;
      
   end Zeilenabstand;
   
   
   
   function NeueTextposition
     (PositionExtern : in Float;
      ZusatzwertExtern : in Float)
      return Float
   is begin
      
      return PositionExtern + ZusatzwertExtern + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.TexthöheAccess).height;
      
   end NeueTextposition;
   
   
   
   function Leerzeilen
     (LeerzeilenExtern : in Natural;
      PositionExtern : in Float)
      return Float
   is begin
      
      NeuePosition := 0.00;
      LeereZeilen := LeerzeilenExtern;
      
      LeerzeilenSchleife:
      while LeereZeilen > 0 loop
         
         NeuePosition := NeueTextposition (PositionExtern   => NeuePosition,
                                           ZusatzwertExtern => KleinerZeilenabstand);
         
         LeereZeilen := LeereZeilen - 1;
         
      end loop LeerzeilenSchleife;
      
      return PositionExtern + NeuePosition;
      
   end Leerzeilen;
   
end TextberechnungenHoeheGrafik;
