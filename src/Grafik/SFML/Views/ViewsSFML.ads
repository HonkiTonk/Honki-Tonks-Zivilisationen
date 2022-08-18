pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.View;

package ViewsSFML is

   type ViewsArray is array (Positive range <>) of Sf.Graphics.sfView_Ptr;
   Views : constant ViewsArray (1 .. 5) := (others => null);

   StandardviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   MenüviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   KartenviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   SeitenleisteKartenviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   BauForschungsviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   ZusatztextviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   ForschungsviewAccesse : constant ViewsArray (1 .. 5) := (others => Sf.Graphics.View.create);
   BauviewAccesse : constant ViewsArray (1 .. 6) := (others => Sf.Graphics.View.create);

end ViewsSFML;
