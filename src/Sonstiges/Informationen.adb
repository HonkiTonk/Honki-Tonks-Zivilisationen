pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Characters.Wide_Wide_Latin_9; use Ada.Characters.Wide_Wide_Latin_9;

with GlobaleTexte;

with Eingabe;
with Anzeige;

package body Informationen is

   procedure Informationen
   is begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Allgemeine_Informationen,
                                            TextZeileExtern => 1);      
      Put_Line (Item => Versionsnummer);

      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                     TextDateiExtern        => GlobaleTexte.Allgemeine_Informationen,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 2,
                                     LetzteZeileExtern      => 12,
                                     AbstandAnfangExtern    => GlobaleTexte.Neue_Zeile,
                                     AbstandMitteExtern     => GlobaleTexte.Neue_Zeile,
                                     AbstandEndeExtern      => GlobaleTexte.Neue_Zeile);
      Eingabe.WartenEingabe;
      
   end Informationen;

end Informationen;
