pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.RectangleShape;
with Sf.Graphics.CircleShape;
with Sf.System.Vector2;
with Sf.Graphics.Color;
with Sf.Graphics.Sprite;

with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with KartenRecords;
with SystemKonstanten;
with KartenGrundDatentypen;
with KartenVerbesserungDatentypen;

package KarteStadtSFML is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemKonstanten.SpielerMenschKonstante);

private

   InformationenStadtAufrufen : Boolean;
   FeldBewirtschaftet : Boolean;
   MausInformationen : Boolean;

   Stadtumgebungsgröße : KartenDatentypen.Stadtfeld;

   GebäudeID : EinheitStadtDatentypen.GebäudeID;

   YAchsenabstraktion : KartenDatentypen.Kartenfeld;

   Kartenfeld : KartenGrundDatentypen.Karten_Grund_Enum;
   KartenfeldRessource : KartenGrundDatentypen.Karten_Grund_Enum;
   KartenfeldFluss : KartenGrundDatentypen.Karten_Grund_Enum;

   Stadtfeld : KartenVerbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum;
   Wegfeld : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
   Verbesserungsfeld : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;

   YMultiplikator : Float;
   XMultiplikator : Float;

   AktuelleFarbe : Sf.Graphics.Color.sfColor;

   AnfangGrafikPosition : constant Sf.System.Vector2.sfVector2f := (0.00, 0.00);
   TextPosition : Sf.System.Vector2.sfVector2f;
   GrafikPosition : Sf.System.Vector2.sfVector2f;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;
   RechteckRahmenAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   KreisAccess : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;

   PolygonAccess : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;

   procedure GrafischeDarstellung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

   procedure MauszeigerAnzeigen
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure DarstellungGebäude
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

   procedure DarstellungUmgebung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

   procedure DarstellungUmgebungErweitert
     (KarteKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f);

   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f);

   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f);

   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f);

   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f);

   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f);

   procedure StadtZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end KarteStadtSFML;
