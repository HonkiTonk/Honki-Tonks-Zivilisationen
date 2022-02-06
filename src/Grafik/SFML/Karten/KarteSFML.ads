pragma SPARK_Mode (On);

with Sf.System.Vector2;
with Sf.Graphics.Color;
with Sf.Graphics.RectangleShape;
with Sf.Graphics.CircleShape;
with Sf.Graphics.Text;
with Sf.Graphics.Sprite;

with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen;
with KartenRecords;
with GlobaleVariablen;
with EinheitStadtRecords;
with SystemKonstanten;

package KarteSFML is
   
   procedure KarteAnzeigen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.SpielerMenschKonstante);
   
   
   
   function FarbeKartenfeldErmitteln
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum)
      return Sf.Graphics.Color.sfColor;
   
private
   
   AktuelleRasse : SystemDatentypen.Rassen_Enum;
   
   YSichtAnfang : KartenDatentypen.Kartenfeld;
   YSichtEnde : KartenDatentypen.Kartenfeld;
   XSichtAnfang : KartenDatentypen.Kartenfeld;
   XSichtEnde : KartenDatentypen.Kartenfeld;
   
   SichtbereichAnfangEnde : KartenDatentypen.SichtbereichAnfangEndeArray;
   
   Kartenfeld : KartenDatentypen.Karten_Grund_Enum;
   
   YMultiplikator : Float;
   XMultiplikator : Float;
      
   StadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   EinheitStadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   
   AktuelleFarbe : Sf.Graphics.Color.sfColor;
   
   Position : Sf.System.Vector2.sfVector2f;
   SkalierungKartenfeld : Sf.System.Vector2.sfVector2f;
   GrößeTextur : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWertRahmen : KartenRecords.AchsenKartenfeldPositivRecord;
   
   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;
   RechteckRahmenAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   KreisAccess : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;
   PolygonAccess : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;
   
   procedure Sichtbarkeit
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure IstSichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f);

   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f);

   procedure AnzeigeStadt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f);

   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f);

   procedure AnzeigeCursor
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f);
   
   procedure AnzeigeFeldbesitzer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f);
   
   procedure RahmenBesetztesFeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f);
   
   
   
   function SkalierungTexturenKartenfelderWeltkarteBerechnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr)
      return Sf.System.Vector2.sfVector2f;

end KarteSFML;
