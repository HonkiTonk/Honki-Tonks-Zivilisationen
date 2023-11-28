with Sf.Graphics.Rect;
with Sf.System.Vector2;

with MenueDatentypen;
with MenueKonstanten;
with EinheitenDatentypen;
with StadtDatentypen;
with ForschungenDatentypen;
with TastenbelegungDatentypen;
with SpeziesDatentypen;
with BefehleDatentypen;
with GrafikRecordKonstanten;
with KartengrundDatentypen;

-- Das hier später auch mal thematisch aufteilen? äöü
-- Auch mal besser benennen? äöü
-- Auch Lese/Schreibedateien dafür anlegen? äöü
package InteraktionAuswahl is
   pragma Elaborate_Body;

   type PositionenMenüeinträgeArray is array (MenueDatentypen.Welches_Menü_Vorhanden_Enum'Range, 1 .. MenueKonstanten.ZweitlängstesMenü) of Sf.Graphics.Rect.sfFloatRect;
   PositionenMenüeinträge : PositionenMenüeinträgeArray := (others => (others => GrafikRecordKonstanten.Leerbereich));



   type PositionenArray is array (Positive range <>) of Sf.Graphics.Rect.sfFloatRect;

   PositionenSteuerungsaufteilung : PositionenArray (1 .. 3) := (others => GrafikRecordKonstanten.Leerbereich);
   PositionenSteuerung : PositionenArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Steuerung_Menü_Enum)) := (others => GrafikRecordKonstanten.Leerbereich);

   PositionenSpielstand : PositionenArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Spielstand_Menü_Enum)) := (others => GrafikRecordKonstanten.Leerbereich);



   PositionenSprachauswahl : PositionenArray (1 .. 11) := (others => GrafikRecordKonstanten.Leerbereich);

   PositionenJaNein : PositionenArray (1 .. 2) := (others => GrafikRecordKonstanten.Leerbereich);



   type PositionenForschungArray is array (ForschungenDatentypen.ForschungID'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenForschung : PositionenForschungArray := (others => GrafikRecordKonstanten.Leerbereich);

   -- Das sind keine Positionen, sondern nur die vorhandenen Möglichkeiten!
   type MöglicheForschungenArray is array (PositionenForschungArray'Range) of Boolean;
   MöglicheForschungen : MöglicheForschungenArray := (others => False);



   PositionenBauaufteilung : PositionenArray (1 .. 2) := (others => GrafikRecordKonstanten.Leerbereich);

   type PositionenGebäudeBauenArray is array (StadtDatentypen.GebäudeID'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenGebäudeBauen : PositionenGebäudeBauenArray := (others => GrafikRecordKonstanten.Leerbereich);

   -- Das sind keine Positionen, sondern nur die vorhandenen Möglichkeiten!
   type MöglicheGebäudeArray is array (PositionenGebäudeBauenArray'Range) of Boolean;
   MöglicheGebäude : MöglicheGebäudeArray := (others => False);

   type PositionenEinheitenBauenArray is array (EinheitenDatentypen.EinheitenIDVorhanden'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenEinheitenBauen : PositionenEinheitenBauenArray := (others => GrafikRecordKonstanten.Leerbereich);

   -- Das sind keine Positionen, sondern nur die vorhandenen Möglichkeiten!
   type MöglicheEinheitenArray is array (PositionenEinheitenBauenArray'Range) of Boolean;
   MöglicheEinheiten : MöglicheEinheitenArray := (others => False);

   type PositionenEinheitStadtArray is array (EinheitenDatentypen.Transportplätze'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenEinheitStadt : PositionenEinheitStadtArray := (others => GrafikRecordKonstanten.Leerbereich);



   type PositionenDiplomatieSpeziesArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenDiplomatieSpezies : PositionenDiplomatieSpeziesArray := (others => GrafikRecordKonstanten.Leerbereich);

   -- Das sind keine Positionen, sondern nur die vorhandenen Möglichkeiten!
   type SpeziesMöglicheArray is array (PositionenDiplomatieSpeziesArray'Range) of Boolean;
   SpeziesMöglich : SpeziesMöglicheArray := (others => False);



   type PositionenStadtbefehleArray is array (BefehleDatentypen.Stadtbefehle_Auswählen_Enum'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenStadtbefehle : PositionenStadtbefehleArray := (others => GrafikRecordKonstanten.Leerbereich);



   type PositionenEinheitenbefehleArray is array (BefehleDatentypen.Einheiten_Aufgaben_Enum'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenEinheitenbefehle : PositionenEinheitenbefehleArray := (others => GrafikRecordKonstanten.Leerbereich);

   type PositionenKartenbefehleArray is array (TastenbelegungDatentypen.Kartenbefehle_Enum'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenKartenbefehle : PositionenKartenbefehleArray := (others => GrafikRecordKonstanten.Leerbereich);



   type PositionenBasisgrundeditorArray is array (KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenBasisgrundeditor : PositionenBasisgrundeditorArray := (others => GrafikRecordKonstanten.Leerbereich);

   type PositionenZusatzgrundeditorArray is array (KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range) of Sf.Graphics.Rect.sfFloatRect;
   PositionenZusatzgrundeditor : PositionenZusatzgrundeditorArray := (others => GrafikRecordKonstanten.Leerbereich);

   procedure SchreibeGesamteMausposition
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f);



   function LeseGesamteMausposition
     return Sf.System.Vector2.sfVector2f;

   function LeseGesamteMauspositionInteger
     return Sf.System.Vector2.sfVector2i;

   function LeseXMausachse
     return Float;

   function LeseYMausachse
     return Float;

private

   -- Mausposition wird immer vom Grafiktask geschrieben und aktuell vom Logik- und Grafiktask gelesen, sollte auch so bleiben.
   Mausposition : Sf.System.Vector2.sfVector2f;

end InteraktionAuswahl;
