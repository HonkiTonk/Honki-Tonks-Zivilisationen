pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;
with Sf.Graphics;
with Sf.Graphics.RectangleShape;
with Sf.System.Vector2;

with RassenDatentypen;
with EinheitStadtRecords;

with AuswahlStadtEinheit;
with UmwandlungenAdaNachEigenes;

package AnzeigeEingabeSFML is

   procedure AnzeigeGanzeZahl;
   procedure AnzeigeText;
   
   -------------------- Contracts hinzufügen.
   procedure AnzeigeEinheitenStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
private
   
   WelchesVorzeichen : Boolean;
   
   WelcheFrage : Positive;
   
   AktuelleAuswahl : Integer;
   
   Zeilenabstand : Float;
   
   AktuellerText : Unbounded_Wide_Wide_String;
   AktuellerWert : Unbounded_Wide_Wide_String;
   
   WelcheAuswahl : AuswahlStadtEinheit.AuswahlRecord;
   
   StadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   EinheitRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   
   TextPosition : Sf.System.Vector2.sfVector2f;
   
   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;
   
   
   
   function ZahlAlsStringNatural is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => Natural);

end AnzeigeEingabeSFML;
