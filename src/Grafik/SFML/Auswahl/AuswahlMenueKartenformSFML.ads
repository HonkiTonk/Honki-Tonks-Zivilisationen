pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

private with SystemKonstanten;
private with KartenDatentypen;
private with TextaccessVariablen;

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

   Rechenwert : Sf.System.Vector2.sfVector2f;

   type SchleifenanpassungArray is array (2 .. 7) of Positive;
   Schleifenanpassung : constant SchleifenanpassungArray := (
                                                             2 => 10,
                                                             3 => 12,
                                                             4 => 14,
                                                             5 => 18,
                                                             6 => 22,
                                                             7 => 26
                                                            );

   type WelcheFormArray is array (KartenDatentypen.Kartenform_Enum'Range) of Positive;
   WelcheFormEins : constant WelcheFormArray := (
                                                 KartenDatentypen.Karte_E_Kein_Übergang_Enum                   => 10,
                                                 KartenDatentypen.Karte_E_Übergang_Enum                        => 11,
                                                 KartenDatentypen.Karte_Y_Kein_Übergang_Enum                   => 14,
                                                 KartenDatentypen.Karte_Y_Übergang_Enum                        => 15,
                                                 KartenDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum => 16,
                                                 KartenDatentypen.Karte_Y_Verschobener_Übergang_Enum           => 17,
                                                 KartenDatentypen.Karte_X_Kein_Übergang_Enum                   => 22,
                                                 KartenDatentypen.Karte_X_Übergang_Enum                        => 23,
                                                 KartenDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum => 24,
                                                 KartenDatentypen.Karte_X_Verschobener_Übergang_Enum           => 25
                                                );

   WelcheFormZwei : constant WelcheFormArray := (
                                                 KartenDatentypen.Karte_E_Kein_Übergang_Enum                   => 12,
                                                 KartenDatentypen.Karte_E_Übergang_Enum                        => 13,
                                                 KartenDatentypen.Karte_Y_Kein_Übergang_Enum                   => 18,
                                                 KartenDatentypen.Karte_Y_Übergang_Enum                        => 19,
                                                 KartenDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum => 20,
                                                 KartenDatentypen.Karte_Y_Verschobener_Übergang_Enum           => 21,
                                                 KartenDatentypen.Karte_X_Kein_Übergang_Enum                   => 26,
                                                 KartenDatentypen.Karte_X_Übergang_Enum                        => 27,
                                                 KartenDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum => 28,
                                                 KartenDatentypen.Karte_X_Verschobener_Übergang_Enum           => 29
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
