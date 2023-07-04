-- Für alles in InteraktionAuswahl Lese/Schreibedateien anlegen? äöü
package body InteraktionAuswahl is
   
   procedure SchreibeGesamteMausposition
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Mausposition := MauspositionExtern;
      
   end SchreibeGesamteMausposition;
   
   

   function LeseGesamteMausposition
     return Sf.System.Vector2.sfVector2f
   is begin
      
      return Mausposition;
      
   end LeseGesamteMausposition;
   
   
   
   function LeseGesamteMauspositionInteger
     return Sf.System.Vector2.sfVector2i
   is begin
      
      return (Sf.sfInt32 (Mausposition.x), Sf.sfInt32 (Mausposition.y));
      
   end LeseGesamteMauspositionInteger;
   
   
   
   function LeseXMausachse
     return Float
   is begin
      
      return Mausposition.x;
      
   end LeseXMausachse;
   
   
   
   function LeseYMausachse
     return Float
   is begin
      
      return Mausposition.y;
      
   end LeseYMausachse;

end InteraktionAuswahl;
