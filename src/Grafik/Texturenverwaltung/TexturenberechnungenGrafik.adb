with GrafikKonstanten;

package body TexturenberechnungenGrafik is
   
   -- Setzt ganzzahlige BereichnummerExtern voraus.
   function Texturenbereich
     (TexturengrößeExtern : in Sf.System.Vector2.sfVector2f;
      BereichnummerExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
            
      Breitenteiler := Texturenbreite (TexturenbreiteExtern => TexturengrößeExtern.x,
                                       TeilerExtern         => StandardTexturenbereich.x);
      
        
      Teiler := (BereichnummerExtern, GrafikKonstanten.Nullwert);
      
      TeilerSchleife:
      while
        Teiler.x > Breitenteiler
      loop
         
         Teiler.x := Teiler.x - Breitenteiler;
         Teiler.y := Teiler.y + 1.00;
         
      end loop TeilerSchleife;
      
      Zwischenwert.x := StandardTexturenbereich.x * (Teiler.x - 1.00);
      Zwischenwert.y := StandardTexturenbereich.y * Teiler.y;
      
      return Zwischenwert;
      
   end Texturenbereich;
   
   
   
   -- Setzt ganzzahlige TeilerExtern und BereichnummerExtern voraus.
   function TexturenbereichVariabel
     (TexturengrößeExtern : in Sf.System.Vector2.sfVector2f;
      TeilerExtern : in Sf.System.Vector2.sfVector2f;
      BereichnummerExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Texturenvektor := Texturenfeld (TexturengrößeExtern => TexturengrößeExtern,
                                      TeilerExtern        => TeilerExtern);
      
      Teiler := (BereichnummerExtern, GrafikKonstanten.Nullwert);
      
      TeilerSchleife:
      while
        Teiler.x > TeilerExtern.x
      loop
         
         Teiler.x := Teiler.x - TeilerExtern.x;
         Teiler.y := Teiler.y + 1.00;
         
      end loop TeilerSchleife;
      
      Zwischenwert.x := Texturenvektor.x * (Teiler.x - 1.00);
      Zwischenwert.y := Texturenvektor.y * Teiler.y;
      
      return Zwischenwert;
      
   end TexturenbereichVariabel;
   
     
   
   function Texturenbreite
     (TexturenbreiteExtern : in Float;
      TeilerExtern : in Float)
      return Float
   is begin
      
      return TexturenbreiteExtern / TeilerExtern;
      
   end Texturenbreite;
   
   
   
   function Texturenhöhe
     (TexturenhöheExtern : in Float;
      TeilerExtern : in Float)
      return Float
   is begin
      
      return TexturenhöheExtern / TeilerExtern;
      
   end Texturenhöhe;
   
   

   function Texturenfeld
     (TexturengrößeExtern : in Sf.System.Vector2.sfVector2f;
      TeilerExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (TexturengrößeExtern.x / TeilerExtern.x, TexturengrößeExtern.y / TeilerExtern.y);
      
   end Texturenfeld;

end TexturenberechnungenGrafik;
