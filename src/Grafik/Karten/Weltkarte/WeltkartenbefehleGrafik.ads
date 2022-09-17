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
private with BefehleDatentypen;

package WeltkartenbefehleGrafik is

   procedure Kartenbefehle;
   
   procedure Einheitenbefehle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
      
   Einheitart : EinheitenDatentypen.Einheitart_Enum;
   
   WelcherKnopf : BefehleDatentypen.Befehlsknöpfe_Enum;
   
   AnfangEinheitenbefehle : constant Positive := 2;
   AnfangKartenbefehle : constant Positive := 15;
   Aktuelleposition : Positive;
   Teiler : Positive;

   Textbreite : Float;
   Multiplikator : Float;
   
   EinheitenViewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   KartenbefehleViewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;
   Knopfposition : Sf.System.Vector2.sfVector2f;
   Spritegröße : Sf.System.Vector2.sfVector2f;
   GesamteSpritegröße : Sf.System.Vector2.sfVector2f;
   Texturgröße : Sf.System.Vector2.sfVector2f;
   
   Textbox : Sf.Graphics.Rect.sfFloatRect;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;
   
   
   
   function Einheitenbefehlstexte
     (EinheitenArtExtern : in EinheitenDatentypen.Einheitart_Standard_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Einheitenbefehlstexte'Result.x >= 0.00
                and
                  Einheitenbefehlstexte'Result.y >= 0.00
               );
   
   function Einheitenbefehlsknöpfe
     (EinheitenArtExtern : in EinheitenDatentypen.Einheitart_Standard_Enum;
      WelcheTexturExtern : in BefehleDatentypen.Befehlsknöpfe_Enum)
      return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Einheitenbefehlsknöpfe'Result.x >= 0.00
                and
                  Einheitenbefehlsknöpfe'Result.y >= 0.00
               );
   
   function Kartenbefehlstexte
     return Sf.System.Vector2.sfVector2f
     with
       Post => (
                  Kartenbefehlstexte'Result.x >= 0.00
                and
                  Kartenbefehlstexte'Result.y >= 0.00
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
