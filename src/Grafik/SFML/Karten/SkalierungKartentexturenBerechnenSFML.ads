pragma SPARK_Mode (On);

with Sf.Graphics; use Sf.Graphics;
with Sf.System.Vector2;

package SkalierungKartentexturenBerechnenSFML is

   function SkalierungTexturenKartenfelderWeltkarteBerechnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr)
      return Sf.System.Vector2.sfVector2f
     with
       Pre =>
         (SpriteAccessExtern /= null);

   function SkalierungTexturenKartenfelderStadtkarteBerechnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr)
      return Sf.System.Vector2.sfVector2f
     with
       Pre =>
         (SpriteAccessExtern /= null);
   
   function SkalierungTexturenGesamtStadtkarteBerechnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr)
      return Sf.System.Vector2.sfVector2f
     with
       Pre =>
         (SpriteAccessExtern /= null);
   
private
   
   SkalierungKartenfeld : Sf.System.Vector2.sfVector2f;
   GrößeTextur : Sf.System.Vector2.sfVector2f;
   KartenfelderAbmessung : Sf.System.Vector2.sfVector2f;
   StadtfelderAbmessung : Sf.System.Vector2.sfVector2f;
   StadtAbmessung : Sf.System.Vector2.sfVector2f;

end SkalierungKartentexturenBerechnenSFML;
