package body ForschungsDatenbank is

   procedure Beschreibung (ID : in Integer) is
   begin
      
      case ID is
         when 0 =>
            Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 28)));
            
         when others =>
            Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (16, ID)));
      end case;
      
   end Beschreibung;



   procedure Forschung (RasseExtern : in Integer) is -- Hier noch mehr Optionen einbauen, z. B. Informationen über bereits erforschte Technologien
   begin
      
      ForschungSchleife:
      loop
         
         WasErforschtWerdenSoll := AuswahlForschung (RasseExtern => RasseExtern);

         case WasErforschtWerdenSoll is
            when 0 =>
               return;
               
            when 1 .. 6 =>
               GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsmenge := 0;
               GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt := WasErforschtWerdenSoll;
               ForschungZeit (RasseExtern => RasseExtern);
               return;
                 
            when others =>
               null;
         end case;
         
      end loop ForschungSchleife;
      
   end Forschung;



   procedure ForschungZeit (RasseExtern : in Integer) is
   begin
      
      if GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt = 0 then
         null;
         
      elsif GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsrate = 0 then
         null;

      else
         GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit
           := (ForschungListe (RasseExtern, GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt).PreisForschung
               - GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsmenge) / GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsrate;
         return;
      end if;      
      
      GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit := 10_000;
      
   end ForschungZeit;



   function AuswahlForschung (RasseExtern : in Integer) return Integer is
   begin

      Anzeige.TextForschung := (others => (To_Unbounded_Wide_Wide_String (Source => "|"), 0));
      Ende := 1;
      AktuelleAuswahl := 1;
      AnforderungenErfüllt := True;
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      ForschungSchleife:
      for F in GlobaleVariablen.TexteEinlesen'Range (2) loop
         
         if To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (16, F)) = "|" then
            exit ForschungSchleife;

         elsif F > ForschungListe'Last then
            exit ForschungSchleife;

         elsif GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (F) /= 0 then
            null;

         else
            AnforderungSchleife:
            for A in AnforderungForschungArray'Range loop
            
               if ForschungListe (RasseExtern, F).AnforderungForschung (A) = 0 then
                  null;
                  
               elsif GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (ForschungListe (RasseExtern, F).AnforderungForschung (A)) /= 0 then                  
                  null;
                  
               else
                  AnforderungenErfüllt := False;
                  exit AnforderungSchleife;
               end if;
               
            end loop AnforderungSchleife;

            case AnforderungenErfüllt is
               when True =>
                  Anzeige.TextForschung (Ende).Text := GlobaleVariablen.TexteEinlesen (16, F);
                  Anzeige.TextForschung (Ende).Nummer := F;
                  Ende := Ende + 1;
                  
               when False =>
                  null;
            end case;
         end if;
                  
      end loop ForschungSchleife;

      if Anzeige.TextForschung (Ende).Nummer = 0 and Ende > 1 then
         Anzeige.TextForschung (Ende).Text := To_Unbounded_Wide_Wide_String (Source => "Zurück");

      elsif Anzeige.TextForschung (Ende).Nummer = 0 and Ende = 1 then
         return 0;
         
      else
         Ende := Ende + 1;
         Anzeige.TextForschung (Ende).Text := GlobaleVariablen.TexteEinlesen (19, 27);
      end if;

      AuswahlSchleife:
      loop

         Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (21, 16)));  
         Anzeige.AnzeigeForschung (AktuelleAuswahl => AktuelleAuswahl);
         
         if AktuelleAuswahl = Ende then
            null;
                  
         else
            Anzeige.AnzeigeLangerText (WelcherText => 17,
                                       WelcheZeile => Anzeige.TextForschung (AktuelleAuswahl).Nummer);
         end if;
         
         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is               
            when 'w' | '8' => 
               if AktuelleAuswahl = Anzeige.TextForschung'First then
                  AktuelleAuswahl := Ende;
               else
                  AktuelleAuswahl := AktuelleAuswahl - 1;
               end if;

            when 's' | '2' =>
               if AktuelleAuswahl = Ende then
                  AktuelleAuswahl := Anzeige.TextForschung'First;
               else
                  AktuelleAuswahl := AktuelleAuswahl + 1;
               end if;
               
            when 'e' | '5' =>
               Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
               return Anzeige.TextForschung (AktuelleAuswahl).Nummer;

            when 'q' =>
               return 0;
                     
            when others =>
               null;                    
         end case;

         Put (Item => CSI & "2J" & CSI & "3J"  & CSI & "H");
         
      end loop AuswahlSchleife;
      
   end AuswahlForschung;



   procedure ForschungFortschritt is
   begin
      
      RasseSchleife:
      for RasseIntern in GlobaleVariablen.EinheitenGebaut'Range (1) loop
         
         if GlobaleVariablen.Wichtiges (RasseIntern).AktuellesForschungsprojekt = 0 then
            null;
         
         elsif GlobaleVariablen.Wichtiges (RasseIntern).AktuelleForschungsmenge >= ForschungListe (RasseIntern, GlobaleVariablen.Wichtiges (RasseIntern).AktuellesForschungsprojekt).PreisForschung then
            GlobaleVariablen.Wichtiges (RasseIntern).Erforscht (GlobaleVariablen.Wichtiges (RasseIntern).AktuellesForschungsprojekt) := 1;
            GlobaleVariablen.Wichtiges (RasseIntern).AktuellesForschungsprojekt := AuswahlForschung (RasseExtern => RasseIntern);
            GlobaleVariablen.Wichtiges (RasseIntern).AktuelleForschungsmenge := 0;
            
         else
            null;
         end if;

         ForschungZeit (RasseExtern => RasseIntern);
         
      end loop RasseSchleife;
      
   end ForschungFortschritt;

end ForschungsDatenbank;
