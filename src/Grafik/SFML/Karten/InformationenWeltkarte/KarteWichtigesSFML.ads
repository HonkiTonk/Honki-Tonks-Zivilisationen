pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SpielVariablen;
with KartenRecords;

private with TextaccessVariablen;
private with ProduktionDatentypen;

with Karten;

private with UmwandlungenAdaNachEigenes;

package KarteWichtigesSFML is

   function WichtigesInformationen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 TextpositionExtern.x > 0.00
               and
                 TextpositionExtern.y > 0.00
               and
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
              ),
   
       Post => (
                  WichtigesInformationen'Result.x > 0.00
                and
                  WichtigesInformationen'Result.y > 0.00
               );
   
private
   
   TextbreiteAktuell : Float;
   TextbreiteNeu : Float;
      
   Textposition : Sf.System.Vector2.sfVector2f;
   
   -- Das ohne Grenze mal irgendwo Global anlegen? äöü
   type FestzulegenderTextArray is array (TextaccessVariablen.KarteWichtigesAccessArray'Range) of Unbounded_Wide_Wide_String;
   FestzulegenderText : FestzulegenderTextArray;

   
   
   function ZahlAlsStringKostenLager is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => ProduktionDatentypen.Produktion);
   
   function ZahlAlsStringEbeneVorhanden is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.EbeneVorhanden);

end KarteWichtigesSFML;
