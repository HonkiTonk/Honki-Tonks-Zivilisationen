package body Ladezeiten is

   procedure LadezeitenSpielweltErstellen (WelcheZeit : Integer) is
   begin

      Gesamtzeit := 0.00;

      Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (24, WelcheZeit)));
      
      case WelcheZeit is
         when 1 =>
            ZeitAuswahlSchleife:
            for VerschiedeneZeiten in LadezeitenSpielweltErstellenZeit'Range (2) loop
               ZeitUnterschiedSchleife:
               for ZeitAnfangEnde in LadezeitenSpielweltErstellenZeit'Range (1) loop
                  
                  case ZeitAnfangEnde is
                     when 2 =>
                        Gesamtzeit := Gesamtzeit + Float (LadezeitenSpielweltErstellenZeit (ZeitAnfangEnde, VerschiedeneZeiten) - LadezeitenSpielweltErstellenZeit (ZeitAnfangEnde - 1, VerschiedeneZeiten));

                     when 1 =>
                        null;
                  end case;
                  
               end loop ZeitUnterschiedSchleife;
            end loop ZeitAuswahlSchleife;
            Ada.Float_Text_IO.Put (Item => Gesamtzeit,
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            Get_Immediate (Item => Warten);
            
         when others =>
            Ada.Float_Text_IO.Put (Item => Float (LadezeitenSpielweltErstellenZeit (2, WelcheZeit) - LadezeitenSpielweltErstellenZeit (1, WelcheZeit)),
                                   Fore => 1,
                                   Aft  => 6,
                                   Exp  => 0);
            New_Line;
      end case;
                  
   end LadezeitenSpielweltErstellen;




   procedure Speichern (WelcheZeit : Integer) is
   begin
      
      null;
      
   end Speichern;
   
   
   
   procedure Laden (WelcheZeit : Integer) is
   begin
      
      null;
      
   end Laden;
   
   
   
   procedure SpielStart (WelcheZeit : Integer) is
   begin
      
      null;
      
   end SpielStart;

end Ladezeiten;
