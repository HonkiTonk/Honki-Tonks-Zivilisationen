pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Rect;
with Sf.System.Vector2;

with Views;

package GrafikRecordKonstanten is

   StartgrößeView : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   
   
   
   Leerbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 0.00, 0.00);
   Gesamtbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 1.00, 1.00);
   
   Sprachenbereich : constant Sf.Graphics.Rect.sfFloatRect := Gesamtbereich;
   Forschungserfolgbereich : constant Sf.Graphics.Rect.sfFloatRect := Gesamtbereich;
   Abspannbereich : constant Sf.Graphics.Rect.sfFloatRect := Gesamtbereich;
   
   Überschriftbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 1.00, 0.10);
   Unterschriftbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, Überschriftbereich.height, 1.00, 1.00 - Überschriftbereich.height);
   
   KarteAnzeigebereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 0.80, 1.00);
   Kartenbefehlsbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.60, 0.80, 0.20, 0.20);
   Einheitenbefehlsbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.60, 0.60, 0.20, 0.20);
     
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
                                                                                    1 => (0.00, Überschriftbereich.height, 0.66, 1.00 - Überschriftbereich.height),
                                                                                    2 => (0.66, Überschriftbereich.height, 0.35, 1.00 - Überschriftbereich.height)
                                                                                   );
      
   SeitenleisteWeltkartenbereich : constant BereicheArray (Views.SeitenleisteWeltkarteAccesse'Range) := (
                                                                                                         1 => (KarteAnzeigebereich.width, 0.00, 1.00 - KarteAnzeigebereich.width, 0.20),
                                                                                                         2 => (KarteAnzeigebereich.width, 0.20, 1.00 - KarteAnzeigebereich.width, 0.10),
                                                                                                         3 => (KarteAnzeigebereich.width, 0.30, 1.00 - KarteAnzeigebereich.width, 0.35),
                                                                                                         4 => (KarteAnzeigebereich.width, 0.65, 1.00 - KarteAnzeigebereich.width, 0.35)
                                                                                                        );
   
   Forschungsbereich : constant BereicheArray (Views.ForschungsviewAccesse'Range) := (
                                                                                      1 => (0.00, 0.10, 0.50, 0.40),
                                                                                      2 => (0.50, 0.10, 0.50, 0.40),
                                                                                      3 => (0.00, 0.50, 1.00, 0.40),
                                                                                      4 => (0.00, 0.90, 1.00, 0.10)
                                                                                     );
   
   Baumenübereich : constant BereicheArray (Views.BauviewAccesse'Range) := (
                                                                             1 => (0.00, 0.10, 0.50, 0.80),
                                                                             2 => (0.50, 0.10, 0.50, 0.80),
                                                                             3 => (0.50, 0.10, 0.50, 0.40),
                                                                             4 => (0.50, 0.50, 0.50, 0.40),
                                                                             5 => (0.00, 0.10, 0.50, 0.40),
                                                                             6 => (0.00, 0.50, 0.50, 0.40),
                                                                             7 => (0.00, 0.90, 1.00, 0.10)
                                                                            );
   
   Verkausmenübereich : constant BereicheArray (Views.VerkaufsviewAccesse'Range) := (
                                                                                      1 => (0.00, 0.10, 0.50, 0.90),
                                                                                      2 => (0.50, 0.10, 0.50, 0.90)
                                                                                     );
   
   -- Später durch Enum'Range ersetzen? Bei allen Arrays? äöü
   -- 1 = Stadtkarte, 2 = Stadtumgebung, 3 = Stadtbefehle, 4 = Stadtseitenleiste
   Stadtbereich : constant BereicheArray (Views.StadtviewAccesse'Range) := (
                                                                            1 => (0.00, 0.00, 0.75, 1.00),
                                                                            2 => (0.75, 0.00, 0.25, 0.25),
                                                                            3 => (0.75, 0.25, 0.25, 0.25),
                                                                            4 => (0.75, 0.50, 0.25, 0.50)
                                                                           );
   
   Editorenbereich : constant BereicheArray (Views.EditorenviewAccesse'Range) := (
                                                                                  1 => Unterschriftbereich,
                                                                                  2 => Gesamtbereich
                                                                                 );

end GrafikRecordKonstanten;
