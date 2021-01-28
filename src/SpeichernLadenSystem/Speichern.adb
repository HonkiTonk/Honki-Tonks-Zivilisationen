package body Speichern is

   procedure SpeichernNeu (Autospeichern : Boolean) is
   begin
      
      Ladezeiten.Speicherzeiten (1, 1) := Clock;
      Ladezeiten.Speicherzeiten (2, 1) := Clock;
      Ladezeiten.Speichern (WelcheZeit => 1);
      
   end SpeichernNeu;
   
   

   procedure Speichern (AutoSpeichern : Boolean) is
   begin

      Ladezeiten.Speicherzeiten (1, 1) := Clock;
      Zeilenanzahl := 1;
      case Autospeichern is
         when False =>
            SpielstandName := Eingabe.SpielstandName;

            case Exists (Name => "Dateien/Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName))) is -- Sicherheitsabfrage und Anzeige der vorhandenen Spielstände mit einbauen?
               when True =>
                  Wahl := Auswahl.AuswahlNeu (AuswahlOderAnzeige => True,
                                              FrageDatei         => 10,
                                              FrageZeile         => 18,
                                              TextDatei          => 5,
                                              ErsteZeile         => 10,
                                              LetzteZeile        => 11);
                  case Wahl is
                     when -3 =>
                        null;
                     
                     when others =>
                        return;
                  end case;

               when False =>
                  null;
            end case;

         when True =>
            AutospeichernSchleife:
            loop

               SpielstandName := To_Unbounded_Wide_Wide_String (Source => "Autospeichern" & AutoSpeichernWert'Wide_Wide_Image);

               case Exists (Name => "Dateien/Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName))) is
                  when True =>
                     AutoSpeichernWert := AutoSpeichernWert + 1;

                  when False =>
                     exit AutospeichernSchleife;
               end case;
               
            end loop AutospeichernSchleife;
      end case;
         
      Create (File => Datei,
              Mode => Out_File,
              Name => "Dateien/Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName)));

      for Rassen in GlobaleVariablen.RassenImSpiel'Range loop
         
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Put (File  => Datei,
              Item  => Integer (GlobaleVariablen.RassenImSpiel (Rassen)),
              Width => 1);
         Zeilenanzahl := Zeilenanzahl + 1;
         
      end loop;

      RasseSchleife:
      for Rasse in GlobaleVariablen.EinheitenGebaut'Range (1) loop -- Statt alle Werte in die Textdatei zu schreiben, nur Werte ungleich 0 reinschreiben oder nur besetzte Rassen speichern.
         EinheitenSchleife:
         for Einheiten in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleBeschäftigung,
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleBeschäftigung2,
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).ID),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AchsenPosition.YAchse),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AchsenPosition.XAchse),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleLebenspunkte,
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Ada.Float_Text_IO.Put (File => Datei,
                                   Item => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleBewegungspunkte,
                                   Fore => 1,
                                   Aft  => 1,
                                   Exp  => 0);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleErfahrungspunkte,
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuellerRang,
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleBeschäftigungszeit,
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleBeschäftigungszeit2,
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            
         end loop EinheitenSchleife;

         StadtSchleife:
         for Städte in GlobaleVariablen.StadtGebaut'Range (2) loop
            
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).ID,
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AchsenPosition.YAchse),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AchsenPosition.XAchse),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            case GlobaleVariablen.StadtGebaut (Rasse, Städte).AmWasser is
               when True =>
                  Put (File  => Datei,
                       Item  => 1,
                       Width => 1);
                  
               when False =>
                  Put (File  => Datei,
                       Item  => 0,
                       Width => 1);
            end case;
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).Einwohner,
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleNahrungsmittel),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleNahrungsproduktion),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleRessourcen),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleProduktionrate),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleGeldgewinnung),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleForschungsrate),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuellesBauprojekt,
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).VerbleibendeBauzeit),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).Korruption),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Encode (Item => GlobaleVariablen.StadtGebaut (Rasse, Städte).GebäudeVorhanden));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Encode (Item => To_Wide_Wide_String (Source => GlobaleVariablen.StadtGebaut (Rasse, Städte).Name)));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));

            for A in Integer (GlobaleDatentypen.UmgebungBewirtschaftungArray'First (1)) .. Integer (GlobaleDatentypen.UmgebungBewirtschaftungArray'Last (1)) loop
               for B in Integer (GlobaleDatentypen.UmgebungBewirtschaftungArray'First (2)) .. Integer (GlobaleDatentypen.UmgebungBewirtschaftungArray'Last (1)) loop
                  
                  case GlobaleVariablen.StadtGebaut (Rasse, Städte).UmgebungBewirtschaftung (GlobaleDatentypen.Kartenfeld (A), GlobaleDatentypen.Kartenfeld (B)) is
                     when True =>
                        Put (File  => Datei,
                             Item  => 1,
                             Width => 1);                        
                        
                     when False =>
                        Put (File  => Datei,
                             Item  => 0,
                             Width => 1);                        
                  end case;
                  Zeilenanzahl := Zeilenanzahl + 1;
                  Set_Line (File => Datei,
                            To   => Ada.Text_IO.Count (Zeilenanzahl));

               end loop;
            end loop;

            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).ArbeitendeEinwohner,
                 Width => 1);

            Zeilenanzahl := Zeilenanzahl + 1;

         end loop StadtSchleife;         
         
         DiplomatieSchleife:
         for Diplomatie in GlobaleVariablen.Diplomatie'Range (2) loop
            
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => GlobaleVariablen.Diplomatie (Rasse, Diplomatie),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;

         end loop DiplomatieSchleife;         

         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Put (File  => Datei,
              Item  => GlobaleVariablen.Wichtiges (Rasse).AktuelleGeldmenge,
              Width => 1);
         Zeilenanzahl := Zeilenanzahl + 1;
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Put (File  => Datei,
              Item  => Integer (GlobaleVariablen.Wichtiges (Rasse).GeldZugewinnProRunde),
              Width => 1);
         Zeilenanzahl := Zeilenanzahl + 1;
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Put (File  => Datei,
              Item  => Integer (GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsrate),
              Width => 1);
         Zeilenanzahl := Zeilenanzahl + 1;
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Put (File  => Datei,
              Item  => Integer (GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsmenge),
              Width => 1);
         Zeilenanzahl := Zeilenanzahl + 1;
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Put (File  => Datei,
              Item  => Integer (GlobaleVariablen.Wichtiges (Rasse).VerbleibendeForschungszeit),
              Width => 1);
         Zeilenanzahl := Zeilenanzahl + 1;
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Put (File  => Datei,
              Item  => GlobaleVariablen.Wichtiges (Rasse).AktuellesForschungsprojekt,
              Width => 1);
         Zeilenanzahl := Zeilenanzahl + 1;

         for C in GlobaleDatentypen.ErforschtArray'Range loop

            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => GlobaleVariablen.Wichtiges (Rasse).Erforscht (C),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;

         end loop;
      end loop RasseSchleife;

      case Karten.Kartengröße is
         when 9 =>
            KartenPlusWert := 0;
            
         when others =>
            KartenPlusWert := 1;
      end case;

      Set_Line (File => Datei,
                To   => Ada.Text_IO.Count (Zeilenanzahl));
      Put (File  => Datei,
           Item  => Karten.Kartengröße,
           Width => 1);
      Zeilenanzahl := Zeilenanzahl + 1;

      YAchseSchleife:
      for YAchse in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße + KartenPlusWert loop         
         XAchseSchleife:
         for XAchse in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße + KartenPlusWert loop
            
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (Karten.Karten (0, YAchse, XAchse).Grund),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            
            case Karten.Karten (0, YAchse, XAchse).Hügel is
               when True =>
                  Put (File  => Datei,
                       Item  => 1,
                       Width => 1);
                  
               when False =>
                  Put (File  => Datei,
                       Item  => 0,
                       Width => 1);                  
            end case;
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            
            --case Karten.Karten (0, YAchse, XAchse).Sichtbar is
              -- when True =>
                  Put (File  => Datei,
                       Item  => 1,
                       Width => 1);
                  
              -- when False =>
               --   Put (File  => Datei,
                --       Item  => 0,
                --       Width => 1);                  
            --end case;
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (Karten.Karten (0, YAchse, XAchse).Fluss),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (Karten.Karten (0, YAchse, XAchse).VerbesserungStraße),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (Karten.Karten (0, YAchse, XAchse).VerbesserungGebiet),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => Integer (Karten.Karten (0, YAchse, XAchse).Ressource),
                 Width => 1);
            Zeilenanzahl := Zeilenanzahl + 1;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      Set_Line (File => Datei,
                To   => Ada.Text_IO.Count (Zeilenanzahl));            
      Put (File  => Datei,
           Item  => GlobaleVariablen.RundenAnzahl,
           Width => 1);
      Zeilenanzahl := Zeilenanzahl + 1;

      Close (File => Datei);

      Ladezeiten.Speicherzeiten (2, 1) := Clock;
      Ladezeiten.Speichern (WelcheZeit => 1);
      
   end Speichern;
   


   procedure AutoSpeichern is
   begin
      
      if GlobaleVariablen.RundenAnzahl mod GlobaleVariablen.RundenBisAutosave = 0 then      
         Speichern (AutoSpeichern => True);
         
      else
         null;
      end if;
      
   end AutoSpeichern;

end Speichern;
