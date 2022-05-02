pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;
with Sf.Graphics.Color;
with Sf.Graphics.RectangleShape;
with Sf.Graphics.CircleShape;
with Sf.Graphics.Text;
with Sf.Graphics.Sprite;

with KartenDatentypen; use KartenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with KartenRecords;
with SonstigeVariablen;
with EinheitStadtRecords;
with KartengrundDatentypen;
with KartenVerbesserungDatentypen;

package KarteSFML is
   
   procedure KarteAnzeigen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_Mensch_Enum);
   
private
   
   SchriftartFestgelegt : Boolean := False;
   SchriftfarbeFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;
   
   AktuelleRasse : RassenDatentypen.Rassen_Enum;
   
   YSichtAnfang : KartenDatentypen.Kartenfeld;
   YSichtEnde : KartenDatentypen.Kartenfeld;
   XSichtAnfang : KartenDatentypen.Kartenfeld;
   XSichtEnde : KartenDatentypen.Kartenfeld;
   
   SichtbereichAnfangEnde : KartenDatentypen.SichtbereichAnfangEndeArray;
   
   Kartengrund : KartengrundDatentypen.Kartengrund_Enum;
   KartenfeldFluss : KartengrundDatentypen.Kartenfluss_Enum;
   KartenfeldRessource : KartengrundDatentypen.Karten_Ressourcen_Enum;
   
   Stadtart : KartenVerbesserungDatentypen.Karten_Verbesserung_Stadt_ID_Enum;
   Wegfeld : KartenVerbesserungDatentypen.Karten_Weg_Enum;
   Verbesserungsfeld : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
   
   DickeRahmen : constant Float := 5.00;
   YMultiplikator : Float;
   XMultiplikator : Float;
      
   StadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   EinheitStadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   
   AktuelleFarbe : Sf.Graphics.Color.sfColor;
   
   Position : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWertRahmen : KartenRecords.AchsenKartenfeldPositivRecord;
   KartenWertStadtname : KartenRecords.AchsenKartenfeldPositivRecord;
   
   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;
   RechteckBelegtesFeldAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;
   RechteckRahmenAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   KreisAccess : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;
   PolygonAccess : constant Sf.Graphics.sfCircleShape_Ptr := Sf.Graphics.CircleShape.create;
   
   type Umgebung_Enum is (Norden, Westen, Osten, Süden);
   
   type UmgebungArray is array (Umgebung_Enum'Range) of KartenRecords.AchsenKartenfeldRecord;
   Umgebung : constant UmgebungArray := (
                                         Norden => (0, -1, 0),
                                         Westen => (0, 0, -1),
                                         Osten  => (0, 0, 1),
                                         Süden  => (0, 1, 0)
                                        );
   
   procedure Sichtbarkeit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure IstSichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f);

   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f);

   procedure AnzeigeStadt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f);

   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f);

   procedure AnzeigeCursor
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f);
   
   procedure AnzeigeFeldbesitzer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f);
   
   procedure RahmenBesetztesFeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure RahmenZeichnen
     (WelcheRichtungExtern : in Umgebung_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
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

end KarteSFML;
