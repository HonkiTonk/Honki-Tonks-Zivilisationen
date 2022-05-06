pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with ForschungenDatentypen; use ForschungenDatentypen;
with KartenDatentypen;
with KartenRecords;
with SonstigeVariablen;
with KartenRecordKonstanten;

with UmwandlungenAdaNachEigenes;

package KarteWichtigesSFML is

   function WichtigesInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_Mensch_Enum
          and
            TextpositionExtern.x > 0.00
          and
            TextpositionExtern.y > 0.00),
   
         Post =>
           (WichtigesInformationen'Result.x > 0.00
            and
              WichtigesInformationen'Result.y > 0.00);
   
private

   SchriftartFestgelegt : Boolean := False;
   SchriftfarbeFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;

   AktuellerGeldgewinn : EinheitStadtDatentypen.KostenLager;
   LetzterGeldgewinn : EinheitStadtDatentypen.KostenLager := -1;

   AktuellesForschungsprojekt : ForschungenDatentypen.ForschungIDMitNullWert;
   LetztesForschungsprojekt : ForschungenDatentypen.ForschungIDNichtMöglich := -1;

   AktuelleForschungszeit : EinheitStadtDatentypen.KostenLager;
   LetzteForschungszeit : EinheitStadtDatentypen.KostenLager := -1;

   AktuelleForschungsmenge : EinheitStadtDatentypen.KostenLager;
   LetzteForschungsmenge : EinheitStadtDatentypen.KostenLager := -1;

   AktuelleForschungsrate : EinheitStadtDatentypen.KostenLager;
   LetzteForschungsrate : EinheitStadtDatentypen.KostenLager := -1;

   AktuelleRunde : Positive;
   LetzteRunde : Natural := 1;

   AktuelleGeldmenge : Integer;
   LetzteGeldmenge : Integer := -10;
   
   Zeilenabstand : Float;

   WertOhneTrennzeichen : Unbounded_Wide_Wide_String;
   YAchsenWert : Unbounded_Wide_Wide_String;
   XAchsenWert : Unbounded_Wide_Wide_String;

   LetzteKoordinaten : KartenRecords.AchsenKartenfeldPositivRecord := KartenRecordKonstanten.LeerKartenKoordinaten;
   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldPositivRecord;
   
   Textposition : Sf.System.Vector2.sfVector2f;

   type TextAccessArray is array (1 .. 8) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (others => Sf.Graphics.Text.create);
   
   function SchriftartFestlegen
     return Boolean;

   function SchriftgrößenFestlegen
     return Boolean;

   function SchriftfarbenFestlegen
     return Boolean;

   function ZahlAlsStringInteger is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => Integer);

   function ZahlAlsStringKostenLager is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => EinheitStadtDatentypen.KostenLager);

   function ZahlAlsStringEbeneVorhanden is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.EbeneVorhanden);

   function ZahlAlsStringKartenfeldPositivMitNullwert is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.KartenfeldPositivMitNullwert);

end KarteWichtigesSFML;
