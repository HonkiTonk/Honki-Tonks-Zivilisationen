pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.View;

package ViewsSFML is

   ÜberschriftviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   MenüviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   KartenviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   SeitenleisteKartenviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   -- Kann später vermutlich auch weg. äöü
   ZusatztextviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   type ViewsArray is array (Positive range <>) of Sf.Graphics.sfView_Ptr;

   ForschungsviewAccesse : constant ViewsArray (1 .. 4) := (others => Sf.Graphics.View.create);
   BauviewAccesse : constant ViewsArray (1 .. 5) := (others => Sf.Graphics.View.create);

end ViewsSFML;
