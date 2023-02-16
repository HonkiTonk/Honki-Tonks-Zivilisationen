with Sf.Graphics.Text;

with TextaccessVariablen;

with FensterGrafik;

package body TextberechnungenHoeheGrafik is
   
   function KleinerZeilenabstandVariabel
     return Float
   is begin
      
      return 1.50 * FensterGrafik.AktuelleAuflösung.y / 100.00;
      
   end KleinerZeilenabstandVariabel;
   
   
   
   function ZeilenabstandVariabel
     return Float
   is begin
      
      return 3.50 * FensterGrafik.AktuelleAuflösung.y / 100.00;
      
   end ZeilenabstandVariabel;
   
   
   
   -- Die beiden Sachen umbenennen? äöü
   function NeueTextposition
     (PositionExtern : in Float;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      ZusatzwertExtern : in Float)
      return Float
   is begin
      
      return PositionExtern + ZusatzwertExtern + Sf.Graphics.Text.getLocalBounds (text => TextAccessExtern).height;
      
   end NeueTextposition;
   
   
   
   function KonstanteTextposition
     (PositionExtern : in Float;
      ZusatzwertExtern : in Float)
      return Float
   is begin
      
      return PositionExtern + ZusatzwertExtern + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.TexthöheAccess).height;
      
   end KonstanteTextposition;
   
end TextberechnungenHoeheGrafik;
