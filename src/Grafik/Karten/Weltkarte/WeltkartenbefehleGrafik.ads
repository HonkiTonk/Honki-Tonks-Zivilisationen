pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;
private with Sf.Graphics.Rect;
private with Sf.Graphics;
private with Sf.Graphics.Sprite;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitenRecords;

private with GrafikRecordKonstanten;
private with EinheitenDatentypen;

package WeltkartenbefehleGrafik is

   procedure Kartenbefehle;
   
   procedure Einheitenbefehle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   Kampfeinheit : Boolean;
   
   Einheitart : EinheitenDatentypen.Einheitart_Enum;
   
   AnfangEinheitenbefehle : constant Positive := 2;
   AnfangKartenbefehle : constant Positive := 15;
   Aktuelleposition : Positive;
   Teiler : Positive;

   Textbreite : Float;
   
   EinheitenViewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   KartenbefehleViewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;
   Knopfposition : Sf.System.Vector2.sfVector2f;
   Spritegröße : Sf.System.Vector2.sfVector2f;
   GesamteSpritegröße : Sf.System.Vector2.sfVector2f;
   Texturgröße : Sf.System.Vector2.sfVector2f;
   
   Textbox : Sf.Graphics.Rect.sfFloatRect;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;
   
   procedure Kartenbefehlsknöpfe;
   
   procedure Einheitenbefehlsknöpfe
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

end WeltkartenbefehleGrafik;
