pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;

with SystemDatentypen;
with GlobaleTexte;

package AuswahlMenuesOhneUeberschriftSFML is

   procedure AuswahlMenüsOhneÜberschrift
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Überschrift_Enum);

private

   Überschrift : constant Positive := 1;
   Versionsnummer : constant Positive := 1;
   TextBereich : Positive;

   AbstandAnfang : Sf.sfUint32;
   AbstandÜberschrift : Sf.sfUint32;
   AbstandTexte : Sf.System.Vector2.sfVector2u;
   AbstandEnde : Sf.sfUint32;

   AktuelleAuflösung : Sf.System.Vector2.sfVector2u;

   Rechenwert : Sf.System.Vector2.sfVector2f;
   AktuelleAuflösungFloat : Sf.System.Vector2.sfVector2f;
   AktuelleTextposition : Sf.System.Vector2.sfVector2f;

   -- Zweite Dimension wird hier nicht benötigt da es hier immer bei eins startet.
   type EndeMenüArray is array (SystemDatentypen.Menü_Ohne_Überschrift_Enum'Range) of Positive;
   EndeMenü : constant EndeMenüArray := (
                                           SystemDatentypen.Haupt_Menü_Enum => GlobaleTexte.Hauptmenü'Last,
                                           SystemDatentypen.Spiel_Menü_Enum => GlobaleTexte.Spielmenü'Last
                                          );

   type AuflösungBerechnetArray is array (SystemDatentypen.Menü_Ohne_Überschrift_Enum'Range) of Sf.System.Vector2.sfVector2u;
   AuflösungBerechnet : AuflösungBerechnetArray := (
                                                      SystemDatentypen.Haupt_Menü_Enum => (0, 0),
                                                      SystemDatentypen.Spiel_Menü_Enum => (0, 0)
                                                     );

   -- Überschrift + Texte + Versionsnummer
   -- Hier darf nicht durch zwei geteilt werden, da ja für jedes Textfeld ein Bereich angelegt werden muss.
   -- 1 = Überschrift und dann muss es bis Überschrift + Text + Versionsnummer gehen.
   -- GlobaleTexte die Textarrays immer einheitliche Gruppenlängen geben, damit sind die Enden immer gleich und die Prüfung auf passende Arraylänge erübrigt sich. Funktioniert so nicht, da dann das Ende nicht bekannt ist.
   -- Stattdessen immer das Längste verwenden.
   -- Wobei ein längeres Array hier auch keine Pobleme machen sollte, wenn ich alles richtig programmiere.
   type PositionenArray is array (SystemDatentypen.Menü_Ohne_Überschrift_Enum'Range,
                                  Überschrift .. Überschrift + GlobaleTexte.Hauptmenü'Last + Versionsnummer, SystemDatentypen.Anfang_Ende_Enum) of Sf.System.Vector2.sfVector2f;
   Positionen : PositionenArray;

   type TextAccessArray is array (SystemDatentypen.Menü_Ohne_Überschrift_Enum'Range, PositionenArray'Range (2)) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (others => (others => Sf.Graphics.Text.create));

   procedure Positionsberechnung
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Überschrift_Enum);

   procedure Spielenamen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Überschrift_Enum);

   procedure Auswahlmöglichkeiten
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Überschrift_Enum);

   procedure VersionsnummerText
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Überschrift_Enum);

end AuswahlMenuesOhneUeberschriftSFML;
