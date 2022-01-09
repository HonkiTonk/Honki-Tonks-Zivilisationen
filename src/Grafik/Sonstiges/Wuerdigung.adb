pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_1; use Ada.Characters.Wide_Wide_Latin_1;

with GlobaleTexte;

with Eingabe;
with Anzeige;

package body Wuerdigung is

   procedure Wuerdigung
   is begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Würdigungen,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 1,
                                     LetzteZeileExtern      => 1,
                                     AbstandAnfangExtern    => GlobaleTexte.Leer,
                                     AbstandMitteExtern     => GlobaleTexte.Neue_Zeile,
                                     AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
      
      New_Line;
      Eingabe.WartenEingabe;
      
   end Wuerdigung;

end Wuerdigung;
