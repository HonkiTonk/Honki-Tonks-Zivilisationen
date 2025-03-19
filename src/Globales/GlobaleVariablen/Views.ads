with Sf.Graphics;
with Sf.Graphics.View;

with ViewKonstanten;

   -- Hier mal Dinge in Arrays zusammenfassen. äöü
package Views is
   pragma Elaborate_Body;

   ÜberschriftviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   VersionsnummerviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   BildratenviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   LadeviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   MeldungsviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   KartenbefehlsviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;
   EinheitenbefehlsviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   AbspannviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   StadtEinheitviewAccess : constant Sf.Graphics.sfView_Ptr := Sf.Graphics.View.create;

   -- Es ist möglich einen Großteil der Views hier zusammenzufassen, aber ist das sinnvoll/nützlich? äöü
   type ViewsArray is array (Positive range <>) of Sf.Graphics.sfView_Ptr;

   MenüviewAccesse : constant ViewsArray (ViewKonstanten.MenüAuswahl .. ViewKonstanten.MenüZusatztext) := (others => Sf.Graphics.View.create);

   FragenviewAccesse : constant ViewsArray (ViewKonstanten.Frage .. ViewKonstanten.Antwort) := (others => Sf.Graphics.View.create);
   SteuerungviewAccesse : constant ViewsArray (ViewKonstanten.SteuerungKategorie .. ViewKonstanten.SteuerungScrollleiste) := (others => Sf.Graphics.View.create);
   SpielstandviewAccesse : constant ViewsArray (ViewKonstanten.SpielstandKategorie .. ViewKonstanten.SpielstandAuswahl) := (others => Sf.Graphics.View.create);

   WeltkarteAccesse : constant ViewsArray (ViewKonstanten.WeltKarte .. ViewKonstanten.WeltSeitenleiste) := (others => Sf.Graphics.View.create);
   StadtviewAccesse : constant ViewsArray (ViewKonstanten.StadtUmgebung .. ViewKonstanten.StadtKarte) := (others => Sf.Graphics.View.create);

   ForschungsviewAccesse : constant ViewsArray (ViewKonstanten.ForschungsmenüForschungsliste .. ViewKonstanten.ForschungsmenüErfolg) := (others => Sf.Graphics.View.create);
   BauviewAccesse : constant ViewsArray (ViewKonstanten.BaumenüKategorie .. ViewKonstanten.BaumenüGebäudebeschreibungVerkaufen) := (others => Sf.Graphics.View.create);

   EditorenviewAccesse : constant ViewsArray (1 .. 2) := (others => Sf.Graphics.View.create);

   InformationsfeldAccesse : constant ViewsArray (ViewKonstanten.InformationsfeldStadtkarte .. ViewKonstanten.InformationenFeldproduktion) := (others => Sf.Graphics.View.create);

end Views;
