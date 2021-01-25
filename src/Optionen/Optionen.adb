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
