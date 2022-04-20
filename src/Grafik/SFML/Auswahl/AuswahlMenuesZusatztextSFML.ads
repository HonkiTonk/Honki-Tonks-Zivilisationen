pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf;
-- with Sf.Graphics.Color;
with Sf.System.Vector2;
with Sf.Graphics.Text;

with RassenDatentypen;
with SystemDatentypen;

package AuswahlMenuesZusatztextSFML is

   procedure AuswahlMenüsZusatztext
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Positive);

   procedure SchriftartZurücksetzen;
   procedure TextZurücksetzen;
   procedure SchriftgrößeZurücksetzen;

private

   LeerTextFestgelegt : constant Boolean := False;
   LinksRechts : Boolean;
   SchriftartFestgelegt : Boolean := False;

   RasseAnzeigen : RassenDatentypen.Rassen_Verwendet_Enum;

   LeerSchriftgrößeFestgelegt : constant Sf.sfUint32 := 0;
   AktuelleSchriftgröße : Sf.sfUint32;


   LeerAuflösungBerechnet : constant Sf.System.Vector2.sfVector2u := (0, 0);
   AktuelleAuflösung : Sf.System.Vector2.sfVector2u;

   type TextFestgelegtArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, 1 .. 2) of Boolean;
   TextFestgelegt : TextFestgelegtArray := (
                                            (others => (others => LeerTextFestgelegt))
                                           );

   type SchriftgrößeFestgelegtArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, 1 .. 2) of Sf.sfUint32;
   SchriftgrößeFestgelegt : SchriftgrößeFestgelegtArray := (
                                                                (others => (others => LeerSchriftgrößeFestgelegt))
                                                               );

   -------------------------- Mal anders benennen.
   type AuflösungBerechnetArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, 1 .. 2) of Sf.System.Vector2.sfVector2u;
   AuflösungBerechnet : AuflösungBerechnetArray := (
                                                      (others => (others => LeerAuflösungBerechnet))
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

   type TextAccessArray is array (SystemDatentypen.Menü_Zusatztext_Enum'Range, 1 .. 2) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (
                                             (others => (others => Sf.Graphics.Text.create))
                                            );

   procedure TextHintergrund
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum);

   procedure Textbearbeitung
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Positive);

   procedure TextFestlegen
     (WelchesMenüExtern : in SystemDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Positive);

end AuswahlMenuesZusatztextSFML;
