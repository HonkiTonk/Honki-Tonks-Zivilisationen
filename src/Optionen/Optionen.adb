package body Optionen is

   procedure Optionen is
   begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
      
      Anzeige.Zeug (WelchesZeug => 41);
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
