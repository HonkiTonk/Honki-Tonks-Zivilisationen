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



   procedure Forschung (Rasse : in Integer) is -- Hier noch mehr Optionen einbauen, z. B. Informationen über bereits erforschte Technologien
   begin
      
      ForschungSchleife:
      loop
         
         WasErforschtWerdenSoll := AuswahlForschung (Rasse => Rasse);

         case WasErforschtWerdenSoll is
            when 0 =>
               return;
               
            when 1 .. 6 =>
               GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsmenge := 0;
               GlobaleVariablen.Wichtiges (Rasse).AktuellesForschungsprojekt := WasErforschtWerdenSoll;
               ForschungZeit (Rasse => Rasse);
               return;
                 
            when others =>
               null;
         end case;
         
      end loop ForschungSchleife;
      
   end Forschung;



   procedure ForschungZeit (Rasse : in Integer) is
   begin
      
      if GlobaleVariablen.Wichtiges (Rasse).AktuellesForschungsprojekt = 0 then
         null;
         
      elsif GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsrate = 0 then
         null;

      else
         GlobaleVariablen.Wichtiges (Rasse).VerbleibendeForschungszeit
           := (ForschungListe (Rasse, GlobaleVariablen.Wichtiges (Rasse).AktuellesForschungsprojekt).PreisForschung - GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsmenge) / GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsrate;
         return;
      end if;      
      
      GlobaleVariablen.Wichtiges (Rasse).VerbleibendeForschungszeit := 10_000;
      
   end ForschungZeit;



   function AuswahlForschung (Rasse : in Integer) return Integer is
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

         elsif GlobaleVariablen.Wichtiges (Rasse).Erforscht (F) /= 0 then
            null;

         else
            AnforderungSchleife:
            for A in AnforderungForschungArray'Range loop
            
               if ForschungListe (Rasse, F).AnforderungForschung (A) = 0 then
                  null;
                  
               elsif GlobaleVariablen.Wichtiges (Rasse).Erforscht (ForschungListe (Rasse, F).AnforderungForschung (A)) /= 0 then                  
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
      for Rasse in GlobaleVariablen.EinheitenGebaut'Range (1) loop
         
         if GlobaleVariablen.Wichtiges (Rasse).AktuellesForschungsprojekt = 0 then
            null;
         
         elsif GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsmenge >= ForschungListe (Rasse, GlobaleVariablen.Wichtiges (Rasse).AktuellesForschungsprojekt).PreisForschung then
            GlobaleVariablen.Wichtiges (Rasse).Erforscht (GlobaleVariablen.Wichtiges (Rasse).AktuellesForschungsprojekt) := 1;
            GlobaleVariablen.Wichtiges (Rasse).AktuellesForschungsprojekt := AuswahlForschung (Rasse => Rasse);
            GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsmenge := 0;
            
         else
            null;
         end if;

         ForschungZeit (Rasse => Rasse);
         
      end loop RasseSchleife;
      
   end ForschungFortschritt;

end ForschungsDatenbank;
