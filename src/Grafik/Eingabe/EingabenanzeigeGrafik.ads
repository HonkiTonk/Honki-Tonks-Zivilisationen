pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.Graphics;
private with Sf.Graphics.Color;
private with Sf.System.Vector2;

with RassenDatentypen;
with ZahlenDatentypen;
with SystemDatentypen;

private with EinheitenRecords;
private with StadtRecords;
private with TextKonstanten;

private with UmwandlungenAdaNachEigenes;

package EingabenanzeigeGrafik is
   
   procedure Fragenaufteilung
     (FrageExtern : in ZahlenDatentypen.EigenesPositive;
      EingabeExtern : in SystemDatentypen.Eingaben_Fragen_Enum);
   
   -- Später KORREKTEN Contract einfügen. äöü
   procedure AnzeigeEinheitenStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
private
   
   AktuelleAuswahl : Integer;
   
   Textbreite : Float;
   
   Text : Unbounded_Wide_Wide_String;
   
   WelcheAuswahl : EinheitenRecords.AuswahlRecord;
   
   StadtRasseNummer : StadtRecords.RasseStadtnummerRecord;
   
   EinheitRasseNummer : EinheitenRecords.RasseEinheitnummerRecord;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := TextKonstanten.StartpositionText;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   Farbe : Sf.Graphics.Color.sfColor;

   procedure AnzeigeGanzeZahl;
   procedure AnzeigeText;
   procedure AnzeigeJaNein;
   
   
   
   function ZahlAlsStringNatural is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => Natural);

end EingabenanzeigeGrafik;
