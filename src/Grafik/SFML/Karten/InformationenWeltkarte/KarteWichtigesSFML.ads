pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with SpielVariablen;

private with KartenDatentypen;
private with KartenRecords;

private with UmwandlungenAdaNachEigenes;

package KarteWichtigesSFML is

   function WichtigesInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 TextpositionExtern.x > 0.00
               and
                 TextpositionExtern.y > 0.00
              ),
   
       Post => (
                  WichtigesInformationen'Result.x > 0.00
                and
                  WichtigesInformationen'Result.y > 0.00
               );
   
private
      
   WertOhneTrennzeichen : Unbounded_Wide_Wide_String;
   YAchsenWert : Unbounded_Wide_Wide_String;
   XAchsenWert : Unbounded_Wide_Wide_String;

   AktuelleKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Textposition : Sf.System.Vector2.sfVector2f;

   function ZahlAlsStringInteger is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => Integer);

   function ZahlAlsStringKostenLager is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => ProduktionDatentypen.Produktion);

   function ZahlAlsStringEbeneVorhanden is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.EbeneVorhanden);

   function ZahlAlsStringKartenfeldPositivMitNullwert is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.KartenfeldNatural);

end KarteWichtigesSFML;
