pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.Sprite;
with Sf.Graphics.Text;
with Sf.System.Vector2;

with MenueDatentypen;
with SystemKonstanten;
with KartenDatentypen;

package AuswahlMenueKartenformSFML is

   procedure AuswahlMenüKartenform;

private

   SchriftartFestgelegt : Boolean := False;
   SchriftfarbeFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;
   SchriftpositionFestgelegt : Boolean := False;
   TextEingelesen : Boolean := False;

   LetzteAuswahl : Natural := SystemKonstanten.LeerAuswahl;
   AktuelleAuswahl : Natural;
   AktuelleAuswahlRückgabewert : Natural;

   Überschrift : constant Positive := 1;
   Versionsnummer : constant Positive := 1;
   Zusatzplatz : constant Positive := 16;
   Ende : Positive;

   ZeilenAbstand : Float;

   Rechenwert : Sf.System.Vector2.sfVector2f;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   type TextAccessArray is array (Überschrift .. SystemKonstanten.EndeMenü (MenueDatentypen.Kartenform_Menü_Enum) + Zusatzplatz + Versionsnummer) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (
                                             others => Sf.Graphics.Text.create
                                            );

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
                                                 KartenDatentypen.Karte_E_Achse_Kein_Übergang_Enum                   => 11,
                                                 KartenDatentypen.Karte_E_Achse_Übergang_Enum                        => 12,
                                                 KartenDatentypen.Karte_Y_Achse_Kein_Übergang_Enum                   => 15,
                                                 KartenDatentypen.Karte_Y_Achse_Übergang_Enum                        => 16,
                                                 KartenDatentypen.Karte_Y_Achse_Rückwärts_Verschobener_Übergang_Enum => 17,
                                                 KartenDatentypen.Karte_Y_Achse_Verschobener_Übergang_Enum           => 18,
                                                 KartenDatentypen.Karte_X_Achse_Kein_Übergang_Enum                   => 23,
                                                 KartenDatentypen.Karte_X_Achse_Übergang_Enum                        => 24,
                                                 KartenDatentypen.Karte_X_Achse_Rückwärts_Verschobener_Übergang_Enum => 25,
                                                 KartenDatentypen.Karte_X_Achse_Verschobener_Übergang_Enum           => 26
                                                );

   WelcheFormZwei : constant WelcheFormArray := (
                                                 KartenDatentypen.Karte_E_Achse_Kein_Übergang_Enum                   => 13,
                                                 KartenDatentypen.Karte_E_Achse_Übergang_Enum                        => 14,
                                                 KartenDatentypen.Karte_Y_Achse_Kein_Übergang_Enum                   => 19,
                                                 KartenDatentypen.Karte_Y_Achse_Übergang_Enum                        => 20,
                                                 KartenDatentypen.Karte_Y_Achse_Rückwärts_Verschobener_Übergang_Enum => 21,
                                                 KartenDatentypen.Karte_Y_Achse_Verschobener_Übergang_Enum           => 22,
                                                 KartenDatentypen.Karte_X_Achse_Kein_Übergang_Enum                   => 27,
                                                 KartenDatentypen.Karte_X_Achse_Übergang_Enum                        => 28,
                                                 KartenDatentypen.Karte_X_Achse_Rückwärts_Verschobener_Übergang_Enum => 29,
                                                 KartenDatentypen.Karte_X_Achse_Verschobener_Übergang_Enum           => 30
                                                );

   procedure FarbeAktuelleAuswahlFestlegen
     (AktuelleAuswahlExtern : in Natural;
      LetzteAuswahlExtern : in Natural);



   function Textbearbeitung
     return Natural;

   function SchriftartFestlegen
     return Boolean;

   function SchriftfarbenFestlegen
     return Boolean;

   function SchriftgrößeFestlegen
     return Boolean;

   function TextEinlesen
     return Boolean;

   function SchriftpositionFestlegen
     return Boolean;

end AuswahlMenueKartenformSFML;
