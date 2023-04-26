with Sf.Graphics.Rect;
with Sf.System.Vector2;

with Views;
with ViewKonstanten;

package GrafikRecordKonstanten is
   pragma Elaborate_Body;
   
   Minimalauflösung : constant Sf.System.Vector2.sfVector2u := (640, 480);
   
   

   StartView : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   
   Nullposition : constant Sf.System.Vector2.sfVector2f := (0.00, 0.00);
   FalschePosition : constant Sf.System.Vector2.sfVector2f := (-1.00, -1.00);
   
   Standardskalierung : constant Sf.System.Vector2.sfVector2f := (1.00, 1.00);
   
   
   
   Leerbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 0.00, 0.00);
   Gesamtbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 1.00, 1.00);
   
   Kartenbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 0.80, 1.00);
   Leistendicke : constant Sf.System.Vector2.sfVector2f := (Kartenbereich.width, 1.00 - Kartenbereich.width);
  
   Sprachenbereich : constant Sf.Graphics.Rect.sfFloatRect := Gesamtbereich;
   Abspannbereich : constant Sf.Graphics.Rect.sfFloatRect := Gesamtbereich;
   
   Überschriftbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 1.00, 0.10);
   Unterschriftbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, Überschriftbereich.height, 1.00, 1.00 - Überschriftbereich.height);
        
   Versionsbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.35, 0.95, 0.30, 0.05);
   MenüEinfachbereich : constant Sf.Graphics.Rect.sfFloatRect := Unterschriftbereich;
   Ladebereich : constant Sf.Graphics.Rect.sfFloatRect := Unterschriftbereich;
   
   Fragenbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.25, 0.45, 0.50, 0.05);
   Eingabebereich : constant Sf.Graphics.Rect.sfFloatRect := (Fragenbereich.left, Fragenbereich.top + Fragenbereich.height, Fragenbereich.width, Fragenbereich.height);
   JaNeinBereich : constant Sf.Graphics.Rect.sfFloatRect := (Fragenbereich.left, Fragenbereich.top + Fragenbereich.height, Fragenbereich.width, 2.00 * Fragenbereich.height);
   Meldungsbereich : constant Sf.Graphics.Rect.sfFloatRect := Fragenbereich;
   
   Stadtauswahlbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.25, 0.45, 0.50, 0.10);
   Einheitauswahlbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.25, 0.35, 0.50, 0.30);
   
   type BereicheArray is array (Positive range <>) of Sf.Graphics.Rect.sfFloatRect;
   MenüDoppelbereich : constant BereicheArray (1 .. 2) := (
                                                            1 => (0.00, Überschriftbereich.height, 0.25, 1.00 - Überschriftbereich.height),
                                                            2 => (0.25, Überschriftbereich.height, 0.75, 1.00 - Überschriftbereich.height)
                                                           );
   
   Steuerungbereich : constant BereicheArray (Views.SteuerungviewAccesse'Range) := (
                                                                                    ViewKonstanten.SteuerungKategorie => (0.00, Überschriftbereich.height, 1.00, 0.05),
                                                                                    ViewKonstanten.SteuerungAuswahl   => (0.00, Überschriftbereich.height + 0.05, 1.00, 1.00 - Überschriftbereich.height - 0.05)
                                                                                   );
   
   -- Eventuell die Weltkarte und die Seitenleiste in zwei seperate Records aufteilen? Wäre bei dem neuen System vermutlich besser. äöü
   Weltkartenbereich : constant BereicheArray (Views.WeltkarteAccess'Range) := (
                                                                                ViewKonstanten.WeltKarte                  => Kartenbereich,
                                                                                ViewKonstanten.WeltBefehleRechts          => (0.59, 0.79, 0.20, 0.20),
                                                                                ViewKonstanten.WeltBefehleLinks           => (0.01, 0.79, 0.20, 0.20),
                                                                                ViewKonstanten.WeltEinheitenbefehleRechts => (0.59, 0.59, 0.20, 0.20),
                                                                                ViewKonstanten.WeltEinheitenbefehleLinks  => (0.01, 0.59, 0.20, 0.20),
                                                                                ViewKonstanten.WeltWichtiges              => (Leistendicke.x, 0.00, Leistendicke.y, 0.20),
                                                                                ViewKonstanten.WeltAllgemeines            => (Leistendicke.x, 0.20, Leistendicke.y, 0.10),
                                                                                ViewKonstanten.WeltStadt                  => (Leistendicke.x, 0.30, Leistendicke.y, 0.35),
                                                                                ViewKonstanten.WeltEinheit                => (Leistendicke.x, 0.65, Leistendicke.y, 0.35)
                                                                               );
   
   Forschungsbereich : constant BereicheArray (Views.ForschungsviewAccesse'Range) := (
                                                                                      ViewKonstanten.ForschungsmenüForschungsliste => (0.00, 0.10, 0.50, 0.40),
                                                                                      ViewKonstanten.ForschungsmenüErmöglicht      => (0.50, 0.10, 0.50, 0.40),
                                                                                      ViewKonstanten.ForschungsmenüBeschreibung    => (0.00, 0.50, 1.00, 0.40),
                                                                                      ViewKonstanten.ForschungsmenüAktuell         => (0.00, 0.90, 1.00, 0.10),
                                                                                      ViewKonstanten.ForschungsmenüErfolg          => Gesamtbereich
                                                                                     );
   
   Baumenübereich : constant BereicheArray (Views.BauviewAccesse'Range) := (
                                                                             ViewKonstanten.BaumenüGebäudeliste                  => (0.00, 0.10, 0.50, 0.80),
                                                                             ViewKonstanten.BaumenüEinheitenliste                => (0.50, 0.10, 0.50, 0.80),
                                                                             ViewKonstanten.BaumenüGebäudeinformationen          => (0.50, 0.10, 0.50, 0.40),
                                                                             ViewKonstanten.BaumenüGebäudebeschreibung           => (0.50, 0.50, 0.50, 0.40),
                                                                             ViewKonstanten.BaumenüEinheiteninformationen        => (0.00, 0.10, 0.50, 0.40),
                                                                             ViewKonstanten.BaumenüEinheitenbeschreibung         => (0.00, 0.50, 0.50, 0.40),
                                                                             ViewKonstanten.BaumenüAktuell                       => (0.00, 0.90, 1.00, 0.10),
                                                                             
                                                                             ViewKonstanten.BaumenüGebäudelisteVerkaufen         => (0.00, 0.10, 0.50, 0.90),
                                                                             ViewKonstanten.BaumenüGebäudeinformationenVerkaufen => (0.50, 0.10, 0.50, 0.45),
                                                                             ViewKonstanten.BaumenüGebäudebeschreibungVerkaufen  => (0.50, 0.55, 0.50, 0.45)
                                                                            );
   
   Stadtbereich : constant BereicheArray (Views.StadtviewAccesse'Range) := (
                                                                            ViewKonstanten.StadtUmgebung      => (0.00, 0.00, 0.80, 1.00),
                                                                            ViewKonstanten.StadtInformationen => (0.80, 0.00, 0.20, 0.75),
                                                                            ViewKonstanten.StadtBefehle       => (0.80, 0.75, 0.20, 0.25),
                                                                            ViewKonstanten.StadtKarte         => (0.00, 0.00, 1.00, 1.00)
                                                                           );
   
   Editorenbereich : constant BereicheArray (Views.EditorenviewAccesse'Range) := (
                                                                                  1 => Unterschriftbereich,
                                                                                  2 => Gesamtbereich
                                                                                 );

end GrafikRecordKonstanten;
