pragma SPARK_Mode (On);

with Sf.Graphics;
with Sf.Graphics.RectangleShape;
with Sf.Graphics.CircleShape;
with Sf.System.Vector2;
with Sf.Graphics.Color;

with SystemDatentypen; use SystemDatentypen;
with KartenDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with KartenRecords;

package KarteStadtSFML is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_Mensch);

private

   InformationenStadtAufrufen : Boolean;
   FeldBewirtschaftet : Boolean;
   MausInformationen : Boolean;

   Stadtumgebungsgröße : KartenDatentypen.Stadtfeld;

   GebäudeID : EinheitStadtDatentypen.GebäudeID;

   YAchsenabstraktion : KartenDatentypen.Kartenfeld;

   YMultiplikator : Float;
   XMultiplikator : Float;

   AktuelleFarbe : Sf.Graphics.Color.sfColor;

   TextPosition : Sf.System.Vector2.sfVector2f;

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;
   RechteckRahmenAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   KreisAccess : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;

   PolygonAccess : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;

   procedure GrafischeDarstellung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

   procedure MauszeigerAnzeigen
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure DarstellungGebäude
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

   procedure DarstellungUmgebung
     (YAchseExtern : in KartenDatentypen.Stadtfeld;
      XAchseExtern : in KartenDatentypen.Stadtfeld;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

   procedure DarstellungUmgebungErweitert
     (KartePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f);

end KarteStadtSFML;
