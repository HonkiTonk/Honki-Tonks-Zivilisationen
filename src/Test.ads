with Sf.Graphics.Text;
with Sf.Graphics;

package Test is
   
   procedure Test;
   
private

   TestAccess : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   Text : constant Wide_Wide_String (1 .. 3) := "aAÄ";

end Test;
