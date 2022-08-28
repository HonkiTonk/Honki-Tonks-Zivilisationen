pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.View;

package Views is

   -- Wenn Auswahlmöglichkeiten auf andere Views gelegt werden, dann muss auch immer die Korrekturrechnung der Mausposition angepasst werden!
   ÜberschriftviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   VersionsnummerviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   -- Die beiden zusammenfassen? äöü
   MenüviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   ZusatztextviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   LadeviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   KartenviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   BefehlsviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   StadtumgebungviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   type ViewsArray is array (Positive range <>) of Sf.Graphics.sfView_Ptr;

   FragenviewAccesse : constant ViewsArray (1 .. 2) := (others => Sf.Graphics.View.create);
   SteuerungviewAccesse : constant ViewsArray (1 .. 2) := (others => Sf.Graphics.View.create);

   -- Zweidimensionales Array für Weltkarte und Leiste oder Eindimensionales mit Weltkarte zuerst? äöü
   -- Ersteres könnte zu Problemen führen bei Veränderungen. äöü
   SeitenleisteWeltkarteAccesse : constant ViewsArray (1 .. 4) := (others => Sf.Graphics.View.create);

   ForschungsviewAccesse : constant ViewsArray (1 .. 4) := (others => Sf.Graphics.View.create);
   BauviewAccesse : constant ViewsArray (1 .. 5) := (others => Sf.Graphics.View.create);

end Views;
