with Sf.Graphics.Rect;
with Sf.System.Vector2;
with Sf.Graphics.Color;

with Views;
with ViewKonstanten;
with GrafikRecords;

package GrafikRecordKonstanten is
   pragma Elaborate_Body;

   StartView : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   
   Nullposition : constant Sf.System.Vector2.sfVector2f := (0.00, 0.00);
   FalschePosition : constant Sf.System.Vector2.sfVector2f := (-1.00, -1.00);
   
   Standardskalierung : constant Sf.System.Vector2.sfVector2f := (1.00, 1.00);
   
   Leerbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 0.00, 0.00);
   Gesamtbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 1.00, 1.00);
   
   Fehlerfarbe : constant Sf.Graphics.Color.sfColor := Sf.Graphics.Color.sfCyan;
   
   Anfangsviewbereich : constant GrafikRecords.ViewbereichRecord := (
                                                                     Viewbereich    => StartView,
                                                                     ViewbereichAlt => Nullposition
                                                                    );
   
   
   
   -- Hier mal Dinge in Arrays zusammenfassen. äöü
   -- Und eventuell in einen eigenen Bereich verschieben? äöü
   Bildratenbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 0.05, 0.05);
     
   SprachenTexturenMusikSoundbereich : constant Sf.Graphics.Rect.sfFloatRect := Gesamtbereich;
   Sequenzbereich : constant Sf.Graphics.Rect.sfFloatRect := Gesamtbereich;
   
   Überschriftbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 1.00, 0.10);
   Unterschriftbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, Überschriftbereich.height, 1.00, 1.00 - Überschriftbereich.height);
        
   Versionsbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.35, 0.95, 0.30, 0.05);
   MenüEinfachbereich : constant Sf.Graphics.Rect.sfFloatRect := Unterschriftbereich;
   Ladebereich : constant Sf.Graphics.Rect.sfFloatRect := Unterschriftbereich;
   
   Meldungsbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.25, 0.45, 0.50, 0.05);
   Fragenbereich : constant Sf.Graphics.Rect.sfFloatRect := Meldungsbereich;
   Eingabebereich : constant Sf.Graphics.Rect.sfFloatRect := (Meldungsbereich.left, Meldungsbereich.top + Meldungsbereich.height, Meldungsbereich.width, Meldungsbereich.height);
   JaNeinBereich : constant Sf.Graphics.Rect.sfFloatRect := (Meldungsbereich.left, Meldungsbereich.top + Meldungsbereich.height, Meldungsbereich.width, 2.00 * Meldungsbereich.height);
   
   type BereicheArray is array (Positive range <>) of Sf.Graphics.Rect.sfFloatRect;
   MenüDoppelbereich : constant BereicheArray (Views.MenüviewAccesse'Range) := (
                                                                                  ViewKonstanten.MenüAuswahl    => (0.00, Überschriftbereich.height, 0.25, 1.00 - Überschriftbereich.height),
                                                                                  ViewKonstanten.MenüZusatztext => (0.25, Überschriftbereich.height, 0.75, 1.00 - Überschriftbereich.height)
                                                                                 );
   
   Steuerungbereich : constant BereicheArray (Views.SteuerungviewAccesse'Range) := (
                                                                                    ViewKonstanten.SteuerungKategorie => (0.00, Überschriftbereich.height, 1.00, 0.05),
                                                                                    ViewKonstanten.SteuerungAuswahl   => (0.00, Überschriftbereich.height + 0.05, 1.00, 1.00 - Überschriftbereich.height - 0.05)
                                                                                   );
   
   -- Das so lassen? Oder mit Steuerungbereich zusammenfassen? äöü
   Spielstandbereich : constant BereicheArray (Views.SpielstandviewAccesse'Range) := (
                                                                                      ViewKonstanten.SpielstandKategorie => Steuerungbereich (1),
                                                                                      ViewKonstanten.SpielstandAuswahl   => Steuerungbereich (2)
                                                                                     );
   
   Kartenbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 0.80, 1.00);
   Weltkartenbereich : constant BereicheArray (Views.WeltkarteAccesse'Range) := (
                                                                                 ViewKonstanten.WeltKarte                  => Kartenbereich,
                                                                                 ViewKonstanten.WeltBefehleRechts          => (0.59, 0.79, 0.20, 0.20),
                                                                                 ViewKonstanten.WeltBefehleLinks           => (0.01, 0.79, 0.20, 0.20),
                                                                                 ViewKonstanten.WeltEinheitenbefehleRechts => (0.59, 0.59, 0.20, 0.20),
                                                                                 ViewKonstanten.WeltEinheitenbefehleLinks  => (0.01, 0.59, 0.20, 0.20),
                                                                                 ViewKonstanten.WeltSeitenleiste           => (Kartenbereich.width, 0.00, 1.00 - Kartenbereich.width, 1.00)
                                                                                );
   
   Forschungsbereich : constant BereicheArray (Views.ForschungsviewAccesse'Range) := (
                                                                                      ViewKonstanten.ForschungsmenüForschungsliste => (0.00, 0.10, 0.50, 0.40),
                                                                                      ViewKonstanten.ForschungsmenüErmöglicht      => (0.50, 0.10, 0.50, 0.40),
                                                                                      ViewKonstanten.ForschungsmenüBeschreibung    => (0.00, 0.50, 1.00, 0.40),
                                                                                      ViewKonstanten.ForschungsmenüAktuell         => (0.00, 0.90, 1.00, 0.10),
                                                                                      ViewKonstanten.ForschungsmenüErfolg          => Gesamtbereich
                                                                                     );
   
   Baumenübereich : constant BereicheArray (Views.BauviewAccesse'Range) := (
                                                                             ViewKonstanten.BaumenüKategorie      => (0.00, Überschriftbereich.height, 1.00, 0.05),
                                                                             ViewKonstanten.BaumenüBauliste       => (0.00, 0.15, 0.50, 0.80),
                                                                             ViewKonstanten.BaumenüInformationen  => (0.50, 0.15, 0.50, 0.40),
                                                                             ViewKonstanten.BaumenüBeschreibung   => (0.50, 0.55, 0.50, 0.40),
                                                                             ViewKonstanten.BaumenüAktuell        => (0.00, 0.95, 1.00, 0.05),
                                                                             
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
   
   StadtEinheitAuswahlbereich : constant BereicheArray (ViewKonstanten.AuswahlbereichStadt .. ViewKonstanten.AuswahlbereichEinheit) := (
                                                                                                                                        ViewKonstanten.AuswahlbereichStadt   => (0.25, 0.45, 0.50, 0.10),
                                                                                                                                        ViewKonstanten.AuswahlbereichEinheit => (0.25, 0.35, 0.50, 0.30)
                                                                                                                                       );
   
   Editorenbereich : constant BereicheArray (Views.EditorenviewAccesse'Range) := (
                                                                                  1 => Unterschriftbereich,
                                                                                  2 => Gesamtbereich
                                                                                 );

end GrafikRecordKonstanten;
