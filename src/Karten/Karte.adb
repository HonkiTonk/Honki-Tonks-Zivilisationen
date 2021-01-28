package body Karte is

   procedure AnzeigeKarte (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      case Karten.Kartengröße is
         when 1 =>
            SichtweiteFestlegen := 1;
            BewegungsfeldFestlegen := 1;
            
         when 2 =>
            SichtweiteFestlegen := 2;
            BewegungsfeldFestlegen := 2;

          when 10 =>
            if Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (1).YAchsenGröße or Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (1).XAchsenGröße then
               SichtweiteFestlegen := 1;
               BewegungsfeldFestlegen := 1;
               
            elsif Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (2).YAchsenGröße or Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (2).XAchsenGröße then
               SichtweiteFestlegen := 2;
               BewegungsfeldFestlegen := 2;
               
            else
               SichtweiteFestlegen := 3;
               BewegungsfeldFestlegen := 3; 
            end if;
            
         when others =>
            SichtweiteFestlegen := 3;
            BewegungsfeldFestlegen := 3;            
      end case;      

      if GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.YAchse + Bewegungsfeld (BewegungsfeldFestlegen).YAchse
        or GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.YAchse - Bewegungsfeld (BewegungsfeldFestlegen).YAchse then
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse;
         
      else
         null;
      end if;
            
      if GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegen).XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsengröße then
         if GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegen).XAchse
           and GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegen).XAchse
           - Karten.Kartengrößen (Karten.Kartengröße).XAchsengröße then
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse;         
            
         else
            null;
         end if;
         
      elsif GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegen).XAchse < Karten.Karten'First (3) then
         if GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegen).XAchse
           and GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegen).XAchse
           + Karten.Kartengrößen (Karten.Kartengröße).XAchsengröße then
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse;         
            
         else
            null;
         end if;
         
      else
         if GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegen).XAchse
           or GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegen).XAchse then
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse;
            
         else
            null;
         end if;
      end if;
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      YAchseSchleife:
      for YAchse in -Sichtweite (SichtweiteFestlegen).YAchse .. Sichtweite (SichtweiteFestlegen).YAchse loop
         XAchseSchleife:
         for XAchse in -Sichtweite (SichtweiteFestlegen).XAchse .. Sichtweite (SichtweiteFestlegen).XAchse loop
            
            Kartenwert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.EAchse,
                                                                                 GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.YAchse,
                                                                                 GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse),
                                                              Änderung       => (0, YAchse, XAchse),
                                                              ZusatzYAbstand => 0);
            
            case Kartenwert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  Sichtbarkeit.Sichtbarkeit (InDerStadt       => False,
                                             EAchse           => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                             YAchse           => Kartenwert.YAchse,
                                             XAchse           => Kartenwert.XAchse,
                                             RasseExtern      => RasseExtern);
            end case;
            
            if XAchse = Sichtweite (SichtweiteFestlegen).XAchse then
               New_Line;
                  
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;    
         
      Information (RasseExtern => RasseExtern);

   end AnzeigeKarte;
   


   procedure Information (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin

      Verteidigungsbonus := 0;
      Nahrungsgewinnung := 0;
      Ressourcengewinnung := 0;
      Geldgewinnung := 0;
      Wissensgewinnung := 0;
      
      -- Allgemeine Informationen über die eigene Rasse, immer sichtbar
      Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 33)) & GlobaleVariablen.RundenAnzahl'Wide_Wide_Image);

      Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 34)) & GlobaleVariablen.Wichtiges (RasseExtern).AktuelleGeldmenge'Wide_Wide_Image);
      Put_Line (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 35)) & GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde'Wide_Wide_Image);

      Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 38)));
      ForschungsDatenbank.Beschreibung (ID => GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt);
      Put_Line (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 36)) & GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit'Wide_Wide_Image);

      Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 39)) & GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsmenge'Wide_Wide_Image);
      Put_Line (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 37)) & GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsrate'Wide_Wide_Image);
      New_Line;
      
      case Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                          GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Sichtbar (RasseExtern) is
         when True =>
            RasseUndPlatznummer := SchleifenPruefungen.KoordinatenEinheitOhneRasseSuchen (Koordinaten => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
            
            case RasseUndPlatznummer.Platznummer is
               when SchleifenPruefungen.RückgabeWert =>
                  null;
                  
               when others => -- Allgemeine Einheiteninformationen, nur sichtbar wenn das Kartenfeld aufgedackt ist und sich dort eine Einheit befindet
                  EinheitenDatenbank.Beschreibung (GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).ID);                        
                  Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 14)));
                  Put_Line (Item => GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleLebenspunkte'Wide_Wide_Image & " /"
                            & EinheitenDatenbank.EinheitenListe (RasseUndPlatznummer.Rasse,
                              GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).ID).MaximaleLebenspunkte'Wide_Wide_Image);
            
                  -- "Volle" Einheiteninformationen, nur sichtbar wenn eigene Einheit oder wenn Cheat aktiviert ist
                  if RasseExtern = RasseUndPlatznummer.Rasse or GlobaleVariablen.FeindlicheInformationenSehen = True then
                     Put (Item => "           " & To_Wide_Wide_String (GlobaleVariablen.TexteEinlesenNeu (9, 15)));
                     Ada.Float_Text_IO.Put (Item => GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleBewegungspunkte,
                                            Fore => 1,
                                            Aft  => 1,
                                            Exp  => 0);
                     Put (Item => " / ");
                     Ada.Float_Text_IO.Put (Item => EinheitenDatenbank.EinheitenListe (RasseUndPlatznummer.Rasse, GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse,
                                            RasseUndPlatznummer.Platznummer).ID).MaximaleBewegungspunkte,
                                            Fore => 1,
                                            Aft  => 1,
                                            Exp  => 0);
                     Put (Item => "    " & To_Wide_Wide_String (GlobaleVariablen.TexteEinlesenNeu (9, 16)));
                     Put_Line (Item => GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleErfahrungspunkte'Wide_Wide_Image & " /"
                               & EinheitenDatenbank.EinheitenListe (RasseUndPlatznummer.Rasse, GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse,
                                 RasseUndPlatznummer.Platznummer).ID).Beförderungsgrenze'Wide_Wide_Image);
                              
                     Put (Item => "           " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 17)));
                     EinheitenDatenbank.Beschäftigung (GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleBeschäftigung);
                     Put (Item => "    " & To_Wide_Wide_String (GlobaleVariablen.TexteEinlesenNeu (9, 18)));
                     Put_Line (Item => GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleBeschäftigungszeit'Wide_Wide_Image);

                     Put (Item => "           " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 24)));
                     Put (Item => EinheitenDatenbank.EinheitenListe (RasseUndPlatznummer.Rasse, GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).ID).Angriff'Wide_Wide_Image);
                     Put (Item => "    " & To_Wide_Wide_String (GlobaleVariablen.TexteEinlesenNeu (9, 25)));
                     Put (Item => EinheitenDatenbank.EinheitenListe (RasseUndPlatznummer.Rasse, GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).ID).Verteidigung'Wide_Wide_Image);
                     Put (Item => "    " & To_Wide_Wide_String (GlobaleVariablen.TexteEinlesenNeu (9, 26)));
                     Put_Line (Item => GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellerRang'Wide_Wide_Image & " /"
                               & EinheitenDatenbank.EinheitenListe (RasseUndPlatznummer.Rasse, GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).ID).MaximalerRang'Wide_Wide_Image);
                              
                  else
                     null;
                  end if;                           
                        
                  New_Line;
                  case GlobaleVariablen.FeindlicheInformationenSehen is
                     when False =>
                        null;
                                 
                     when True =>
                        Put_Line (Item => "Aktuelle Rasse: " & RasseUndPlatznummer.Rasse'Wide_Wide_Image);
                  end case;
            end case;
            
            RasseUndPlatznummer := SchleifenPruefungen.KoordinatenStadtOhneRasseSuchen (Koordinaten => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);

            case RasseUndPlatznummer.Platznummer is
               when SchleifenPruefungen.RückgabeWert =>
                  null;
                     
               when others => -- Stadtinformationsaufruf
                  if GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AchsenPosition = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition then
                     KarteStadt.Beschreibung (RasseExtern => RasseExtern);

                     -- Stadtverteidigungsinformation, nur sichtbar wenn eigene Stadt oder wenn Cheat aktiviert ist
                     if RasseUndPlatznummer.Rasse = RasseExtern or GlobaleVariablen.FeindlicheInformationenSehen = True then                              
                        Verteidigungsbonus := Verteidigungsbonus + VerbesserungenDatenbank.VerbesserungObjektListe (KartenVerbesserung (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse,
                                                                                                                    RasseUndPlatznummer.Platznummer).ID)).Verteidigungsbonus;

                     else
                        null;
                     end if;

                     case GlobaleVariablen.FeindlicheInformationenSehen is
                        when False =>
                           null;
                                 
                        when True =>
                           Put_Line (Item => "Aktuelle Rasse: " & RasseUndPlatznummer.Rasse'Wide_Wide_Image);
                     end case;
                     
                  else
                     null;
                  end if;
            end case;
                  
            -- Allgemeine Karteninformationen, nur sichtbar wenn das Kartenfeld aufgedackt ist
            if Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                              GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Hügel = True
              and Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                 GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund /= 6 then
               Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (6, 35)));
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Wissensgewinnung;
         
            elsif Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                 GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Hügel = True then
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Wissensgewinnung;
               
            else         
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Wissensgewinnung;
            end if;
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                              GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource /= 0 then
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource);

               Verteidigungsbonus
                 := Verteidigungsbonus + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource).Nahrungsgewinnung;
               Ressourcengewinnung
                 := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource).Wissensgewinnung;
         
            else
               null;
            end if;
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                              GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet /= 0 then
               VerbesserungenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet);

               Verteidigungsbonus
                 := Verteidigungsbonus + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                          GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                          GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet).Verteidigungsbonus;
               Nahrungsgewinnung
                 := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet).Nahrungsbonus;
               Ressourcengewinnung
                 := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet).Ressourcenbonus;
               Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                                 GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                                 GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet).Geldbonus;
               Wissensgewinnung
                 := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet).Wissensbonus;
         
            else
               null;
            end if;
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                              GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße /= 0 then
               VerbesserungenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße);

               Verteidigungsbonus
                 := Verteidigungsbonus + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                          GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                          GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße).Verteidigungsbonus;
               Nahrungsgewinnung
                 := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße).Nahrungsbonus;
               Ressourcengewinnung
                 := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße).Ressourcenbonus;
               Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                                 GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                                 GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße).Geldbonus;
               Wissensgewinnung
                 := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße).Wissensbonus;
               
            else
               null;
            end if;
      
            if Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                              GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss /= 0 then
               KartenDatenbank.Beschreibung (ID => Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                               GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss).Wissensgewinnung;
         
            else
               null;
            end if;
            
            New_Line;
            Put (Item => "       " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 19)));
            Put (Item => Verteidigungsbonus'Wide_Wide_Image);
            Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 20)));
            Put_Line (Item => Nahrungsgewinnung'Wide_Wide_Image);
            Put (Item => "       " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 21)));
            Put (Item => Ressourcengewinnung'Wide_Wide_Image);
            Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 22)));
            Put (Item => Geldgewinnung'Wide_Wide_Image);
            Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 23)));
            Put_Line (Item => Wissensgewinnung'Wide_Wide_Image);
            
         when False =>
            null;
      end case;

      New_Line;
      case GlobaleVariablen.FeindlicheInformationenSehen is -- Für Cheat
         when False =>
            null;
                                 
         when True =>
            Put (Item => "Aktuelle EPosition: " & GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse'Wide_Wide_Image);
            Put (Item => "    Aktuelle YPosition: " & GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse'Wide_Wide_Image);
            Put_Line (Item => "    Aktuelle XPosition: " & GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse'Wide_Wide_Image);
            Put (Item => "Kartenfeldbewertung: " & Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                 GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Felderwertung'Wide_Wide_Image);
            Put (Item => "    Aktuelle GrundID: " & Karten.Karten (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                 GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund'Wide_Wide_Image);
      end case;
      
   end Information; 
   
end Karte;
