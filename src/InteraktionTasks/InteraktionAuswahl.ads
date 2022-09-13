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
with GrafikRecordKonstanten;

-- Das hier später auch mal theamtisch aufteilen? äöü
-- Auch mal besser benennen? äöü
package InteraktionAuswahl is

   type PositionenMenüeinträgeArray is array (MenueDatentypen.Welches_Menü_Vorhanden_Enum'Range, 1 .. SystemKonstanten.ZweitlängstesMenü) of Sf.Graphics.Rect.sfFloatRect;
   PositionenMenüeinträge : PositionenMenüeinträgeArray := (others => (others => GrafikRecordKonstanten.Leerbereich));

   type PositionenArray is array (Positive range <>) of Sf.Graphics.Rect.sfFloatRect;



   PositionenSteuerung : PositionenArray (SystemKonstanten.EndeAbzugGrafik (MenueDatentypen.Steuerung_Menü_Enum) + 1 .. SystemKonstanten.LängstesMenü) := (others => GrafikRecordKonstanten.Leerbereich);

   type PositionenSteuerungbelegungArray is array (TastenbelegungDatentypen.Tastenbelegung_Auswählbar_Enum'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenSteuerungbelegung : PositionenSteuerungbelegungArray := (others => GrafikRecordKonstanten.Leerbereich);



   PositionenSprachauswahl : PositionenArray (1 .. 11) := (others => GrafikRecordKonstanten.Leerbereich);



   type PositionenForschungArray is array (ForschungenDatentypen.ForschungID'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenForschung : PositionenForschungArray := (others => GrafikRecordKonstanten.Leerbereich);

   type MöglicheForschungenArray is array (PositionenForschungArray'Range) of Boolean;
   MöglicheForschungen : MöglicheForschungenArray := (others => False);



   type PositionenMöglicheGebäudeArray is array (StadtDatentypen.GebäudeID'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenMöglicheGebäude : PositionenMöglicheGebäudeArray := (others => GrafikRecordKonstanten.Leerbereich);

   type MöglicheGebäudeArray is array (PositionenMöglicheGebäudeArray'Range) of Boolean;
   MöglicheGebäude : MöglicheGebäudeArray := (others => False);

   type PositionenEinheitenBauenArray is array (EinheitenDatentypen.EinheitenID'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenEinheitenBauen : PositionenEinheitenBauenArray := (others => GrafikRecordKonstanten.Leerbereich);

   type MöglicheEinheitenArray is array (PositionenEinheitenBauenArray'Range) of Boolean;
   MöglicheEinheiten : MöglicheEinheitenArray := (others => False);



   type PositionenEinheitStadtArray is array (EinheitenDatentypen.Transportplätze'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenEinheitStadt : PositionenEinheitStadtArray := (others => GrafikRecordKonstanten.Leerbereich);

   PositionenJaNein : PositionenArray (1 .. 2) := (others => GrafikRecordKonstanten.Leerbereich);



   type PositionenDiplomatieRasseArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenDiplomatieRasse : PositionenDiplomatieRasseArray := (others => GrafikRecordKonstanten.Leerbereich);

   type RassenMöglicheArray is array (PositionenDiplomatieRasseArray'Range) of Boolean;
   RassenMöglich : RassenMöglicheArray := (others => False);



   type PositionenStadtbefehleArray is array (BefehleDatentypen.Stadtbefehle_Vorhanden_Enum'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenStadtbefehle : PositionenStadtbefehleArray := (others => GrafikRecordKonstanten.Leerbereich);



   type PositionenEinheitenbefehleArray is array (BefehleDatentypen.Einheiten_Aufgaben_Enum'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenEinheitenbefehle : PositionenEinheitenbefehleArray := (others => GrafikRecordKonstanten.Leerbereich);

   type PositionenKartenbefehleArray is array (BefehleDatentypen.Kartenbefehle_Enum'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenKartenbefehle : PositionenKartenbefehleArray := (others => GrafikRecordKonstanten.Leerbereich);

end InteraktionAuswahl;
