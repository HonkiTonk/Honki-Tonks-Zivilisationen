pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Rect;

with ViewsSFML;

package GrafikKonstanten is

   -- Da das ja Records sind, müsste das eher nach GrafikRecordKonstanten. äöü
   Sprachenbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 1.00, 1.00);
   
   KarteAnzeigebereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 0.80, 1.00);
   SeitenleisteAnzeigebereich : constant Sf.Graphics.Rect.sfFloatRect := (0.80, 0.00, 0.20, 1.00);
   
   Überschriftbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, 0.00, 1.00, 0.10);
   Versionsbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.35, 0.95, 0.30, 0.05);
   Menübereich : constant Sf.Graphics.Rect.sfFloatRect := (0.00, Überschriftbereich.height, 1.00, 1.00 - Überschriftbereich.height);
   
   Fragenbereich : constant Sf.Graphics.Rect.sfFloatRect := (0.25, 0.45, 0.50, 0.05);
   Eingabebereich : constant Sf.Graphics.Rect.sfFloatRect := (Fragenbereich.left, Fragenbereich.top + Fragenbereich.height, Fragenbereich.width, Fragenbereich.height);
   JaNeinBereich : constant Sf.Graphics.Rect.sfFloatRect := (Fragenbereich.left, Fragenbereich.top + Fragenbereich.height, Fragenbereich.width, 2.00 * Fragenbereich.height);
   
   type SeitenleisteWeltkartenbereicheArray is array (ViewsSFML.SeitenleisteWeltkarteAccesse'Range) of Sf.Graphics.Rect.sfFloatRect;
   SeitenleisteWeltkartenbereich : SeitenleisteWeltkartenbereicheArray := (
                                                                           1 => (KarteAnzeigebereich.width, 0.00, 1.00 - KarteAnzeigebereich.width, 0.20),
                                                                           2 => (KarteAnzeigebereich.width, 0.20, 1.00 - KarteAnzeigebereich.width, 0.10),
                                                                           3 => (KarteAnzeigebereich.width, 0.30, 1.00 - KarteAnzeigebereich.width, 0.35),
                                                                           4 => (KarteAnzeigebereich.width, 0.65, 1.00 - KarteAnzeigebereich.width, 0.35)
                                                                          );

end GrafikKonstanten;
