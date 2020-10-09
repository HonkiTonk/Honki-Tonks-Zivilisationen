package VielleichtNochBrauchbareReste is

   package body Speichern is

   function Speichern return Boolean is
   begin

      Zeilenanzahl := 1;
      SpielstandName := Eingabe.SpielstandName;

      case Exists (Name => "Dateien/Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName))) is
         when True =>
            Delete_File (Name => "Dateien/Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName)));

         when False =>
            null;
      end case;
      
      Create (File => Datei,
              Mode => Out_File,
              Name => "Dateien/Spielstand/" & Encode (Item => To_Wide_Wide_String (Source => SpielstandName)));

      RasseSchleife:
      for Rasse in GlobaleVariablen.EinheitenGebaut'Range (1) loop -- Statt alle Werte in die Textdatei zu schreiben, nur Werte ungleich 0 reinschreiben oder nur besetzte Rassen speichern.
         EinheitenSchleife:
         for Einheiten in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
            Set_Line (File => Datei,
                      To   => Ada.Text_IO.Count (Zeilenanzahl));
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleBeschäftigung,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleBeschäftigung2,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).ID,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).YAchse,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).XAchse,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleLebenspunkte,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Ada.Float_Text_IO.Put (File => Datei,
                                   Item => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleBewegungspunkte,
                                   Fore => 1,
                                   Aft  => 1,
                                   Exp  => 0);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleErfahrungspunkte,
                 Width => 1);
            Put (File => Datei,
                  Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuellerRang,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.EinheitenGebaut (Rasse, Einheiten).AktuelleBeschäftigungszeit,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
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
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).YAchse,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).XAchse,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
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
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).Einwohner,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleNahrungsmittel,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleNahrungsproduktion,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleRessourcen,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleProduktionrate,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleGeldgewinnung,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuelleForschungsrate,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).AktuellesBauprojekt,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).VerbleibendeBauzeit,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).Korruption,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => Encode (Item => GlobaleVariablen.StadtGebaut (Rasse, Städte).GebäudeVorhanden));
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => Encode (Item => To_Wide_Wide_String (Source => GlobaleVariablen.StadtGebaut (Rasse, Städte).Name)));
            Put (File => Datei,
                 Item => ",");
            for A in GlobaleVariablen.UmgebungBewirtschaftungArray'Range (1) loop
               for B in GlobaleVariablen.UmgebungBewirtschaftungArray'Range (2) loop
                  
                  case GlobaleVariablen.StadtGebaut (Rasse, Städte).UmgebungBewirtschaftung (A, B) is
                     when True =>
                        Put (File  => Datei,
                             Item  => 1,
                             Width => 1);                        
                        
                     when False =>
                        Put (File  => Datei,
                             Item  => 0,
                             Width => 1);                        
                  end case;
                  Put (File => Datei,
                       Item => ",");

               end loop;
            end loop;
            Put (File  => Datei,
                 Item  => GlobaleVariablen.StadtGebaut (Rasse, Städte).ArbeitendeEinwohner,
                 Width => 1);

            Zeilenanzahl := Zeilenanzahl + 1;

         end loop StadtSchleife;
            
         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));

         DiplomatieSchleife:
         for Diplomatie in GlobaleVariablen.Diplomatie'Range (2) loop

            Put (File  => Datei,
                 Item  => GlobaleVariablen.Diplomatie (Rasse, Diplomatie),
                 Width => 1);
            case Diplomatie is
               when GlobaleVariablen.Diplomatie'Last (2) =>
                  null;
                  
               when others =>
                  Put (File => Datei,
                       Item => ",");
            end case;

         end loop DiplomatieSchleife;

         Zeilenanzahl := Zeilenanzahl + 1;

         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         Put (File  => Datei,
              Item  => GlobaleVariablen.Wichtiges (Rasse).AktuelleGeldmenge,
              Width => 1);
         Put (File => Datei,
              Item => ",");
         Put (File  => Datei,
              Item  => GlobaleVariablen.Wichtiges (Rasse).GeldZugewinnProRunde,
              Width => 1);
         Put (File => Datei,
              Item => ",");
         Put (File  => Datei,
              Item  => GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsrate,
              Width => 1);
         Put (File => Datei,
              Item => ",");
         Put (File  => Datei,
              Item  => GlobaleVariablen.Wichtiges (Rasse).AktuelleForschungsmenge,
              Width => 1);
         Put (File => Datei,
              Item => ",");
         Put (File  => Datei,
              Item  => GlobaleVariablen.Wichtiges (Rasse).VerbleibendeForschungszeit,
              Width => 1);
         Put (File => Datei,
              Item => ",");
         Put (File  => Datei,
              Item  => GlobaleVariablen.Wichtiges (Rasse).AktuellesForschungsprojekt,
              Width => 1);
         Put (File => Datei,
              Item => ",");

         for C in GlobaleVariablen.ErforschtArray'Range loop

            Put (File  => Datei,
                 Item  => GlobaleVariablen.Wichtiges (Rasse).Erforscht (C),
                 Width => 1);
            case C is
               when GlobaleVariablen.ErforschtArray'Last =>
                  null;
                  
               when others =>
                  Put (File => Datei,
                       Item => ",");
            end case;

         end loop;

         Zeilenanzahl := Zeilenanzahl + 1;

      end loop RasseSchleife;

      case Karten.Kartengröße is
         when 1_000 =>
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

      for YAchse in Karten.Karten'First (1) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße + KartenPlusWert loop

         Set_Line (File => Datei,
                   To   => Ada.Text_IO.Count (Zeilenanzahl));
         for XAchse in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße + KartenPlusWert  loop          
                        
            Put (File  => Datei,
                 Item  => Karten.Karten (YAchse, XAchse).Grund,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            
            case Karten.Karten (YAchse, XAchse).Hügel is
               when True =>
                  Put (File  => Datei,
                       Item  => 1,
                       Width => 1);
                  
               when False =>
                  Put (File  => Datei,
                       Item  => 0,
                       Width => 1);                  
            end case;
            Put (File => Datei,
                 Item => ",");
            
            case Karten.Karten (YAchse, XAchse).Sichtbar is
               when True =>
                  Put (File  => Datei,
                       Item  => 1,
                       Width => 1);
                  
               when False =>
                  Put (File  => Datei,
                       Item  => 0,
                       Width => 1);                  
            end case;
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => Karten.Karten (YAchse, XAchse).Fluss,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => Karten.Karten (YAchse, XAchse).VerbesserungStraße,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => Karten.Karten (YAchse, XAchse).VerbesserungGebiet,
                 Width => 1);
            Put (File => Datei,
                 Item => ",");
            Put (File  => Datei,
                 Item  => Karten.Karten (YAchse, XAchse).Ressource,
                 Width => 1);

            case XAchse is
               when Karten.Karten'Last (2) =>
                  null;
                  
               when others =>
                  Put (File => Datei,
                       Item => ",");
            end case;
            
         end loop;

         Zeilenanzahl := Zeilenanzahl + 1;

      end loop;

      Set_Line (File => Datei,
                To   => Ada.Text_IO.Count (Zeilenanzahl));            
      Put (File  => Datei,
           Item  => GlobaleVariablen.RundenAnzahl,
           Width => 1);
      Put (File => Datei,
           Item => ",");          
      Put (File  => Datei,
           Item  => GlobaleVariablen.SpielerAnzahl,
           Width => 1);
      Put (File => Datei,
           Item => ",");          
      Put (File  => Datei,
           Item  => GlobaleVariablen.Rasse,
           Width => 1);
      Put (File => Datei,
           Item => ",");          
      Put (File  => Datei,
           Item  => GlobaleVariablen.CursorImSpiel.YAchse,
           Width => 1);
      Put (File => Datei,
           Item => ",");          
      Put (File  => Datei,
           Item  => GlobaleVariablen.CursorImSpiel.XAchse,
           Width => 1);
      Put (File => Datei,
           Item => ",");          
      Put (File  => Datei,
           Item  => GlobaleVariablen.CursorImSpiel.YAchseAlt,
           Width => 1);
      Put (File => Datei,
           Item => ",");          
      Put (File  => Datei,
           Item  => GlobaleVariablen.CursorImSpiel.XAchseAlt,
           Width => 1);

      Close (File => Datei);
      
      return True;
      
   end Speichern;
   


   procedure AutoSpeichern is
   begin
      
      null;
      
   end AutoSpeichern;

end Speichern;


end KartenGenerator;
