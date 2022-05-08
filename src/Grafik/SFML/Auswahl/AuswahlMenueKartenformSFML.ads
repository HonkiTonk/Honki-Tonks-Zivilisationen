pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.Sprite;
with Sf.System.Vector2;

with SystemKonstanten;
with KartenDatentypen;
with TextaccessVariablen;

package AuswahlMenueKartenformSFML is

   procedure AuswahlMenüKartenform;

private

   SchriftpositionFestgelegt : Boolean := False;
   TextEingelesen : Boolean := False;

   LetzteAuswahl : Natural := SystemKonstanten.LeerAuswahl;
   AktuelleAuswahl : Natural;
   AktuelleAuswahlRückgabewert : Natural;

   Überschrift : constant Positive := TextaccessVariablen.Überschrift;
   Versionsnummer : constant Positive := TextaccessVariablen.Versionsnummer;
   Ende : Positive;

   ZeilenAbstand : Float;

   Rechenwert : Sf.System.Vector2.sfVector2f;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   type SchleifenanpassungArray is array (2 .. 8) of Positive;
   Schleifenanpassung : constant SchleifenanpassungArray := (
                                                             2 => 11,
                                                             3 => 13,
                                                             4 => 15,
                                                             5 => 19,
                                                             6 => 23,
                                                             7 => 27,
                                                             8 => 31
                                                            );

   type WelcheFormArray is array (KartenDatentypen.Kartenform_Enum'Range) of Positive;
   WelcheFormEins : constant WelcheFormArray := (
                                                 KartenDatentypen.Karte_E_Kein_Übergang_Enum                   => 11,
                                                 KartenDatentypen.Karte_E_Übergang_Enum                        => 12,
                                                 KartenDatentypen.Karte_Y_Kein_Übergang_Enum                   => 15,
                                                 KartenDatentypen.Karte_Y_Übergang_Enum                        => 16,
                                                 KartenDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum => 17,
                                                 KartenDatentypen.Karte_Y_Verschobener_Übergang_Enum           => 18,
                                                 KartenDatentypen.Karte_X_Kein_Übergang_Enum                   => 23,
                                                 KartenDatentypen.Karte_X_Übergang_Enum                        => 24,
                                                 KartenDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum => 25,
                                                 KartenDatentypen.Karte_X_Verschobener_Übergang_Enum           => 26
                                                );

   WelcheFormZwei : constant WelcheFormArray := (
                                                 KartenDatentypen.Karte_E_Kein_Übergang_Enum                   => 13,
                                                 KartenDatentypen.Karte_E_Übergang_Enum                        => 14,
                                                 KartenDatentypen.Karte_Y_Kein_Übergang_Enum                   => 19,
                                                 KartenDatentypen.Karte_Y_Übergang_Enum                        => 20,
                                                 KartenDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum => 21,
                                                 KartenDatentypen.Karte_Y_Verschobener_Übergang_Enum           => 22,
                                                 KartenDatentypen.Karte_X_Kein_Übergang_Enum                   => 27,
                                                 KartenDatentypen.Karte_X_Übergang_Enum                        => 28,
                                                 KartenDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum => 29,
                                                 KartenDatentypen.Karte_X_Verschobener_Übergang_Enum           => 30
                                                );

   procedure FarbeAktuelleAuswahlFestlegen
     (AktuelleAuswahlExtern : in Natural;
      LetzteAuswahlExtern : in Natural);



   function Textbearbeitung
     return Natural;

   function TextEinlesen
     return Boolean;

   function SchriftpositionFestlegen
     return Boolean;

end AuswahlMenueKartenformSFML;
