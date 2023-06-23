with Ada.Calendar; use Ada.Calendar;

private with GrafikDatentypen;
private with SystemDatentypen;

package Grafik is
   pragma Elaborate_Body;

   procedure Grafik;

private

   Startzeit : Time;

   LetzteDarstellung : GrafikDatentypen.AKtuelle_Anzeige_Enum := GrafikDatentypen.Start_Enum;
   AktuelleDarstellung : GrafikDatentypen.AKtuelle_Anzeige_Enum;

   procedure AnzeigeEingaben;
   procedure GrafikanpassungenVorFensterleerung;
   procedure Eingaben;
   procedure AnzeigeSpielmeldungen
     (AktuelleDarstellungExtern : in GrafikDatentypen.AKtuelle_Anzeige_Enum;
      LetzteDarstellungExtern : in GrafikDatentypen.AKtuelle_Anzeige_Enum;
      SpielmeldungExtern : in SystemDatentypen.Spielmeldungen);



   function AnzeigeAuswahl
     return Boolean;

end Grafik;
