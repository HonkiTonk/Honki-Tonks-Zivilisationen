pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with ForschungenDatentypen; use ForschungenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
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
   
   AktuellerGeldgewinn : ProduktionDatentypen.KostenLager;
   LetzterGeldgewinn : ProduktionDatentypen.KostenLager := -1;

   AktuellesForschungsprojekt : ForschungenDatentypen.ForschungIDMitNullWert;
   LetztesForschungsprojekt : ForschungenDatentypen.ForschungIDNichtMöglich := -1;

   AktuelleForschungszeit : ProduktionDatentypen.KostenLager;
   LetzteForschungszeit : ProduktionDatentypen.KostenLager := -1;

   AktuelleForschungsmenge : ProduktionDatentypen.KostenLager;
   LetzteForschungsmenge : ProduktionDatentypen.KostenLager := -1;

   AktuelleForschungsrate : ProduktionDatentypen.KostenLager;
   LetzteForschungsrate : ProduktionDatentypen.KostenLager := -1;

   AktuelleRunde : Positive;
   LetzteRunde : Natural := 1;

   AktuelleGeldmenge : Integer;
   LetzteGeldmenge : Integer := -10;
   
   Zeilenabstand : Float;

   WertOhneTrennzeichen : Unbounded_Wide_Wide_String;
   YAchsenWert : Unbounded_Wide_Wide_String;
   XAchsenWert : Unbounded_Wide_Wide_String;

   LetzteKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord := KartenRecordKonstanten.LeerKartenKoordinaten;
   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Textposition : Sf.System.Vector2.sfVector2f;

   function ZahlAlsStringInteger is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => Integer);

   function ZahlAlsStringKostenLager is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => ProduktionDatentypen.KostenLager);

   function ZahlAlsStringEbeneVorhanden is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.EbeneVorhanden);

   function ZahlAlsStringKartenfeldPositivMitNullwert is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.KartenfeldNatural);

end KarteWichtigesSFML;
