pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics; use Sf.Graphics;

package TextberechnungenHoeheGrafik is
   
   function KleinerZeilenabstand
     return Float
     with
       Post => (
                  KleinerZeilenabstand'Result > 0.00
               );
   
   function Zeilenabstand
     return Float
     with
       Post => (
                  Zeilenabstand'Result > 0.00
               );
   
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
   
   function NeueTexthöheErmitteln
     (TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      TexthöheExtern : in Float)
      return Float
     with
       Pre => (
                 TextAccessExtern /= null
               and
                 TexthöheExtern >= 0.00
              ),
         
       Post => (
                  NeueTexthöheErmitteln'Result >= 0.00
               );
   
private
   
   NeueTexthöhe : Float;

end TextberechnungenHoeheGrafik;
