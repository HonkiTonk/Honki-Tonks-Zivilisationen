private with Sf.System.Vector2;
private with Sf.Graphics;
private with Sf.Graphics.Sprite;
private with Sf.Graphics.Rect;

with EinheitenDatentypen;

private with GrafikRecordKonstanten;

package WeltkartenbefehleGrafik is
   pragma Elaborate_Body;

   procedure Kartenbefehle
     (RechtsLinksExtern : in Boolean);
   
   procedure Einheitenbefehle
     (EinheitartExtern : in EinheitenDatentypen.Einheitart_Enum;
      RechtsLinksExtern : in Boolean);
   
private
   
   WelcherViewbereich : Positive;
   
   EinheitenViewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   KartenbefehleViewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Texturgröße : Sf.System.Vector2.sfVector2f;
   
   Rechteck : Sf.Graphics.Rect.sfIntRect;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;
   
   
        
   function Einheitenbefehlsknöpfe
     (EinheitenArtExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Einheitenbefehlsknöpfe'Result.x >= 0.00
                and
                  Einheitenbefehlsknöpfe'Result.y >= 0.00
               );
   
   function Kartenbefehlsknöpfe
     return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Kartenbefehlsknöpfe'Result.x >= 0.00
                and
                  Kartenbefehlsknöpfe'Result.y >= 0.00
               );

end WeltkartenbefehleGrafik;
