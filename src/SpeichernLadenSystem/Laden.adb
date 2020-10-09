package body Laden is

   procedure Laden is
   begin
      
      Zeilenanzahl := 1;
      SpielstandName := Eingabe.SpielstandName;

      case Exists (Name => "Dateien/Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName))) is
         when True =>
            null;

         when False =>
            return;
      end case;
      
      Open (File => Datei,
            Mode => In_File,
            Name => "Dateien/Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName)));

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
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).ID);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).YAchse);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).XAchse);
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
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).YAchse);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).XAchse);
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
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleNahrungsmittel);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleNahrungsproduktion);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleRessourcen);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleProduktionrate);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleGeldgewinnung);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleForschungsrate);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuellesBauprojekt);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).VerbleibendeBauzeit);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).Korruption);
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
            for A in GlobaleVariablen.UmgebungBewirtschaftungArray'Range (1) loop
               for B in GlobaleVariablen.UmgebungBewirtschaftungArray'Range (2) loop

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
              Item  => GlobaleVariablen.Wichtiges (Rasse).GeldZugewinnProRunde);
         Zeilenanzahl := Zeilenanzahl + 1;
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Get (File  => Datei,
              Item  => GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsrate);
         Zeilenanzahl := Zeilenanzahl + 1;
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Get (File  => Datei,
              Item  => GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsmenge);
         Zeilenanzahl := Zeilenanzahl + 1;
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Get (File  => Datei,
              Item  => GlobaleVariablen.Wichtiges (Rasse).VerbleibendeForschungszeit);
         Zeilenanzahl := Zeilenanzahl + 1;
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Get (File  => Datei,
              Item  => GlobaleVariablen.Wichtiges (Rasse).AktuellesForschungsprojekt);
         Zeilenanzahl := Zeilenanzahl + 1;
         
         for C in GlobaleVariablen.ErforschtArray'Range loop

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
      for YAchse in Karten.Karten'First (1) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße + KartenPlusWert loop
         XAchseSchleife:
         for XAchse in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße + KartenPlusWert loop     
            
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Karten.Karten (YAchse, XAchse).Grund);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            
            Get (File  => Datei,
                 Item  => Zwischenwert);
            case Zwischenwert is
               when 1 =>
                  Karten.Karten (YAchse, XAchse).Hügel := True;
                  
               when others =>
                  Karten.Karten (YAchse, XAchse).Hügel := False;
            end case;
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            
            Get (File  => Datei,
                 Item  => Zwischenwert);
            case Zwischenwert is
               when 1 =>
                  Karten.Karten (YAchse, XAchse).Sichtbar  := True;
                  
               when others =>
                  Karten.Karten (YAchse, XAchse).Sichtbar  := False;
            end case;
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Karten.Karten (YAchse, XAchse).Fluss);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Karten.Karten (YAchse, XAchse).VerbesserungStraße);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Karten.Karten (YAchse, XAchse).VerbesserungGebiet);
            Zeilenanzahl := Zeilenanzahl + 1;
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Get (File  => Datei,
                 Item  => Karten.Karten (YAchse, XAchse).Ressource);
            Zeilenanzahl := Zeilenanzahl + 1;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      Set_Line (File => Datei,
                To   => Ada.Text_IO.Count (Zeilenanzahl));            
      Get (File  => Datei,
           Item  => GlobaleVariablen.RundenAnzahl);
      Zeilenanzahl := Zeilenanzahl + 1;
      Set_Line (File => Datei,
                To   => Ada.Text_IO.Count (Zeilenanzahl));        
      Get (File  => Datei,
           Item  => GlobaleVariablen.SpielerAnzahl);
      Zeilenanzahl := Zeilenanzahl + 1;
      Set_Line (File => Datei,
                To   => Ada.Text_IO.Count (Zeilenanzahl));       
      Get (File  => Datei,
           Item  => GlobaleVariablen.Rasse);
      Zeilenanzahl := Zeilenanzahl + 1;
      Set_Line (File => Datei,
                To   => Ada.Text_IO.Count (Zeilenanzahl));      
      Get (File  => Datei,
           Item  => GlobaleVariablen.CursorImSpiel.YAchse);
      Zeilenanzahl := Zeilenanzahl + 1;
      Set_Line (File => Datei,
                To   => Ada.Text_IO.Count (Zeilenanzahl));       
      Get (File  => Datei,
           Item  => GlobaleVariablen.CursorImSpiel.XAchse);
      Zeilenanzahl := Zeilenanzahl + 1;
      Set_Line (File => Datei,
                To   => Ada.Text_IO.Count (Zeilenanzahl));       
      Get (File  => Datei,
           Item  => GlobaleVariablen.CursorImSpiel.YAchseAlt);
      Zeilenanzahl := Zeilenanzahl + 1;
      Set_Line (File => Datei,
                To   => Ada.Text_IO.Count (Zeilenanzahl));       
      Get (File  => Datei,
           Item  => GlobaleVariablen.CursorImSpiel.XAchseAlt);

      Close (File => Datei);
      
   end Laden;

end Laden;
