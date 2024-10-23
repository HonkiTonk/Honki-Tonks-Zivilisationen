private with Ada.Calendar;

private with GrafikDatentypen;
private with TextnummernKonstanten;
private with ZahlenDatentypen;

package Grafik is
   pragma Elaborate_Body;

   procedure Grafik;

private
   use Ada.Calendar;

   Startzeit : Time;

   LetzteDarstellung : GrafikDatentypen.Aktuelle_Anzeige_Enum := GrafikDatentypen.Start_Enum;
   AktuelleDarstellung : GrafikDatentypen.Aktuelle_Anzeige_Enum;

   procedure GrafikanpassungenVorFensterleerung;
   procedure Eingaben;

   procedure AnzeigeEingaben
     (EingabeExtern : in GrafikDatentypen.Eingabe_Enum;
      FrageExtern : in ZahlenDatentypen.EigenesNatural);

   procedure AnzeigeSpielmeldungen
     (AktuelleDarstellungExtern : in GrafikDatentypen.Aktuelle_Anzeige_Enum;
      LetzteDarstellungExtern : in GrafikDatentypen.Aktuelle_Anzeige_Enum;
      SpielmeldungExtern : in TextnummernKonstanten.Spielmeldungen);



   function AnzeigeAuswahl
     return Boolean;

end Grafik;
