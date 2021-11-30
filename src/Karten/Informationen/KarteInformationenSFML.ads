pragma SPARK_Mode (On);

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.RectangleShape;

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtRecords;

package KarteInformationenSFML is

   procedure KarteInformationenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);

private

   StadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   EinheitRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;

   Zeilenabstand : Float;

   StartpunktText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);

   FensterInformationen : Sf.System.Vector2.sfVector2f;
   ZeichenPosition : Sf.System.Vector2.sfVector2f;
   PositionText : Sf.System.Vector2.sfVector2f;

   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

   RechteckAcces : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   procedure WichtigesInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure StadtInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure EinheitInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure AllgemeineInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure CheatInformationen;

end KarteInformationenSFML;
