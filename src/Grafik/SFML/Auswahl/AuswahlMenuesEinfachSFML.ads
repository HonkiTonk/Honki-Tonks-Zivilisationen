pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;

with SystemDatentypen;
with InteraktionAuswahl;

package AuswahlMenuesEinfachSFML is

   procedure AuswahlMenüsEinfach
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum);

private

   Überschrift : constant Positive := 1;
   Versionsnummer : constant Positive := 1;

   TextBereich : Positive;
   AktuelleAuswahl : Positive;

   HauptmenüAbzug : Natural;

   ZeilenAbstand : Float;

   AbstandAnfang : Sf.sfUint32;
   AbstandÜberschrift : Sf.sfUint32;
   AbstandTexte : Sf.System.Vector2.sfVector2u;
   AbstandEnde : Sf.sfUint32;

   AktuelleAuflösung : Sf.System.Vector2.sfVector2u;

   Rechenwert : Sf.System.Vector2.sfVector2f;
   AktuelleAuflösungFloat : Sf.System.Vector2.sfVector2f;
   AktuelleTextposition : Sf.System.Vector2.sfVector2f;

   type AuflösungBerechnetArray is array (SystemDatentypen.Menü_Einfach_Enum'Range) of Sf.System.Vector2.sfVector2u;
   AuflösungBerechnet : AuflösungBerechnetArray := (
                                                      others => (0, 0)
                                                     );

   type TextAccessArray is array (SystemDatentypen.Menü_Einfach_Enum'Range, Überschrift .. Überschrift + InteraktionAuswahl.PositionenEinfachArray'Last (2) + Versionsnummer) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (others => (others => Sf.Graphics.Text.create));

   procedure Positionsberechnung
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum);

   procedure Titel
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum);

   procedure Auswahlmöglichkeiten
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum);

   procedure VersionsnummerText
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum);

end AuswahlMenuesEinfachSFML;
