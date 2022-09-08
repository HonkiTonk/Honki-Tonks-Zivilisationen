pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Rect;

with MenueDatentypen;
with SystemKonstanten;
with EinheitenDatentypen;
with StadtDatentypen;
with ForschungenDatentypen;
with TastenbelegungDatentypen;
with RassenDatentypen;
with BefehleDatentypen;

-- Das hier später auch mal theamtisch aufteilen? äöü
package InteraktionAuswahl is

   type PositionenMenüeinträgeArray is array (MenueDatentypen.Welches_Menü_Vorhanden_Enum'Range, 1 .. SystemKonstanten.ZweitlängstesMenü) of Sf.Graphics.Rect.sfFloatRect;
   PositionenMenüeinträge : PositionenMenüeinträgeArray := (others => (others => (0.00, 0.00, 0.00, 0.00)));

   type PositionenArray is array (Positive range <>) of Sf.Graphics.Rect.sfFloatRect;



   PositionenSteuerung : PositionenArray (SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Steuerung_Menü_Enum) + 1 .. SystemKonstanten.LängstesMenü) := (others => (0.00, 0.00, 0.00, 0.00));

   type PositionenSteuerungbelegungArray is array (TastenbelegungDatentypen.Tastenbelegung_Auswählbar_Enum'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenSteuerungbelegung : PositionenSteuerungbelegungArray := (others => (0.00, 0.00, 0.00, 0.00));



   PositionenSprachauswahl : PositionenArray (1 .. 11) := (others => (0.00, 0.00, 0.00, 0.00));



   type PositionenForschungArray is array (ForschungenDatentypen.ForschungID'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenForschung : PositionenForschungArray := (others => (0.00, 0.00, 0.00, 0.00));

   type MöglicheForschungenArray is array (PositionenForschungArray'Range) of Boolean;
   MöglicheForschungen : MöglicheForschungenArray := (others => False);



   type PositionenMöglicheGebäudeArray is array (StadtDatentypen.GebäudeID'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenMöglicheGebäude : PositionenMöglicheGebäudeArray := (others => (0.00, 0.00, 0.00, 0.00));

   type MöglicheGebäudeArray is array (PositionenMöglicheGebäudeArray'Range) of Boolean;
   MöglicheGebäude : MöglicheGebäudeArray := (others => False);

   type PositionenEinheitenBauenArray is array (EinheitenDatentypen.EinheitenID'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenEinheitenBauen : PositionenEinheitenBauenArray := (others => (0.00, 0.00, 0.00, 0.00));

   type MöglicheEinheitenArray is array (PositionenEinheitenBauenArray'Range) of Boolean;
   MöglicheEinheiten : MöglicheEinheitenArray := (others => False);



   type PositionenEinheitStadtArray is array (EinheitenDatentypen.Transportplätze'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenEinheitStadt : PositionenEinheitStadtArray := (others => (0.00, 0.00, 0.00, 0.00));

   PositionenJaNein : PositionenArray (1 .. 2) := (others => (0.00, 0.00, 0.00, 0.00));



   type PositionenDiplomatieRasseArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenDiplomatieRasse : PositionenDiplomatieRasseArray := (others => (0.00, 0.00, 0.00, 0.00));

   type RassenMöglicheArray is array (PositionenDiplomatieRasseArray'Range) of Boolean;
   RassenMöglich : RassenMöglicheArray := (others => False);



   type PositionenStadtbefehleArray is array (BefehleDatentypen.Stadtbefehle_Vorhanden_Enum'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenStadtbefehle : PositionenStadtbefehleArray := (others => (0.00, 0.00, 0.00, 0.00));

end InteraktionAuswahl;
