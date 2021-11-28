pragma SPARK_Mode (On);

with Sf.Graphics;
with Sf.Graphics.RectangleShape;
with Sf.Graphics.CircleShape;

with SystemDatentypen; use SystemDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;

package KarteStadtSFML is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = SystemDatentypen.Spieler_Mensch);

private

   YMultiplikator : Float;
   XMultiplikator : Float;

   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   PolygonAccess : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;

   procedure GrafischeDarstellung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);

end KarteStadtSFML;
