with Sf.Graphics;
with Sf.Graphics.View;

with ViewKonstanten;

package Views is
   pragma Elaborate_Body;

   ÜberschriftviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   VersionsnummerviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   -- Die beiden zusammenfassen? äöü
   MenüviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   ZusatztextviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   LadeviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   MeldungssviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   KartenbefehlsviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   EinheitenbefehlsviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   AbspannviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   StadtEinheitviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   type ViewsArray is array (Positive range <>) of Sf.Graphics.sfView_Ptr;

   FragenviewAccesse : constant ViewsArray (ViewKonstanten.Frage .. ViewKonstanten.Antwort) := (others => Sf.Graphics.View.create);
   SteuerungviewAccesse : constant ViewsArray (ViewKonstanten.SteuerungKategorie .. ViewKonstanten.SteuerungAuswahl) := (others => Sf.Graphics.View.create);

   WeltkarteAccess : constant ViewsArray (ViewKonstanten.WeltKarte .. ViewKonstanten.WeltEinheit) := (others => Sf.Graphics.View.create);
   StadtviewAccesse : constant ViewsArray (ViewKonstanten.StadtUmgebung .. ViewKonstanten.StadtKarte) := (others => Sf.Graphics.View.create);

   ForschungsviewAccesse : constant ViewsArray (ViewKonstanten.ForschungsmenüForschungsliste .. ViewKonstanten.ForschungsmenüErfolg) := (others => Sf.Graphics.View.create);
   BauviewAccesse : constant ViewsArray (ViewKonstanten.BaumenüGebäudeliste .. ViewKonstanten.BaumenüGebäudebeschreibungVerkaufen) := (others => Sf.Graphics.View.create);

   EditorenviewAccesse : constant ViewsArray (1 .. 2) := (others => Sf.Graphics.View.create);

   InformationsfeldAccesse : constant ViewsArray (ViewKonstanten.InformationsfeldStadtkarte .. ViewKonstanten.InformationsfeldStadtkarte) := (others => Sf.Graphics.View.create);

end Views;
