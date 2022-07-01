pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.Graphics;
private with Sf.Graphics.RectangleShape;
private with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with EinheitenRecords;
private with StadtRecords;

private with AuswahlStadtEinheit;
private with UmwandlungenAdaNachEigenes;

package AnzeigeEingabeSFML is

   procedure AnzeigeGanzeZahl;
   procedure AnzeigeText;
   procedure AnzeigeJaNein;
   
   procedure AnzeigeEinheitenStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
      
   WelcheFrage : Natural;
   
   AktuelleAuswahl : Integer;
   
   Zeilenabstand : Float;
   Textbreite : Float;
   
   AktuellerText : Unbounded_Wide_Wide_String;
   AktuellerWert : Unbounded_Wide_Wide_String;
   
   WelcheAuswahl : AuswahlStadtEinheit.AuswahlRecord;
   
   StadtRasseNummer : StadtRecords.RasseStadtnummerRecord;
   
   EinheitRasseNummer : EinheitenRecords.RasseEinheitnummerRecord;
   
   TextPosition : Sf.System.Vector2.sfVector2f;
   
   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;
   
   
   
   function ZahlAlsStringNatural is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => Natural);

end AnzeigeEingabeSFML;
