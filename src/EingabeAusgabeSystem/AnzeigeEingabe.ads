pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;
with Sf.Graphics;

package AnzeigeEingabe is

   procedure AnzeigeGanzeZahl;
   
private
   
   WelchesVorzeichen : Boolean;
   
   WelcheFrage : Positive;
   
   AktuellerWert : Natural;
   
   AktuellerText : Unbounded_Wide_Wide_String;
   
   TextAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

end AnzeigeEingabe;
