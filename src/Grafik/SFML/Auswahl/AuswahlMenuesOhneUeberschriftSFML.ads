pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;

with SystemDatentypen;
with GlobaleTexte;
with InteraktionAuswahl;

package AuswahlMenuesOhneUeberschriftSFML is

   procedure AuswahlMenüsOhneÜberschrift
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Überschrift_Enum);

private

   Überschrift : constant Positive := InteraktionAuswahl.Überschrift;
   Versionsnummer : constant Positive := InteraktionAuswahl.Versionsnummer;

   TextBereich : Positive;

   ZeilenAbstand : Float;

   AbstandAnfang : Sf.sfUint32;
   AbstandÜberschrift : Sf.sfUint32;
   AbstandTexte : Sf.System.Vector2.sfVector2u;
   AbstandEnde : Sf.sfUint32;

   AktuelleAuflösung : Sf.System.Vector2.sfVector2u;

   Rechenwert : Sf.System.Vector2.sfVector2f;
   AktuelleAuflösungFloat : Sf.System.Vector2.sfVector2f;
   AktuelleTextposition : Sf.System.Vector2.sfVector2f;

   Test : Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;

   -- Zweite Dimension wird hier nicht benötigt da es hier immer bei eins startet.
   type EndeMenüArray is array (SystemDatentypen.Menü_Ohne_Überschrift_Enum'Range) of Positive;
   EndeMenü : constant EndeMenüArray := (
                                           -- Minus ein beim hauptmenü, da dort noch auf Wiedersehen eingebaut ist wegen der Konsole.
                                           SystemDatentypen.Haupt_Menü_Enum => GlobaleTexte.Hauptmenü'Last - 1,
                                           SystemDatentypen.Spiel_Menü_Enum => GlobaleTexte.Spielmenü'Last
                                          );

   type AuflösungBerechnetArray is array (SystemDatentypen.Menü_Ohne_Überschrift_Enum'Range) of Sf.System.Vector2.sfVector2u;
   AuflösungBerechnet : AuflösungBerechnetArray := (
                                                      SystemDatentypen.Haupt_Menü_Enum => (0, 0),
                                                      SystemDatentypen.Spiel_Menü_Enum => (0, 0)
                                                     );

   type TextAccessArray is array (SystemDatentypen.Menü_Ohne_Überschrift_Enum'Range, Überschrift .. Überschrift + InteraktionAuswahl.PositionenArray'Last (2) + Versionsnummer) of Sf.Graphics.sfText_Ptr;
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
