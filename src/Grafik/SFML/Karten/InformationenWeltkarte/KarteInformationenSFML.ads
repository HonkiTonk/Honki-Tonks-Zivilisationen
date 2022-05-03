pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.RectangleShape;
with Sf.Graphics.Rect;
with Sf.Graphics.View;

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with SonstigeVariablen;
with EinheitStadtRecords;
with KartenDatentypen;
with KartenRecords;
with KartenRecordKonstanten;

with UmwandlungenAdaNachEigenes;

package KarteInformationenSFML is

   procedure KarteInformationenSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_Mensch_Enum);

private

   SchriftartFestgelegt : Boolean := False;
   SchriftfarbeFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;

   StadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   EinheitRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;

   Zeilenabstand : Float;

   WertOhneTrennzeichen : Unbounded_Wide_Wide_String;
   YAchsenWert : Unbounded_Wide_Wide_String;
   XAchsenWert : Unbounded_Wide_Wide_String;

   LetzteKoordinaten : KartenRecords.AchsenKartenfeldPositivRecord := KartenRecordKonstanten.LeerKartenKoordinaten;
   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldPositivRecord;

   StartpunktText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);

   FensterInformationen : Sf.System.Vector2.sfVector2f;
   ZeichenPosition : Sf.System.Vector2.sfVector2f;
   Textposition : Sf.System.Vector2.sfVector2f;

   RechteckAcces : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   InformationenViewGröße : Sf.Graphics.Rect.sfFloatRect;

   InformationenViewAcces : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.createFromRect (rectangle => InformationenViewGröße);

   procedure StadtInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_Mensch_Enum);

   procedure EinheitInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_Mensch_Enum);

   procedure DebugInformationen;



   function ZahlAlsStringInteger is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => Integer);

   function ZahlAlsStringKostenLager is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => EinheitStadtDatentypen.KostenLager);

   function ZahlAlsStringEbeneVorhanden is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.EbeneVorhanden);

   function ZahlAlsStringKartenfeldPositivMitNullwert is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.KartenfeldPositivMitNullwert);

end KarteInformationenSFML;