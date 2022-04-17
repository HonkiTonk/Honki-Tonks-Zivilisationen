pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.Color;
with Sf.Graphics.Sprite;

with SystemDatentypen;
with SystemRecords;
with SystemKonstanten;

with InteraktionAuswahl;

package AuswahlMenuesEinfachSFML is

   procedure AuswahlMenüsEinfach
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum);

   procedure SchriftartZurücksetzen;
   procedure TextZurücksetzen;
   procedure SchriftgrößeZurücksetzen;

private

   LeerSchriftartFestgelegt : constant Boolean := False;
   LeerTextFestgelegt : constant Boolean := False;

   LetztesMenü : SystemDatentypen.Welches_Menü_Enum := SystemDatentypen.Leer_Menü_Enum;

   LeerSchriftgrößeFestgelegt : constant Sf.sfUint32 := 0;

   LeerAuflösungBerechnet : constant Sf.System.Vector2.sfVector2u := (0, 0);

   Überschrift : constant Positive := 1;
   Versionsnummer : constant Positive := 1;

   Textbereich : Positive;

   HauptmenüAbzug : Natural;
   SchleifenAbzug : Natural;
   AktuelleAuswahl : Natural;
   AktuelleAuswahlRückgabewert : Natural;
   LetzteAuswahl : Natural := SystemKonstanten.LeerAuswahl;
   AktuellAusgewählt : Natural;
   ZuletztAusgewählt : Natural;
   AktuelleEinstellung : Positive;

   ZeilenAbstand : Float;

   AktuelleSchriftgröße : Sf.sfUint32;
   AbstandAnfang : Sf.sfUint32;
   AbstandÜberschrift : Sf.sfUint32;
   AbstandEnde : Sf.sfUint32;

   Farbe : Sf.Graphics.Color.sfColor;

   AbstandTexte : Sf.System.Vector2.sfVector2u;

   AktuelleAuflösung : Sf.System.Vector2.sfVector2u;

   Rechenwert : Sf.System.Vector2.sfVector2f;
   AktuelleAuflösungFloat : Sf.System.Vector2.sfVector2f;
   AktuelleTextposition : Sf.System.Vector2.sfVector2f;

   AktuelleSchriftfarben : SystemRecords.SchriftfarbenRecord;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   type SchriftartFestgelegtArray is array (SystemDatentypen.Menü_Einfach_Enum'Range) of Boolean;
   SchriftartFestgelegt : SchriftartFestgelegtArray := (
                                                        others => LeerSchriftartFestgelegt
                                                       );

   type TextFestgelegtArray is array (SystemDatentypen.Menü_Einfach_Enum'Range) of Boolean;
   TextFestgelegt : TextFestgelegtArray := (
                                            others => LeerTextFestgelegt
                                           );

   type SchriftgrößeFestgelegtArray is array (SystemDatentypen.Menü_Einfach_Enum'Range) of Sf.sfUint32;
   SchriftgrößeFestgelegt : SchriftgrößeFestgelegtArray := (
                                                                others => LeerSchriftgrößeFestgelegt
                                                               );

   -------------------------- Mal anders benennen.
   type AuflösungBerechnetArray is array (SystemDatentypen.Menü_Einfach_Enum'Range) of Sf.System.Vector2.sfVector2u;
   AuflösungBerechnet : AuflösungBerechnetArray := (
                                                      others => LeerAuflösungBerechnet
                                                     );

   type SchriftfarbenFestgelegtArray is array (SystemDatentypen.Menü_Einfach_Enum'Range) of SystemRecords.SchriftfarbenRecord;
   SchriftfarbenFestgelegt : SchriftfarbenFestgelegtArray := (
                                                              others =>
                                                                (
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
                                             others =>
                                               (
                                                others => Sf.Graphics.Text.create
                                               )
                                            );

   procedure MenüHintergrund
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum);

   function Textbearbeitung
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
      return Natural;

   procedure SchriftgrößenFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

   procedure SchriftfarbenFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

   procedure FarbeAktuelleEinstellungenFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einstellung_Anzeigen_Enum);

   procedure FarbeAusgewählteRassenFestlegen;

   procedure FarbeAktuelleAuswahlFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Natural;
      LetzteAuswahlExtern : in Natural);

   procedure SchriftpositionFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

   procedure TextFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

end AuswahlMenuesEinfachSFML;
