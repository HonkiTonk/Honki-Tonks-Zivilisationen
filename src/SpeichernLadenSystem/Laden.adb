package body Laden is

   procedure LadenNeu is
   begin
      
      Ladezeiten.LadenLadezeiten (1, 1) := Clock;
      Ladezeiten.LadenLadezeiten (2, 1) := Clock;
      Ladezeiten.Laden (WelcheZeit => 1);
      
   end LadenNeu;



   procedure Laden is
   begin
      
      Ladezeiten.LadenLadezeiten (1, 1) := Clock;
      Zeilenanzahl := 1;
      SpielstandName := Eingabe.SpielstandName;

      case Exists (Name => "Dateien/Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName))) is
         when True =>
            null;

         when False =>
            return;
      end case;

      AllesAufAnfangSetzen.AllesAufAnfangSetzen; -- Aktuell nicht notwendig, wenn ich aber nicht mehr alle Wert schreibe/lese, dann könnten Rückstände übbrig bleiben.
                                                 -- Z. B. Einheiten die auf Plätzen sind, welche beim einlesen nicht überschrieben werden und beim Sortieren wieder ind Spiel kommen.
      
      Open (File => Datei,
            Mode => In_File,
            Name => "Dateien/Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName)));

      for Rassen in GlobaleVariablen.RassenImSpiel'Range loop
         
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Get (File  => Datei,
              Item  => Integer (GlobaleVariablen.RassenImSpiel (Rassen)));
         Zeilenanzahl := Zeilenanzahl + 1;
         
      end loop;

      RasseSchleife:
      for Rasse in GlobaleVariablen.EinheitenGebaut'Range (1) loop -- Statt alle Werte in die Textdatei zu schreiben, nur Werte ungleich 0 reinschreiben oder nur besetzte Rassen speichern.
         EinheitenSchleife:
         for Einheiten in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleBeschäftigung);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleBeschäftigung2);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).ID));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AchsenPosition.YAchse));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AchsenPosition.XAchse));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleLebenspunkte);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Ada.Float_Text_IO.Get (File => Datei,
                                   Item => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleBewegungspunkte);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleErfahrungspunkte);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuellerRang);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleBeschäftigungszeit);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleBeschäftigungszeit2);
            Zeilenanzahl := Zeilenanzahl + 1;
            
         end loop EinheitenSchleife;

         StadtSchleife:
         for Städte in GlobaleVariablen.StadtGebaut'Range (2) loop
            
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).ID);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AchsenPosition.YAchse));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AchsenPosition.XAchse));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Zwischenwert);
            case Zwischenwert is
               when 1 =>
                  GlobaleVariablen.StadtGebaut (Rasse, Städte).AmWasser := True;
                  
               when others =>
                  GlobaleVariablen.StadtGebaut (Rasse, Städte).AmWasser := False;
            end case;
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).Einwohner);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleNahrungsmittel));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleNahrungsproduktion));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleRessourcen));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleProduktionrate));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleGeldgewinnung));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleForschungsrate));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuellesBauprojekt);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).VerbleibendeBauzeit));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (GlobaleVariablen.StadtGebaut (Rasse, Städte).Korruption));
            Zeilenanzahl := Zeilenanzahl + 1;
            Close (File => Datei);


            Ada.Wide_Wide_Text_IO.Open (File => DateiWide,
                                        Mode => Ada.Wide_Wide_Text_IO.In_File,
                                        Name => "Dateien/Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName)));
            Ada.Wide_Wide_Text_IO.Set_Line (File => DateiWide,
                                            To   => Ada.Wide_Wide_Text_IO.Count (Zeilenanzahl));
            GlobaleVariablen.StadtGebaut (Rasse, Städte).GebäudeVorhanden := Ada.Wide_Wide_Text_IO.Get_Line (File => DateiWide);

            Zeilenanzahl := Zeilenanzahl + 1;
            Ada.Wide_Wide_Text_IO.Set_Line (File => DateiWide,
                                            To   => Ada.Wide_Wide_Text_IO.Count (Zeilenanzahl));
            GlobaleVariablen.StadtGebaut (Rasse, Städte).Name := To_Unbounded_Wide_Wide_String (Source => Ada.Wide_Wide_Text_IO.Get_Line (File => DateiWide));
            Ada.Wide_Wide_Text_IO.Close (File => DateiWide);

            Open (File => Datei,
                  Mode => In_File,
                  Name => "Dateien/Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName)));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            for A in GlobaleDatentypen.UmgebungBewirtschaftungArray'Range (1) loop
               for B in GlobaleDatentypen.UmgebungBewirtschaftungArray'Range (2) loop

                  Get (File  => Datei,
                       Item  => Zwischenwert);
                  case Zwischenwert is
                     when 1 =>
                        GlobaleVariablen.StadtGebaut (Rasse, Städte).UmgebungBewirtschaftung (A, B) := True;
                  
                     when others =>
                        GlobaleVariablen.StadtGebaut (Rasse, Städte).UmgebungBewirtschaftung (A, B) := False;
                  end case;
                  Zeilenanzahl := Zeilenanzahl + 1;
                  Set_Line (File => Datei,
                            To   => Ada.Text_IO.Count (Zeilenanzahl));

               end loop;
            end loop;

            Get (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).ArbeitendeEinwohner);

            Zeilenanzahl := Zeilenanzahl + 1;

         end loop StadtSchleife;            
       
         DiplomatieSchleife:
         for Diplomatie in GlobaleVariablen.Diplomatie'Range (2) loop

            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.Diplomatie (Rasse, Diplomatie));
            Zeilenanzahl := Zeilenanzahl + 1;

         end loop DiplomatieSchleife;

         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Get (File  => Datei,
              Item  => GlobaleVariablen.Wichtiges (Rasse).AktuelleGeldmenge);
         Zeilenanzahl := Zeilenanzahl + 1;
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Get (File  => Datei,
              Item  => Integer (GlobaleVariablen.Wichtiges (Rasse).GeldZugewinnProRunde));
         Zeilenanzahl := Zeilenanzahl + 1;
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Get (File  => Datei,
              Item  => Integer (GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsrate));
         Zeilenanzahl := Zeilenanzahl + 1;
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Get (File  => Datei,
              Item  => Integer (GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsmenge));
         Zeilenanzahl := Zeilenanzahl + 1;
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Get (File  => Datei,
              Item  => Integer (GlobaleVariablen.Wichtiges (Rasse).VerbleibendeForschungszeit));
         Zeilenanzahl := Zeilenanzahl + 1;
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Get (File  => Datei,
              Item  => GlobaleVariablen.Wichtiges (Rasse).AktuellesForschungsprojekt);
         Zeilenanzahl := Zeilenanzahl + 1;
         
         for C in GlobaleDatentypen.ErforschtArray'Range loop

            Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.Wichtiges (Rasse).Erforscht (C));
            Zeilenanzahl := Zeilenanzahl + 1;

         end loop;       
      end loop RasseSchleife;

      Set_Line (File => Datei,
                To   => Ada.Text_IO.Count (Zeilenanzahl));
      Get (File  => Datei,
           Item  => Karten.Kartengröße);
      Zeilenanzahl := Zeilenanzahl + 1;

      case Karten.Kartengröße is
         when 9 =>
            KartenPlusWert := 0;
            
         when others =>
            KartenPlusWert := 1;
      end case;

      YAchseSchleife:
      for YAchse in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße + KartenPlusWert loop
         XAchseSchleife:
         for XAchse in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße + KartenPlusWert loop     
            
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (Karten.Karten (0, YAchse, XAchse).Grund));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            
            Get (File  => Datei,
                 Item  => Zwischenwert);
            case Zwischenwert is
               when 1 =>
                  Karten.Karten (0, YAchse, XAchse).Hügel := True;
                  
               when others =>
                  Karten.Karten (0, YAchse, XAchse).Hügel := False;
            end case;
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (Karten.Karten (0, YAchse, XAchse).Fluss));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (Karten.Karten (0, YAchse, XAchse).VerbesserungStraße));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (Karten.Karten (0, YAchse, XAchse).VerbesserungGebiet));
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Integer (Karten.Karten (0, YAchse, XAchse).Ressource));
            Zeilenanzahl := Zeilenanzahl + 1;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      Set_Line (File => Datei,
                To   => Ada.Text_IO.Count (Zeilenanzahl));            
      Get (File  => Datei,
           Item  => GlobaleVariablen.RundenAnzahl);

      Close (File => Datei);

      Ladezeiten.LadenLadezeiten (2, 1) := Clock;
      
   end Laden;

end Laden;
