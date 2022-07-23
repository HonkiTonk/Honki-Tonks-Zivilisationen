pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Rect;

with MenueDatentypen;
with SystemKonstanten;
with EinheitenDatentypen;
with StadtDatentypen;
with ForschungenDatentypen;

package InteraktionAuswahl is

   LetzteTextpositionKartengröße : Float;

   -- Immer das Längste verwenden.
   -- Wobei ein längeres Array hier auch keine Pobleme machen sollte?
   -- Mit den aktuellen Prüfungen sollte doch sowieso immer nur der korrekte Bereich funktionieren, oder?
   -------------------------- Muss nicht identisch mit dem längsten Menü sein, sondern immer nur der Länge der maximalen Auswahlmöglichkeiten entsprechen.
   -------------------------- Aktuell sollte dass die Rassenauswahl sein. Eventuell mal anpassen oder ein besseres System finden.
   type PositionenMenüeinträgeArray is array (MenueDatentypen.Welches_Menü_Vorhanden_Enum'Range, 1 .. SystemKonstanten.LängstesMenü) of Sf.Graphics.Rect.sfFloatRect;
   PositionenMenüeinträge : PositionenMenüeinträgeArray := (others => (others => (0.00, 0.00, 0.00, 0.00)));



   type PositionenForschungArray is array (ForschungenDatentypen.ForschungID'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenForschung : PositionenForschungArray := (others => (0.00, 0.00, 0.00, 0.00));

   type MöglicheForschungenArray is array (PositionenForschungArray'Range) of Boolean;
   MöglicheForschungen : MöglicheForschungenArray := (others => False);



   type PositionenGebäudeBauenArray is array (StadtDatentypen.GebäudeID'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenGebäudeBauen : PositionenGebäudeBauenArray := (others => (0.00, 0.00, 0.00, 0.00));

   type MöglicheGebäudeArray is array (PositionenGebäudeBauenArray'Range) of Boolean;
   MöglicheGebäude : MöglicheGebäudeArray := (others => False);

   type PositionenEinheitenBauenArray is array (EinheitenDatentypen.EinheitenID'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenEinheitenBauen : PositionenEinheitenBauenArray := (others => (0.00, 0.00, 0.00, 0.00));

   type MöglicheEinheitenArray is array (PositionenEinheitenBauenArray'Range) of Boolean;
   MöglicheEinheiten : MöglicheEinheitenArray := (others => False);



   type PositionenEinheitStadtArray is array (EinheitenDatentypen.Transportplätze'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenEinheitStadt : PositionenEinheitStadtArray := (others => (0.00, 0.00, 0.00, 0.00));

   type PositionenJaNeinArray is array (1 .. 2) of Sf.Graphics.Rect.sfFloatRect;
   PositionenJaNein : PositionenJaNeinArray := (others => (0.00, 0.00, 0.00, 0.00));

end InteraktionAuswahl;
