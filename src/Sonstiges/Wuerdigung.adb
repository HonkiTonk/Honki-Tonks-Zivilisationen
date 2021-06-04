pragma SPARK_Mode (On);

with GlobaleDatentypen;

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Eingabe, Anzeige;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

package body Wuerdigung is

   procedure Wuerdigung
   is begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Würdigungen,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 1,
                                     LetzteZeileExtern      => 1,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                     AbstandMitteExtern     => GlobaleDatentypen.Neue_Zeile,
                                     AbstandEndeExtern      => GlobaleDatentypen.Neue_Zeile);
      New_Line;
      Eingabe.WartenEingabe;
      
   end Wuerdigung;

end Wuerdigung;
