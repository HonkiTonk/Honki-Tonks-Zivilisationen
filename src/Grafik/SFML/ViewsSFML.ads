pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.View;

package ViewsSFML is

   StandardviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   MenüviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   KartenviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   SeitenleisteKartenviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   BauForschungsviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   ZusatztextviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

end ViewsSFML;
