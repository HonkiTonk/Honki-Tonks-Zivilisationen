with Ada.Calendar; use Ada.Calendar;

private with GrafikDatentypen;
private with TextnummernKonstanten;

package Grafik is
   pragma Elaborate_Body;

   procedure Grafik;

private

   Startzeit : Time;

   LetzteDarstellung : GrafikDatentypen.AKtuelle_Anzeige_Enum := GrafikDatentypen.Start_Enum;
   AktuelleDarstellung : GrafikDatentypen.AKtuelle_Anzeige_Enum;

   procedure GrafikanpassungenVorFensterleerung;
   procedure Eingaben;

   procedure AnzeigeEingaben
     (EingabeExtern : in GrafikDatentypen.Eingabe_Enum);

   procedure AnzeigeSpielmeldungen
     (AktuelleDarstellungExtern : in GrafikDatentypen.AKtuelle_Anzeige_Enum;
      LetzteDarstellungExtern : in GrafikDatentypen.AKtuelle_Anzeige_Enum;
      SpielmeldungExtern : in TextnummernKonstanten.Spielmeldungen);



   function AnzeigeAuswahl
     return Boolean;

end Grafik;
