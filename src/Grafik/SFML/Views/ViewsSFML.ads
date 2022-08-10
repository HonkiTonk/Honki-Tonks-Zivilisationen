pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.View;

package ViewsSFML is


   type ViewsArray is array (1 .. 5) of Sf.Graphics.sfView_Ptr;
   Views : ViewsArray := (others => null);

   StandardviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   MenüviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   KartenviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   SeitenleisteKartenviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   BauForschungsviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   ZusatztextviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

end ViewsSFML;
