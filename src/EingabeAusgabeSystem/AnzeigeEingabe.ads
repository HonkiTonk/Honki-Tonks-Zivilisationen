pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;
with Sf.Graphics;
with Sf.Graphics.RectangleShape;

with EinheitStadtRecords;

with AuswahlStadtEinheit;

package AnzeigeEingabe is

   procedure AnzeigeGanzeZahl;
   procedure AnzeigeText;
   procedure AnzeigeEinheitenStadt;
   
private
   
   WelchesVorzeichen : Boolean;
   
   WelcheFrage : Positive;
   
   AktuellerWert : Natural;
   
   AktuelleAuswahl : Integer;
   
   AktuellerText : Unbounded_Wide_Wide_String;
   
   WelcheAuswahl : AuswahlStadtEinheit.AuswahlRecord;
   
   StadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   EinheitRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   
   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   RechteckAccess : constant Sf.Graphics.sfRectangleShape_Ptr := Sf.Graphics.RectangleShape.create;

end AnzeigeEingabe;
