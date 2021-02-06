pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with Eingabe, Anzeige, GlobaleVariablen, Steuerung;

package body Optionen is

   procedure Optionen is
   begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
      
      Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                          AktuelleAuswahl    => 0,
                          FrageDatei         => 0,
                          FrageZeile         => 0,
                          TextDatei          => 9,
                          ErsteZeile         => 41,
                          LetzteZeile        => 41);
      Wert := Eingabe.GanzeZahl (Zahlengröße => 3);
      
      case Wert is
         when -1 =>
            null;

         when 1 =>
            Steuerung.SteuerungBelegen;
            
         when others =>
            GlobaleVariablen.RundenBisAutosave := Wert;
      end case;
      
   end Optionen;  

end Optionen;
