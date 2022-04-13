pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.Color;

with SystemDatentypen;
with SystemRecords;

with InteraktionAuswahl;

package AuswahlMenuesEinfachSFML is

   ------------------- Wenn die Schriftart/Sprache geändert wird, dann das hier von außen auf False zurücksetzen.
   type SchriftartFestgelegtArray is array (SystemDatentypen.Menü_Einfach_Enum'Range) of Boolean;
   SchriftartFestgelegt : SchriftartFestgelegtArray := (
                                                        others => False
                                                       );

   type TextFestgelegtArray is array (SystemDatentypen.Menü_Einfach_Enum'Range) of Boolean;
   TextFestgelegt : TextFestgelegtArray := (
                                            others => False
                                           );

   procedure AuswahlMenüsEinfach
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum);

private

   Überschrift : constant Positive := 1;
   Versionsnummer : constant Positive := 1;

   Textbereich : Positive;
   AktuelleAuswahl : Positive;

   HauptmenüAbzug : Natural;
   SchleifenAbzug : Natural;

   ZeilenAbstand : Float;

   AktuelleSchriftgröße : Sf.sfUint32;
   AbstandAnfang : Sf.sfUint32;
   AbstandÜberschrift : Sf.sfUint32;
   AbstandEnde : Sf.sfUint32;

   AbstandTexte : Sf.System.Vector2.sfVector2u;

   AktuelleAuflösung : Sf.System.Vector2.sfVector2u;

   Rechenwert : Sf.System.Vector2.sfVector2f;
   AktuelleAuflösungFloat : Sf.System.Vector2.sfVector2f;
   AktuelleTextposition : Sf.System.Vector2.sfVector2f;

   AktuelleSchriftfarben : SystemRecords.SchriftfarbenRecord;

   type SchriftgrößeFestgelegtArray is array (SystemDatentypen.Menü_Einfach_Enum'Range) of Sf.sfUint32;
   SchriftgrößeFestgelegt : SchriftgrößeFestgelegtArray := (
                                                                others => 0
                                                               );

   type AuflösungBerechnetArray is array (SystemDatentypen.Menü_Einfach_Enum'Range) of Sf.System.Vector2.sfVector2u;
   AuflösungBerechnet : AuflösungBerechnetArray := (
                                                      others => (0, 0)
                                                     );

   type SchriftfarbenFestgelegtArray is array (SystemDatentypen.Menü_Einfach_Enum'Range) of SystemRecords.SchriftfarbenRecord;
   SchriftfarbenFestgelegt : SchriftfarbenFestgelegtArray := (
                                                              others => (
                                                                         FarbeÜberschrift    => Sf.Graphics.Color.sfTransparent,
                                                                         FarbeStandardText   => Sf.Graphics.Color.sfTransparent,
                                                                         FarbeAusgewähltText => Sf.Graphics.Color.sfTransparent,
                                                                         FarbeMenschText     => Sf.Graphics.Color.sfTransparent,
                                                                         FarbeKIText         => Sf.Graphics.Color.sfTransparent,
                                                                         FarbeSonstigerText  => Sf.Graphics.Color.sfTransparent
                                                                        )
                                                             );

   type TextAccessArray is array (SystemDatentypen.Menü_Einfach_Enum'Range, Überschrift .. Überschrift + InteraktionAuswahl.PositionenEinfachArray'Last (2) + Versionsnummer) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (
                                             others => (
                                                        others => Sf.Graphics.Text.create
                                                       )
                                            );

   procedure Textberechnungen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

   procedure SchriftgrößenFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

   procedure SchriftfarbenFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

   procedure SchriftpositionFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

   procedure TextFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

end AuswahlMenuesEinfachSFML;
