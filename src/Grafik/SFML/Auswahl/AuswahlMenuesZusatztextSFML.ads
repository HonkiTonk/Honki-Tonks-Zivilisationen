pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;
-- with Sf.Graphics.Color;
with Sf.System.Vector2;
with Sf.Graphics.Text;

with SystemDatentypen;
with SystemKonstanten;

package AuswahlMenuesZusatztextSFML is

   procedure AuswahlMenüsZusatztext
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Positive);

   procedure SchriftartZurücksetzen;
   procedure TextZurücksetzen;
   procedure SchriftgrößeZurücksetzen;

private

   LeerSchriftartFestgelegt : constant Boolean := False;
   LeerTextFestgelegt : constant Boolean := False;

   LeerSchriftgrößeFestgelegt : constant Sf.sfUint32 := 0;
   AktuelleSchriftgröße : Sf.sfUint32;


   LeerAuflösungBerechnet : constant Sf.System.Vector2.sfVector2u := (0, 0);
   AktuelleAuflösung : Sf.System.Vector2.sfVector2u;

   type SchriftartFestgelegtArray is array (SystemDatentypen.Menü_Zusatztext_Enum'Range) of Boolean;
   SchriftartFestgelegt : SchriftartFestgelegtArray := (
                                                        others => LeerSchriftartFestgelegt
                                                       );

   type TextFestgelegtArray is array (SystemDatentypen.Menü_Zusatztext_Enum'Range) of Boolean;
   TextFestgelegt : TextFestgelegtArray := (
                                            others => LeerTextFestgelegt
                                           );

   type SchriftgrößeFestgelegtArray is array (SystemDatentypen.Menü_Zusatztext_Enum'Range) of Sf.sfUint32;
   SchriftgrößeFestgelegt : SchriftgrößeFestgelegtArray := (
                                                                others => LeerSchriftgrößeFestgelegt
                                                               );

   -------------------------- Mal anders benennen.
   type AuflösungBerechnetArray is array (SystemDatentypen.Menü_Zusatztext_Enum'Range) of Sf.System.Vector2.sfVector2u;
   AuflösungBerechnet : AuflösungBerechnetArray := (
                                                      others => LeerAuflösungBerechnet
                                                     );

   --------------------------- Wird hier so nicht benötigt.
   -- type SchriftfarbenFestgelegtArray is array (SystemDatentypen.Menü_Einfach_Enum'Range) of SystemRecords.SchriftfarbenRecord;
   -- SchriftfarbenFestgelegt : SchriftfarbenFestgelegtArray := (
   --                                                           others =>
   --                                                             (
   --                                                              FarbeÜberschrift    => Sf.Graphics.Color.sfTransparent,
   --                                                              FarbeStandardText   => Sf.Graphics.Color.sfTransparent,
   --                                                              FarbeAusgewähltText => Sf.Graphics.Color.sfTransparent,
   --                                                              FarbeMenschText     => Sf.Graphics.Color.sfTransparent,
   --                                                              FarbeKIText         => Sf.Graphics.Color.sfTransparent,
   --                                                              FarbeSonstigerText  => Sf.Graphics.Color.sfTransparent
   --                                                             )
   --                                                          );

   type TextAccessArray is array (SystemDatentypen.Menü_Zusatztext_Enum'Range, 1 .. SystemKonstanten.HalbesLängstesMenü) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (
                                             others =>
                                               (
                                                others => Sf.Graphics.Text.create
                                               )
                                            );

   procedure TextHintergrund
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Positive);

   procedure Textbearbeitung
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum);

end AuswahlMenuesZusatztextSFML;
