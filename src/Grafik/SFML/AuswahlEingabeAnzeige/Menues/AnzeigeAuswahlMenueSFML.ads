pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.Color;

with SystemDatentypen;

package AnzeigeAuswahlMenueSFML is

   procedure AnzeigeAnfang;
   
private
      
   WelchesMenü : SystemDatentypen.Welches_Menü_Enum;
   
   Anfang : Positive;
   Ende : Positive;
   AktuelleAuswahl : Positive;
   RassenBelegt : Positive;
   RassenBelegtZähler : Positive;
   ErstesZeichen : Positive;

   AnzeigeStartwert : Natural;
   
   StartPositionYAchse : constant Float := 10.00;
   StartPositionXAchse : constant Float := 10.00;
   YPosition : Float;
   ZeilenAbstand : Float;
   
   AktuellerText : Unbounded_Wide_Wide_String;
   
   AktuellePosition : Sf.System.Vector2.sfVector2f;
   
   AktuelleFarbe : Sf.Graphics.Color.sfColor;
   
   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   procedure AnzeigeMenü;
   procedure Überschrift;
   procedure WeiterenTextAnzeigen;
   
   procedure AnzeigeFarbeBestimmen
     (TextZeileExtern : in Positive);

end AnzeigeAuswahlMenueSFML;
