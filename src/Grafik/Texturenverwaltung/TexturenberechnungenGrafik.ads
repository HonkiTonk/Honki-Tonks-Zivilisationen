with Sf.System.Vector2;

package TexturenberechnungenGrafik is
   pragma Elaborate_Body;
   
   function Texturenbereich
     (TexturengrößeExtern : in Sf.System.Vector2.sfVector2f;
      BereichnummerExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 TexturengrößeExtern.x >= 0.00
               and
                 TexturengrößeExtern.y >= 0.00
               and
                 BereichnummerExtern >= 1.00
              ),
         
       Post => (
                  Texturenbereich'Result.x >= 0.00
                and
                  Texturenbereich'Result.y >= 0.00
               );
   
   function TexturenbereichVariabel
     (TexturengrößeExtern : in Sf.System.Vector2.sfVector2f;
      TeilerExtern : in Sf.System.Vector2.sfVector2f;
      BereichnummerExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 TexturengrößeExtern.x >= 0.00
               and
                 TexturengrößeExtern.y >= 0.00
               and
                 TeilerExtern.x > 0.00
               and
                 TeilerExtern.y > 0.00
               and
                 BereichnummerExtern >= 1.00
               and
                 BereichnummerExtern <= TeilerExtern.x * TeilerExtern.y
              ),
         
       Post => (
                  TexturenbereichVariabel'Result.x >= 0.00
                and
                  TexturenbereichVariabel'Result.y >= 0.00
               );
   
   function Texturenbreite
     (TexturenbreiteExtern : in Float;
      TeilerExtern : in Float)
      return Float
     with
       Pre => (
                 TexturenbreiteExtern >= 0.00
               and
                 TeilerExtern > 0.00
              ),
         
       Post => (
                  Texturenbreite'Result >= 0.00
               );
   
   function Texturenhöhe
     (TexturenhöheExtern : in Float;
      TeilerExtern : in Float)
      return Float
     with
       Pre => (
                 TexturenhöheExtern >= 0.00
               and
                 TeilerExtern > 0.00
              ),
         
       Post => (
                  Texturenhöhe'Result >= 0.00
               );

   function Texturenfeld
     (TexturengrößeExtern : in Sf.System.Vector2.sfVector2f;
      TeilerExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 TexturengrößeExtern.x >= 0.00
               and
                 TexturengrößeExtern.y >= 0.00
               and
                 TeilerExtern.x > 0.00
               and
                 TeilerExtern.y > 0.00
              ),
         
       Post => (
                  Texturenfeld'Result.x >= 0.00
                and
                  Texturenfeld'Result.y >= 0.00
               );
   
private
   
   Breitenteiler : Float;
   
   StandardTexturenbereich : constant Sf.System.Vector2.sfVector2f := (32.00, 32.00);
   Texturenvektor : Sf.System.Vector2.sfVector2f;
   Teiler : Sf.System.Vector2.sfVector2f;
   Zwischenwert : Sf.System.Vector2.sfVector2f;
     
end TexturenberechnungenGrafik;
