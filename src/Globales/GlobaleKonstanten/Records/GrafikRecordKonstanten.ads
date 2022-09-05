pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Rect;
with Sf.System.Vector2;

with Views;

package GrafikRecordKonstanten is

   StartgrößeView : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   
   
   
   Sprachenbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 1.00, 1.00);
   
   KarteAnzeigebereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 0.80, 1.00);
   
   Überschriftbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 1.00, 0.10);
   Versionsbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.35, 0.95, 0.30, 0.05);
   MenüEinfachbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, Überschriftbereich.height, 1.00, 1.00 - Überschriftbereich.height);
   Ladebereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, Überschriftbereich.height, 1.00, 1.00 - Überschriftbereich.height);
   
   Fragenbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.25, 0.45, 0.50, 0.05);
   Eingabebereich : constant Sf.Graphics.Rect.sfFloatRect := (Fragenbereich.left, Fragenbereich.top + Fragenbereich.height, Fragenbereich.width, Fragenbereich.height);
   JaNeinBereich : constant Sf.Graphics.Rect.sfFloatRect := (Fragenbereich.left, Fragenbereich.top + Fragenbereich.height, Fragenbereich.width, 2.00 * Fragenbereich.height);
   Meldungsbereich : constant Sf.Graphics.Rect.sfFloatRect := Fragenbereich;
   
   SeitenleisteGesamtbereich : constant Sf.Graphics.Rect.sfFloatRect := (KarteAnzeigebereich.width, 0.00, 1.00 - KarteAnzeigebereich.width, 1.00);
   
   StadtkarteAnzeigebereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 0.75, 1.00);
   StadtumgebungBereich : constant Sf.Graphics.Rect.sfFloatRect := (StadtkarteAnzeigebereich.width, 0.00, 0.25, 0.25);
   
   Forschungserfolgbereich : constant Sf.Graphics.Rect.sfFloatRect := Sprachenbereich;
      
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
                                                                                                         1 => (SeitenleisteGesamtbereich.left, SeitenleisteGesamtbereich.top, SeitenleisteGesamtbereich.width, 0.20),
                                                                                                         2 => (SeitenleisteGesamtbereich.left, 0.20, SeitenleisteGesamtbereich.width, 0.10),
                                                                                                         3 => (SeitenleisteGesamtbereich.left, 0.30, SeitenleisteGesamtbereich.width, 0.35),
                                                                                                         4 => (SeitenleisteGesamtbereich.left, 0.65, SeitenleisteGesamtbereich.width, 0.35)
                                                                                                        );
      
   Forschungsbereich : constant BereicheArray (Views.ForschungsviewAccesse'Range) := (
                                                                                      1 => (0.00, 0.10, 0.50, 0.80),
                                                                                      2 => (0.50, 0.10, 0.50, 0.40),
                                                                                      3 => (0.50, 0.50, 0.50, 0.40),
                                                                                      4 => (0.00, 0.90, 1.00, 0.10)
                                                                                     );
   
   Baumenübereich : constant BereicheArray (Views.BauviewAccesse'Range) := (
                                                                             1 => (0.00, 0.10, 0.50, 0.80),
                                                                             2 => (0.50, 0.10, 0.50, 0.80),
                                                                             3 => (0.50, 0.10, 0.50, 0.80),
                                                                             4 => (0.00, 0.10, 0.50, 0.80),
                                                                             5 => (0.00, 0.90, 1.00, 0.10)
                                                                            );

end GrafikRecordKonstanten;
