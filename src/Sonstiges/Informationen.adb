pragma SPARK_Mode (On);

with GlobaleDatentypen;

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Eingabe, Anzeige;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

package body Informationen is

   procedure Informationen
   is begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Allgemeine_Informationen,
                                            TextZeileExtern => 1);      
      Put_Line (Item => Versionsnummer);

      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Allgemeine_Informationen,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 2,
                                     LetzteZeileExtern      => 12,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Neue_Zeile,
                                     AbstandMitteExtern     => GlobaleDatentypen.Neue_Zeile,
                                     AbstandEndeExtern      => GlobaleDatentypen.Neue_Zeile);
      Eingabe.WartenEingabe;
      
   end Informationen;

end Informationen;
