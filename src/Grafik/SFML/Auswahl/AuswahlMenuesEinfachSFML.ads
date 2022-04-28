pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;
with Sf.Graphics.Color;
with Sf.Graphics.Sprite;

with MenueDatentypen;
with SystemRecords;
with SystemKonstanten;

with InteraktionAuswahl;

package AuswahlMenuesEinfachSFML is

   procedure AuswahlMenüsEinfach
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum);

   procedure SchriftartZurücksetzen;
   procedure TextZurücksetzen;
   procedure SchriftgrößeZurücksetzen;

private

   LeerSchriftartFestgelegt : constant Boolean := False;
   LeerTextFestgelegt : constant Boolean := False;
   SchriftartFestgelegt : Boolean := False;

   LetztesMenü : MenueDatentypen.Welches_Menü_Enum := MenueDatentypen.Leer_Menü_Enum;

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

   LeerSchriftgrößeFestgelegt : constant Sf.sfUint32 := 0;

   AktuelleSchriftgröße : Sf.sfUint32;
   AbstandAnfang : Sf.sfUint32;
   AbstandÜberschrift : Sf.sfUint32;
   AbstandEnde : Sf.sfUint32;

   Farbe : Sf.Graphics.Color.sfColor;

   AktuelleSchriftfarben : SystemRecords.SchriftfarbenRecord;

   LeerAuflösungBerechnet : constant Sf.System.Vector2.sfVector2u := (0, 0);

   AbstandTexte : Sf.System.Vector2.sfVector2u;
   AktuelleAuflösung : Sf.System.Vector2.sfVector2u;

   Rechenwert : Sf.System.Vector2.sfVector2f;
   AktuelleAuflösungFloat : Sf.System.Vector2.sfVector2f;
   AktuelleTextposition : Sf.System.Vector2.sfVector2f;

   ------------------------- Ein SpriteAccess für jedes Menübild?
   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   type TextFestgelegtArray is array (MenueDatentypen.Menü_Einfach_Enum'Range) of Boolean;
   TextFestgelegt : TextFestgelegtArray := (
                                            others => LeerTextFestgelegt
                                           );

   type SchriftgrößeFestgelegtArray is array (MenueDatentypen.Menü_Einfach_Enum'Range) of Sf.sfUint32;
   SchriftgrößeFestgelegt : SchriftgrößeFestgelegtArray := (
                                                                others => LeerSchriftgrößeFestgelegt
                                                               );

   -------------------------- Mal anders benennen.
   type AuflösungBerechnetArray is array (MenueDatentypen.Menü_Einfach_Enum'Range) of Sf.System.Vector2.sfVector2u;
   AuflösungBerechnet : AuflösungBerechnetArray := (
                                                      others => LeerAuflösungBerechnet
                                                     );

   type SchriftfarbenFestgelegtArray is array (MenueDatentypen.Menü_Einfach_Enum'Range) of SystemRecords.SchriftfarbenRecord;
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

   type TextAccessArray is array (InteraktionAuswahl.PositionenMenüeinträgeArray'Range (1),
                                  Überschrift .. Überschrift + InteraktionAuswahl.PositionenMenüeinträgeArray'Last (2) + Versionsnummer) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (
                                             others =>
                                               (
                                                others => Sf.Graphics.Text.create
                                               )
                                            );

   function Textbearbeitung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive)
      return Natural;

   procedure SchriftgrößenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

   procedure SchriftfarbenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

   procedure FarbeAktuelleEinstellungenFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einstellung_Anzeigen_Enum);

   procedure FarbeAusgewählteRassenFestlegen;

   procedure FarbeAktuelleAuswahlFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      AktuelleAuswahlExtern : in Natural;
      LetzteAuswahlExtern : in Natural);

   procedure SchriftpositionFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);

   procedure TextFestlegen
     (WelchesMenüExtern : in MenueDatentypen.Menü_Einfach_Enum;
      TextbereichExtern : in Positive);



   function SchriftartFestlegen
     return Boolean;

end AuswahlMenuesEinfachSFML;