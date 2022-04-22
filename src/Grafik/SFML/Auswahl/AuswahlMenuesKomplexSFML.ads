pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.Sprite;
with Sf.Graphics.Text;
with Sf.System.Vector2;

with MenueDatentypen;
with SystemKonstanten;
with KartenDatentypen;

package AuswahlMenuesKomplexSFML is

   procedure AuswahlMenüsKomplex
     (WelchesMenüExtern : in MenueDatentypen.Menü_Komplex_Enum);

private

   SchriftartFestgelegt : Boolean := False;
   SchriftfarbeFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;
   SchriftpositionFestgelegt : Boolean := False;
   TextEingelesen : Boolean := False;

   AktuelleAuswahlRückgabewert : Natural;

   Überschrift : constant Positive := 1;
   Versionsnummer : constant Positive := 1;

   ZeilenAbstand : Float;

   Rechenwert : Sf.System.Vector2.sfVector2f;

   SpriteAccess : constant Sf.Graphics.sfSprite_Ptr := Sf.Graphics.Sprite.create;

   type TextAccessArray is array (Überschrift .. SystemKonstanten.EndeMenü (MenueDatentypen.Kartenform_Menü_Enum) + Versionsnummer) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (
                                             others => Sf.Graphics.Text.create
                                            );

   type WelcheFormArray is array (KartenDatentypen.Kartenform_Enum'Range) of Positive;
   WelcheForm : constant WelcheFormArray := (
                                             KartenDatentypen.Karte_E_Achse_Kein_Übergang_Enum                   => 5,
                                             KartenDatentypen.Karte_E_Achse_Übergang_Enum                        => 6,
                                             KartenDatentypen.Karte_Y_Achse_Kein_Übergang_Enum                   => 6,
                                             KartenDatentypen.Karte_Y_Achse_Übergang_Enum                        => 7,
                                             KartenDatentypen.Karte_Y_Achse_Rückwärts_Verschobener_Übergang_Enum => 8,
                                             KartenDatentypen.Karte_Y_Achse_Verschobener_Übergang_Enum           => 9,
                                             KartenDatentypen.Karte_X_Achse_Kein_Übergang_Enum                   => 9,
                                             KartenDatentypen.Karte_X_Achse_Übergang_Enum                        => 10,
                                             KartenDatentypen.Karte_X_Achse_Rückwärts_Verschobener_Übergang_Enum => 11,
                                             KartenDatentypen.Karte_X_Achse_Verschobener_Übergang_Enum           => 12
                                            );

   procedure MenüHintergrund
     (WelchesMenüExtern : in MenueDatentypen.Menü_Komplex_Enum);



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

end AuswahlMenuesKomplexSFML;
