package body Optionen is

   procedure Optionen is
   begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
      
      Anzeige.Zeug (WelchesZeug => 41);
      Wert := Eingabe.GanzeZahl;
      
      case Wert is
         when -1 =>
            null;
            
         when others =>
            GlobaleVariablen.RundenBisAutosave := Wert;
      end case;
      
   end Optionen;



   procedure SteuerungBelegen is
   begin
      
      null;
      
   end SteuerungBelegen;

end Optionen;
