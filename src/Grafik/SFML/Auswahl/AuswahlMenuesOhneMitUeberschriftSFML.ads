pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;

with SystemDatentypen;
with InteraktionAuswahl;

package AuswahlMenuesOhneMitUeberschriftSFML is

   procedure AuswahlMenüsMitOhneÜberschrift
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Mit_Überschrift);

private

   Überschrift : constant Positive := 1;
   Versionsnummer : constant Positive := 1;

   TextBereich : Positive;
   AktuelleAuswahl : Positive;

   ÜberschriftAufschlag : Natural;

   ZeilenAbstand : Float;

   AbstandAnfang : Sf.sfUint32;
   AbstandÜberschrift : Sf.sfUint32;
   AbstandTexte : Sf.System.Vector2.sfVector2u;
   AbstandEnde : Sf.sfUint32;

   AktuelleAuflösung : Sf.System.Vector2.sfVector2u;

   Rechenwert : Sf.System.Vector2.sfVector2f;
   AktuelleAuflösungFloat : Sf.System.Vector2.sfVector2f;
   AktuelleTextposition : Sf.System.Vector2.sfVector2f;

   type AuflösungBerechnetArray is array (SystemDatentypen.Menü_Ohne_Mit_Überschrift'Range) of Sf.System.Vector2.sfVector2u;
   AuflösungBerechnet : AuflösungBerechnetArray := (
                                                      others => (0, 0)
                                                     );

   type TextAccessArray is array (SystemDatentypen.Menü_Ohne_Mit_Überschrift'Range, Überschrift .. Überschrift + InteraktionAuswahl.PositionenArray'Last (2) + Versionsnummer) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (others => (others => Sf.Graphics.Text.create));

   procedure Positionsberechnung
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Mit_Überschrift);

   procedure Titel
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Mit_Überschrift);

   procedure Auswahlmöglichkeiten
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Mit_Überschrift);

   procedure VersionsnummerText
     (WelchesMenüExtern : in SystemDatentypen.Menü_Ohne_Mit_Überschrift);

end AuswahlMenuesOhneMitUeberschriftSFML;
