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

   MeldungssviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   -- Später zusammenfassen. äöü
   KartenviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   KartenbefehlsviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   EinheitenbefehlsviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   ForschungserfolgviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   AbspannviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   StadtEinheitviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   type ViewsArray is array (Positive range <>) of Sf.Graphics.sfView_Ptr;

   FragenviewAccesse : constant ViewsArray (1 .. 2) := (others => Sf.Graphics.View.create);
   SteuerungviewAccesse : constant ViewsArray (1 .. 2) := (others => Sf.Graphics.View.create);

   -- Zweidimensionales Array für Weltkarte und Leiste oder Eindimensionales mit Weltkarte zuerst? äöü
   -- Ersteres könnte zu Problemen führen bei Veränderungen. äöü
   SeitenleisteWeltkarteAccesse : constant ViewsArray (1 .. 4) := (others => Sf.Graphics.View.create);

   -- Später durch Enum'Range ersetzen? Bei allen Arrays? äöü
   -- 1 = Stadtumgebung, 2 = Stadtbefehle, 3 = Stadtseitenleiste, 4 = Stadtkarte
   StadtviewAccesse : constant ViewsArray (1 .. 4) := (others => Sf.Graphics.View.create);

   ForschungsviewAccesse : constant ViewsArray (1 .. 4) := (others => Sf.Graphics.View.create);
   BauviewAccesse : constant ViewsArray (1 .. 7) := (others => Sf.Graphics.View.create);
   VerkaufsviewAccesse : constant ViewsArray (1 .. 2) := (others => Sf.Graphics.View.create);

   EditorenviewAccesse : constant ViewsArray (1 .. 2) := (others => Sf.Graphics.View.create);

end Views;
