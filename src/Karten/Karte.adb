package body Karte is

   procedure AnzeigeKarte is
   begin
      
      case Karten.Kartengröße is
         when 1 =>
            SichtweiteFestlegen := 1;
            BewegungsfeldFestlegen := 1;
            
         when 2 =>
            SichtweiteFestlegen := 2;
            BewegungsfeldFestlegen := 2;

         -- when 10 =>
            -- if Karten.Kartengrößen (Karten.Kartengröße).
            
         when others =>
            SichtweiteFestlegen := 3;
            BewegungsfeldFestlegen := 3;            
      end case;      

      if GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse > GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.YAchse + Bewegungsfeld (BewegungsfeldFestlegen).YAchse
        or GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse < GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.YAchse - Bewegungsfeld (BewegungsfeldFestlegen).YAchse then
         GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.YAchse := GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse;
         
      else
         null;
      end if;
            
      if GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegen).XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsengröße then
         if GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse < GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegen).XAchse
           and GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse > GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegen).XAchse
           - Karten.Kartengrößen (Karten.Kartengröße).XAchsengröße then
            GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.XAchse := GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse;         
            
         else
            null;
         end if;
         
      elsif GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegen).XAchse < Karten.Karten'First (3) then
         if GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse > GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegen).XAchse
           and GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse < GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegen).XAchse
           + Karten.Kartengrößen (Karten.Kartengröße).XAchsengröße then
            GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.XAchse := GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse;         
            
         else
            null;
         end if;
         
      else
         if GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse > GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegen).XAchse
           or GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse < GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegen).XAchse then
            GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.XAchse := GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse;
            
         else
            null;
         end if;
      end if;
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      YAchseSchleife:
      for YAchse in -Sichtweite (SichtweiteFestlegen).YAchse .. Sichtweite (SichtweiteFestlegen).YAchse loop
         XAchseSchleife:
         for XAchse in -Sichtweite (SichtweiteFestlegen).XAchse .. Sichtweite (SichtweiteFestlegen).XAchse loop
            
            Kartenwert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.YAchse,
                                                              XKoordinate    => GlobaleVariablen.CursorImSpiel.AchsenPositionAlt.XAchse,
                                                              YÄnderung      => YAchse,
                                                              XÄnderung      => XAchse,
                                                              ZusatzYAbstand => 0);
            
            case Kartenwert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  Sichtbarkeit.Sichtbarkeit (InDerStadt => False,
                                             EAchse     => GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse,
                                             YAchse     => Kartenwert.YAchse,
                                             XAchse     => Kartenwert.XAchse);
            end case;
            
            if XAchse = Sichtweite (SichtweiteFestlegen).XAchse then
               New_Line;
                  
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;    
         
      Information;

   end AnzeigeKarte;
   


   procedure Information is
   begin

      Verteidigungsbonus := 0;
      Nahrungsgewinnung := 0;
      Ressourcengewinnung := 0;
      Geldgewinnung := 0;
      Wissensgewinnung := 0;

      Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 33)) & GlobaleVariablen.RundenAnzahl'Wide_Wide_Image);

      Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 34)) & GlobaleVariablen.Wichtiges (GlobaleVariablen.Rasse).AktuelleGeldmenge'Wide_Wide_Image);
      Put_Line (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 35)) & GlobaleVariablen.Wichtiges (GlobaleVariablen.Rasse).GeldZugewinnProRunde'Wide_Wide_Image);

      Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 38)));
      ForschungsDatenbank.Beschreibung (ID => GlobaleVariablen.Wichtiges (GlobaleVariablen.Rasse).AktuellesForschungsprojekt);
      Put_Line (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 36)) & GlobaleVariablen.Wichtiges (GlobaleVariablen.Rasse).VerbleibendeForschungszeit'Wide_Wide_Image);

      Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 39)) & GlobaleVariablen.Wichtiges (GlobaleVariablen.Rasse).AktuelleForschungsmenge'Wide_Wide_Image);
      Put_Line (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 37)) & GlobaleVariablen.Wichtiges (GlobaleVariablen.Rasse).AktuelleForschungsrate'Wide_Wide_Image);
      New_Line;
      
      case Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Sichtbar (GlobaleVariablen.Rasse) is
         when True =>
            RassenEinheitenSchleife:
            for Rasse in GlobaleVariablen.EinheitenGebaut'Range (1) loop
               EinheitenSchleife:
               for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
                  case GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID is
                     when 0 =>
                        exit EinheitenSchleife;
                  
                     when others =>
                        if GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.EAchse = GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse
                          and GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.YAchse = GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse
                          and GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.XAchse = GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse then
                           EinheitenDatenbank.Beschreibung (GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID);                        
                           Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 14)));
                           Put_Line (Item => GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleLebenspunkte'Wide_Wide_Image & " /"
                                     & EinheitenDatenbank.EinheitenListe (Rasse, GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID).MaximaleLebenspunkte'Wide_Wide_Image);
                        
                           if Rasse = GlobaleVariablen.Rasse or GlobaleVariablen.FeindlicheInformationenSehen = True then
                              Put (Item => "           " & To_Wide_Wide_String (GlobaleVariablen.TexteEinlesen (19, 15)));
                              Ada.Float_Text_IO.Put (Item => GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBewegungspunkte,
                                                     Fore => 1,
                                                     Aft  => 1,
                                                     Exp  => 0);
                              Put (Item => " / ");
                              Ada.Float_Text_IO.Put (Item => EinheitenDatenbank.EinheitenListe (Rasse, GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID).MaximaleBewegungspunkte,
                                                     Fore => 1,
                                                     Aft  => 1,
                                                     Exp  => 0);
                              Put (Item => "    " & To_Wide_Wide_String (GlobaleVariablen.TexteEinlesen (19, 16)));
                              Put_Line (Item => GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleErfahrungspunkte'Wide_Wide_Image & " /"
                                        & EinheitenDatenbank.EinheitenListe (Rasse, GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID).Beförderungsgrenze'Wide_Wide_Image);
                              
                              Put (Item => "           " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 17)));
                              EinheitenDatenbank.Beschäftigung (GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBeschäftigung);
                              Put (Item => "    " & To_Wide_Wide_String (GlobaleVariablen.TexteEinlesen (19, 18)));
                              Put_Line (Item => GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuelleBeschäftigungszeit'Wide_Wide_Image);

                              Put (Item => "           " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 24)));
                              Put (Item => EinheitenDatenbank.EinheitenListe (Rasse, GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID).Angriff'Wide_Wide_Image);
                              Put (Item => "    " & To_Wide_Wide_String (GlobaleVariablen.TexteEinlesen (19, 25)));
                              Put (Item => EinheitenDatenbank.EinheitenListe (Rasse, GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID).Verteidigung'Wide_Wide_Image);
                              Put (Item => "    " & To_Wide_Wide_String (GlobaleVariablen.TexteEinlesen (19, 26)));
                              Put_Line (Item => GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AktuellerRang'Wide_Wide_Image & " /"
                                        & EinheitenDatenbank.EinheitenListe (Rasse, GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID).MaximalerRang'Wide_Wide_Image);
                              
                           else
                              null;
                           end if;                           
                        
                           New_Line;
                           case GlobaleVariablen.FeindlicheInformationenSehen is
                              when False =>
                                 null;
                                 
                              when True =>
                                 Put_Line (Item => "Aktuelle Rasse: " & Rasse'Wide_Wide_Image);
                           end case;
                           exit RassenEinheitenSchleife;
                                 
                        else
                           null;
                        end if;                  
                  end case;                  
                                                   
               end loop EinheitenSchleife;
            end loop RassenEinheitenSchleife;
            
            RassenStadtSchleife:
            for Rasse in GlobaleVariablen.StadtGebaut'Range (1) loop
               StadtSchleife:
               for StadtNummer in GlobaleVariablen.StadtGebaut'Range (2) loop
            
                  case GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ID is
                     when 0 =>
                        exit StadtSchleife;
                  
                     when others =>
                        if GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse = GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse
                          and GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.YAchse = GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse
                          and GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.XAchse = GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse then
                           KarteStadt.Beschreibung (Rasse => Rasse, StadtNummer => StadtNummer);
                           if Rasse = GlobaleVariablen.Rasse or GlobaleVariablen.FeindlicheInformationenSehen = True then                              
                              Verteidigungsbonus := Verteidigungsbonus + VerbesserungenDatenbank.VerbesserungObjektListe (KartenVerbesserung (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ID)).Verteidigungsbonus;

                           else
                              null;
                           end if;
                           case GlobaleVariablen.FeindlicheInformationenSehen is
                              when False =>
                                 null;
                                 
                              when True =>
                                 Put_Line (Item => "Aktuelle Rasse: " & Rasse'Wide_Wide_Image);
                           end case;
                           exit RassenStadtSchleife;
                     
                        else
                           null;
                        end if;
                  end case;

               end loop StadtSchleife;
            end loop RassenStadtSchleife;
                  
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Hügel = True
              and Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund /= 6 then
               Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (9, 34)));
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                             GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                             GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                               GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund).Wissensgewinnung;
         
            elsif Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Hügel = True then
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                             GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                             GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                               GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund).Wissensgewinnung;
               
            else         
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                             GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                             GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                               GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Grund).Wissensgewinnung;
            end if;
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Ressource /= 0 then
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                             GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Ressource);

               Verteidigungsbonus
                 := Verteidigungsbonus + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                            GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Ressource).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Ressource).Nahrungsgewinnung;
               Ressourcengewinnung
                 := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                             GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Ressource).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Ressource).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Ressource).Wissensgewinnung;
         
            else
               null;
            end if;
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).VerbesserungGebiet /= 0 then
               VerbesserungenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                     GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).VerbesserungGebiet);

               Verteidigungsbonus
                 := Verteidigungsbonus + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                          GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).VerbesserungGebiet).Verteidigungsbonus;
               Nahrungsgewinnung
                 := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).VerbesserungGebiet).Nahrungsbonus;
               Ressourcengewinnung
                 := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).VerbesserungGebiet).Ressourcenbonus;
               Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                                 GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).VerbesserungGebiet).Geldbonus;
               Wissensgewinnung
                 := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                        GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).VerbesserungGebiet).Wissensbonus;
         
            else
               null;
            end if;
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).VerbesserungStraße /= 0 then
               VerbesserungenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                     GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).VerbesserungStraße);

               Verteidigungsbonus
                 := Verteidigungsbonus + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                          GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).VerbesserungStraße).Verteidigungsbonus;
               Nahrungsgewinnung
                 := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).VerbesserungStraße).Nahrungsbonus;
               Ressourcengewinnung
                 := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).VerbesserungStraße).Ressourcenbonus;
               Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                                 GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).VerbesserungStraße).Geldbonus;
               Wissensgewinnung
                 := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                        GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).VerbesserungStraße).Wissensbonus;
         
            else
               null;
            end if;
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Fluss /= 0 then
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                             GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Fluss);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                             GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Fluss).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Fluss).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                               GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Fluss).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Fluss).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Fluss).Wissensgewinnung;
         
            else
               null;
            end if;
            
            New_Line;
            Put (Item => "       " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 19)));
            Put (Item => Verteidigungsbonus'Wide_Wide_Image);
            Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 20)));
            Put_Line (Item => Nahrungsgewinnung'Wide_Wide_Image);
            Put (Item => "       " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 21)));
            Put (Item => Ressourcengewinnung'Wide_Wide_Image);
            Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 22)));
            Put (Item => Geldgewinnung'Wide_Wide_Image);
            Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 23)));
            Put_Line (Item => Wissensgewinnung'Wide_Wide_Image);
            
         when False =>
            null;
      end case;

      New_Line;
      case GlobaleVariablen.FeindlicheInformationenSehen is
         when False =>
            null;
                                 
         when True =>
            Put (Item => "Aktuelle EPosition: " & GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse'Wide_Wide_Image);
            Put (Item => "    Aktuelle YPosition: " & GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse'Wide_Wide_Image);
            Put_Line (Item => "    Aktuelle XPosition: " & GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse'Wide_Wide_Image);
            Put_Line (Item => "Kartenfeldbewertung :" & Karten.Karten (GlobaleVariablen.CursorImSpiel.AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel.AchsenPosition.YAchse,
                      GlobaleVariablen.CursorImSpiel.AchsenPosition.XAchse).Felderwertung'Wide_Wide_Image);
      end case;
            
   end Information; 
   
end Karte;
