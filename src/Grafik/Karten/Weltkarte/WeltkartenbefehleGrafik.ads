private with Sf.System.Vector2;
private with Sf.Graphics;
private with Sf.Graphics.Sprite;

with SpeziesDatentypen;
with EinheitenDatentypen;

private with GrafikRecordKonstanten;
private with BefehleDatentypen;

package WeltkartenbefehleGrafik is
   pragma Elaborate_Body;

   procedure Kartenbefehle
     (RechtsLinksExtern : in Boolean);
   
   procedure Einheitenbefehle
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      RechtsLinksExtern : in Boolean);
   
private
      
   Einheitart : EinheitenDatentypen.Einheitart_Enum;
   
   WelcherKnopf : BefehleDatentypen.Befehlsknöpfe_Enum;
   
   AnfangEinheitenbefehle : constant Positive := 2;
   AnfangKartenbefehle : constant Positive := 15;
   AktuellerBefehl : Positive;
   WelcherViewbereich : Positive;

   Textbreite : Float;
   Teiler : Float;
   
   EinheitenViewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   KartenbefehleViewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;
   Spritegröße : Sf.System.Vector2.sfVector2f;
   GesamteSpritegröße : Sf.System.Vector2.sfVector2f;
   Texturgröße : Sf.System.Vector2.sfVector2f;
   Knopfposition : Sf.System.Vector2.sfVector2f;
   Knopffläche : Sf.System.Vector2.sfVector2f;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;
   
   
        
   function Einheitenbefehlsknöpfe
     (EinheitenArtExtern : in EinheitenDatentypen.Einheitart_Vorhanden_Enum;
      WelcheTexturExtern : in BefehleDatentypen.Befehlsknöpfe_Enum)
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
