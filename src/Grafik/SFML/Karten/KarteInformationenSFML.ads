pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.RectangleShape;
with Sf.Graphics.Rect;
with Sf.Graphics.View;

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtRecords;
with EinheitStadtDatentypen;
with KartenDatentypen;
with KartenGrundDatentypen;
with KartenVerbesserungDatentypen;

with UmwandlungenAdaNachEigenes;

package KarteInformationenSFML is

   procedure KarteInformationenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch_Enum);

private

   KartenGrund : KartenGrundDatentypen.Karten_Grund_Enum;
   KartenFluss : KartenGrundDatentypen.Karten_Fluss_Enum;
   KartenRessource : KartenGrundDatentypen.Karten_Ressourcen_Enum;

   KartenVerbesserung : KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
   KartenWeg : KartenVerbesserungDatentypen.Karten_Weg_Enum;

   StadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   EinheitRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;

   Zeilenabstand : Float;

   WertOhneTrennzeichen : Unbounded_Wide_Wide_String;
   YAchsenWert : Unbounded_Wide_Wide_String;
   XAchsenWert : Unbounded_Wide_Wide_String;

   StartpunktText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);

   FensterInformationen : Sf.System.Vector2.sfVector2f;
   ZeichenPosition : Sf.System.Vector2.sfVector2f;
   PositionText : Sf.System.Vector2.sfVector2f;

   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

   RechteckAcces : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   InformationenViewGröße : Sf.Graphics.Rect.sfFloatRect;

   InformationenViewAcces : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.createFromRect (rectangle => InformationenViewGröße);

   procedure WichtigesInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure StadtInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure EinheitInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure AllgemeineInformationen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure DebugInformationen;



   function ZahlAlsStringInteger is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => Integer);

   function ZahlAlsStringKostenLager is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => EinheitStadtDatentypen.KostenLager);

   function ZahlAlsStringEbeneVorhanden is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.EbeneVorhanden);

   function ZahlAlsStringKartenfeldPositivMitNullwert is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.KartenfeldPositivMitNullwert);

end KarteInformationenSFML;
