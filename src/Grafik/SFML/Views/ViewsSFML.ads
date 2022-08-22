pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.View;

-- Umbenennen nach Views und nach Globales verschieben.
package ViewsSFML is

   -- Wenn Auswahlmöglichkeiten auf andere Views gelegt werden, dann muss auch immer die Korrekturrechnung der Mausposition angepasst werden!
   ÜberschriftviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   VersionsnummerviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   MenüviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   KartenviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   SeitenleisteKartenviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   -- Kann später vermutlich auch weg. äöü
   ZusatztextviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   type ViewsArray is array (Positive range <>) of Sf.Graphics.sfView_Ptr;

   FragenviewAccesse : constant ViewsArray (1 .. 2) := (others => Sf.Graphics.View.create);

   SeitenleisteWeltkarteAccesse : constant ViewsArray (1 .. 4) := (others => Sf.Graphics.View.create);

   ForschungsviewAccesse : constant ViewsArray (1 .. 4) := (others => Sf.Graphics.View.create);
   BauviewAccesse : constant ViewsArray (1 .. 5) := (others => Sf.Graphics.View.create);

end ViewsSFML;
