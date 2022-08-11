pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.Graphics;
private with Sf.Graphics.RectangleShape;
private with Sf.System.Vector2;

with RassenDatentypen;
with ZahlenDatentypen;
with SystemDatentypen;

private with EinheitenRecords;
private with StadtRecords;

private with AuswahlStadtEinheit;
private with UmwandlungenAdaNachEigenes;

package AnzeigeEingabeSFML is
   
   procedure Fragenaufteilung
     (FrageExtern : in ZahlenDatentypen.EigenesNatural;
      EingabeExtern : in SystemDatentypen.Eingaben_Fragen_Enum);
   
   -- Später KORREKTEN Contract einfügen. äöü
   procedure AnzeigeEinheitenStadt
     (RasseExtern : in RassenDatentypen.Rassen_Enum);
   
private
         
   AktuelleAuswahl : Integer;
   
   Textbreite : Float;
   
   AktuellerText : Unbounded_Wide_Wide_String;
   AktuellerWert : Unbounded_Wide_Wide_String;
   
   WelcheAuswahl : AuswahlStadtEinheit.AuswahlRecord;
   
   StadtRasseNummer : StadtRecords.RasseStadtnummerRecord;
   
   EinheitRasseNummer : EinheitenRecords.RasseEinheitnummerRecord;
   
   Startposition : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   Viewfläche : Sf.System.Vector2.sfVector2f := Startposition;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

   procedure AnzeigeGanzeZahl
     (FrageExtern : in ZahlenDatentypen.EigenesNatural);
   
   procedure AnzeigeText
     (FrageExtern : in ZahlenDatentypen.EigenesNatural);
   
   procedure AnzeigeJaNein
     (FrageExtern : in ZahlenDatentypen.EigenesNatural);
   
   
   
   function ZahlAlsStringNatural is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => Natural);

end AnzeigeEingabeSFML;
