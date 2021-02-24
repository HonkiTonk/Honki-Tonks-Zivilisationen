pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleVariablen, GlobaleDatentypen;

with Eingabe, Anzeige, Steuerung;

package body Optionen is

   procedure Optionen is
   begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDatei => GlobaleDatentypen.Fragen,
                                            TextZeile => 23);
      
      Wert := Eingabe.GanzeZahl (WelcheDatei   => 0,
                                 WelcherText   => 0,
                                 ZahlenMinimum => 0,
                                 ZahlenMaximum => 100);
      
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
