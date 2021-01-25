package body KarteStadt is

   procedure AnzeigeStadt (StadtNummer : in Positive; RasseExtern : in GlobaleDatentypen.Rassen) is
   begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      Stadtumgebungsgröße := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße;

      YAchsenabstraktion := -Stadtumgebungsgröße;
      CursorYAchsePlus := -10;
      CursorXAchsePlus := -10;
      
      YAchseSchleife:
      for YAchse in Karten.Stadtkarte'Range (1) loop
         XAchseSchleife:
         for XAchse in Karten.Stadtkarte'Range (2) loop
                        
            if YAchse < Karten.Stadtkarte'First (1) + 7 and XAchse > Karten.Stadtkarte'Last (2) - 7 then               
               if YAchsenabstraktion > Stadtumgebungsgröße then
                  for Umgebung in 0 .. 6 loop
                     
                     if YAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse
                       and XAchse + GlobaleDatentypen.Kartenfeld (Umgebung) = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse then
                        Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel (RasseExtern).CursorGrafik & CSI & "0m");

                     else
                        Put (Item => " ");
                     end if;
                     
                  end loop;
                  
                  New_Line;
                  exit XAchseSchleife;

               elsif Stadtumgebungsgröße = 1 and YAchse < 3 then
                  for Umgebung in 0 .. 6 loop                  
                                          
                     if YAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse
                       and XAchse + GlobaleDatentypen.Kartenfeld (Umgebung) = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse then
                        Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel (RasseExtern).CursorGrafik & CSI & "0m");

                     else
                        Put (Item => " ");
                     end if;
                     
                  end loop;
                  
                  New_Line;
                  exit XAchseSchleife;

               elsif Stadtumgebungsgröße = 2 and YAchse < 2 then
                  for Umgebung in 0 .. 6 loop               
                                          
                     if YAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse
                       and XAchse + GlobaleDatentypen.Kartenfeld (Umgebung) = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse then
                        Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel (RasseExtern).CursorGrafik & CSI & "0m");

                     else                                            
                        Put (Item => " ");
                     end if;
                     
                  end loop;
                  
                  New_Line;
                  exit XAchseSchleife;
                  
               else
                  UmgebungsSchleife:
                  for Umgebung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop

                     Cursor := CursorKonstant + Umgebung;
                     if YAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse and XAchse + Cursor = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse then
                        Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel (RasseExtern).CursorGrafik & CSI & "0m");
                        CursorYAchsePlus := YAchse - 4;

                        if Umgebung < -Stadtumgebungsgröße or Umgebung > Stadtumgebungsgröße then
                           null;
                           
                        else
                           CursorXAchsePlus := Umgebung;
                        end if;
                           
                     elsif Umgebung < -Stadtumgebungsgröße then
                        Put (Item => " ");
                           
                     elsif Umgebung > Stadtumgebungsgröße then
                        Put (Item => " ");

                     else
                        KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                          XKoordinate    => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse,
                                                                          YÄnderung      => YAchsenabstraktion,
                                                                          XÄnderung      => Umgebung,
                                                                          ZusatzYAbstand => 0);

                        case KartenWert.YAchse is
                           when GlobaleDatentypen.Kartenfeld'First =>
                              Put (Item => " ");

                           when others =>
                              Sichtbarkeit.Sichtbarkeit (InDerStadt  => True,
                                                         EAchse      => 0,
                                                         YAchse      => KartenWert.YAchse,
                                                         XAchse      => KartenWert.XAchse,
                                                         RasseExtern => RasseExtern);
                        end case;
                     end if;

                  end loop UmgebungsSchleife;

                  New_Line;
                  YAchsenabstraktion := YAchsenabstraktion + 1;
                  exit XAchseSchleife;
               end if;
               
            elsif YAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse and XAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse then
               Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel (RasseExtern).CursorGrafik & CSI & "0m");

            elsif YAchse < Karten.Stadtkarte'First (1) + 7 and XAchse = Karten.Stadtkarte'Last (2) - 7 then
               Put (Item => " ");

            elsif YAchse = Karten.Stadtkarte'First (1) + 7 and XAchse >= Karten.Stadtkarte'Last (2) - 7 then
               Put (Item => " ");

            elsif YAchse = 1 and XAchse < 13 then
               if GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).GebäudeVorhanden (Integer (XAchse)) /= '0' then
                  Put (Item => GebaeudeDatenbank.GebäudeListe (RasseExtern, Integer (XAchse)).Anzeige);

               else
                  Sichtbarkeit.Farben (Einheit      => 0,
                                       Verbesserung => 0,
                                       Ressource    => 0,
                                       Grund        => Karten.Karten (0, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund,
                                       Cursor       => False,
                                       RasseExtern  => RasseExtern,
                                       RasseIntern  => 0);
               end if;

            elsif YAchse = 2 and XAchse < 13 then
               if GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).GebäudeVorhanden (Integer (XAchse) + 12) /= '0' then
                  Put (Item => GebaeudeDatenbank.GebäudeListe (RasseExtern, Integer (XAchse) + 12).Anzeige);

               else
                  Sichtbarkeit.Farben (Einheit      => 0,
                                       Verbesserung => 0,
                                       Ressource    => 0,
                                       Grund        => Karten.Karten (0, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund,
                                       Cursor       => False,
                                       RasseExtern  => RasseExtern,
                                       RasseIntern  => 0);
               end if;

            else
               Sichtbarkeit.Farben (Einheit      => 0,
                                    Verbesserung => 0,
                                    Ressource    => 0,
                                    Grund        => Karten.Karten (0, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund,
                                    Cursor       => False,
                                    RasseExtern  => RasseExtern,
                                    RasseIntern  => 0);
            end if;

            case XAchse is
               when Karten.Stadtkarte'Last (2) =>
                  New_Line;
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      Beschreibung (RasseExtern => RasseExtern);
      InformationenStadt (YAufschlag  => CursorYAchsePlus,
                          XAufschlag  => CursorXAchsePlus,
                          RasseExtern => RasseExtern);
      if GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse = 1 and GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse < 13 then
         if GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse)) /= '0' then
            GebaeudeDatenbank.Beschreibung (ID => Integer (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse));
            
         else
            null;
         end if;

      elsif GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse = 2 and GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse < 13 then
         if GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse) + 12) /= '0' then
            GebaeudeDatenbank.Beschreibung (ID => Integer (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse) + 12);
            
         else
            null;
         end if;
        
      else
         null;
      end if;

      New_Line;
      
   end AnzeigeStadt;
   


   procedure FarbenStadt is
   begin
      
      null;
      
   end FarbenStadt;
   
   
   
   procedure InformationenStadt (YAufschlag, XAufschlag : in GlobaleDatentypen.Kartenfeld; RasseExtern : GlobaleDatentypen.Rassen) is
   begin      
      
      Nahrungsgewinnung := 0;
      Ressourcengewinnung := 0;
      Geldgewinnung := 0;
      Wissensgewinnung := 0;

      KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                        XKoordinate    => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse,
                                                        YÄnderung      => YAufschlag,
                                                        XÄnderung      => XAufschlag,
                                                        ZusatzYAbstand => 0);

      case KartenWert.YAchse is
         when GlobaleDatentypen.Kartenfeld'First =>
            YAchse := -10;
         
         when others =>
            YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse + YAufschlag;
      end case;

      if XAufschlag = -10 then
         XAchse := XAufschlag;

      else         
         XAchse := KartenWert.XAchse;
      end if;
      
      if YAchse = -10 or XAchse = -10 then
         null;
         
      else
         if Karten.Karten (0, YAchse, XAchse).Hügel = True and Karten.Karten (0, YAchse, XAchse).Grund /= 6 then
            Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 34)));
            KartenDatenbank.Beschreibung (ID => Karten.Karten (0, YAchse, XAchse).Grund);

            Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Grund).Nahrungsgewinnung;
            Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Grund).Ressourcengewinnung;
            Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Grund).Geldgewinnung;
            Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Grund).Wissensgewinnung;
         
         elsif Karten.Karten (0, YAchse, XAchse).Hügel = True then
            KartenDatenbank.Beschreibung (ID => Karten.Karten (0, YAchse, XAchse).Grund);

            Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Grund).Nahrungsgewinnung;
            Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Grund).Ressourcengewinnung;
            Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Grund).Geldgewinnung;
            Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Grund).Wissensgewinnung;
               
         else         
            KartenDatenbank.Beschreibung (ID => Karten.Karten (0, YAchse, XAchse).Grund);

            Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Grund).Nahrungsgewinnung;
            Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Grund).Ressourcengewinnung;
            Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Grund).Geldgewinnung;
            Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Grund).Wissensgewinnung;
         end if;
      
         if Karten.Karten (0, YAchse, XAchse).Ressource /= 0 then
            KartenDatenbank.Beschreibung (ID => Karten.Karten (0, YAchse, XAchse).Ressource);

            Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Ressource).Nahrungsgewinnung;
            Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Ressource).Ressourcengewinnung;
            Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Ressource).Geldgewinnung;
            Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Ressource).Wissensgewinnung;
         
         else
            null;
         end if;
      
         if Karten.Karten (0, YAchse, XAchse).VerbesserungGebiet /= 0 then
            VerbesserungenDatenbank.Beschreibung (ID => Karten.Karten (0, YAchse, XAchse).VerbesserungGebiet);

            Nahrungsgewinnung := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (0, YAchse, XAchse).VerbesserungGebiet).Nahrungsbonus;
            Ressourcengewinnung := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (0, YAchse, XAchse).VerbesserungGebiet).Ressourcenbonus;
            Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (0, YAchse, XAchse).VerbesserungGebiet).Geldbonus;
            Wissensgewinnung := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (0, YAchse, XAchse).VerbesserungGebiet).Wissensbonus;
         
         else
            null;
         end if;
      
         if Karten.Karten (0, YAchse, XAchse).VerbesserungStraße /= 0 then
            VerbesserungenDatenbank.Beschreibung (ID => Karten.Karten (0, YAchse, XAchse).VerbesserungStraße);

            Nahrungsgewinnung := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (0, YAchse, XAchse).VerbesserungStraße).Nahrungsbonus;
            Ressourcengewinnung := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (0, YAchse, XAchse).VerbesserungStraße).Ressourcenbonus;
            Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (0, YAchse, XAchse).VerbesserungStraße).Geldbonus;
            Wissensgewinnung := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (0, YAchse, XAchse).VerbesserungStraße).Wissensbonus;
         
         else
            null;
         end if;
      
         if Karten.Karten (0, YAchse, XAchse).Fluss /= 0 then
            KartenDatenbank.Beschreibung (ID => Karten.Karten (0, YAchse, XAchse).Fluss);

            Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Fluss).Nahrungsgewinnung;
            Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Fluss).Ressourcengewinnung;
            Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Fluss).Geldgewinnung;
            Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (0, YAchse, XAchse).Fluss).Wissensgewinnung;
         
         else
            null;
         end if;
            
         New_Line;
         Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 20)));
         Put_Line (Item => Nahrungsgewinnung'Wide_Wide_Image);
         Put (Item => "       " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 21)));
         Put (Item => Ressourcengewinnung'Wide_Wide_Image);
         Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 22)));
         Put (Item => Geldgewinnung'Wide_Wide_Image);
         Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 23)));
         Put_Line (Item => Wissensgewinnung'Wide_Wide_Image);
      end if;
      
   end InformationenStadt;



   procedure Beschreibung (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin

      RasseUndPlatznummer := SchleifenPruefungen.KoordinatenStadtOhneRasseSuchen (YAchse => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                  XAchse => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse);

      case RasseUndPlatznummer.Platznummer is
         when SchleifenPruefungen.RückgabeWert =>
            null; -- Sollte nie eintreten, da entweder aus der Stadt aufgerufen oder nur wenn die Kartenprüfung bereits eine Stadt gefunden hat
      
         when others =>
            -- Allgemeine Stadtinformationen, nur sichtbar wenn das Kartenfeld aufgedackt ist und sich dort eine Stadt befindet
            Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).ID)));
            Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).Name) & "    ");
            Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 5)));
            Put_Line (Item => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).Einwohner'Wide_Wide_Image);

            -- "Volle" Stadtinformationen, nur sichtbar wenn eigene Stadt oder wenn Cheat aktiviert ist                      
            if RasseUndPlatznummer.Rasse = RasseExtern or GlobaleVariablen.FeindlicheInformationenSehen = True then
               Put (Item => "       " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 6)));
               Put (Item => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleNahrungsmittel'Wide_Wide_Image);
               Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 7)));
               Put_Line (Item => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleNahrungsproduktion'Wide_Wide_Image);
                        
               Put (Item => "       " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 8)));
               Put (Item => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleProduktionrate'Wide_Wide_Image);
               Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 9)));
               Put_Line (Item => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleGeldgewinnung'Wide_Wide_Image);

               Put (Item => "       " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 10)));
               Put (Item => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleForschungsrate'Wide_Wide_Image);                        
               Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 11)));
               Put_Line (Item => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).Korruption'Wide_Wide_Image);
                        
               Put (Item => "       " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 12)));
               case GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellesBauprojekt is
                  when 0 => -- Nichts
                     Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 28)));
            
                  when 1 .. 9_999 => -- Gebäude
                     Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                         AktuelleAuswahl    => 0,
                                         FrageDatei         => 0,
                                         FrageZeile         => 0,
                                         TextDatei          => 8,
                                         ErsteZeile         => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellesBauprojekt - 1_000 + 77,
                                         LetzteZeile        => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellesBauprojekt - 1_000 + 77);

                  when others => -- Einheiten
                     Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                         AktuelleAuswahl    => 0,
                                         FrageDatei         => 0,
                                         FrageZeile         => 0,
                                         TextDatei          => 8,
                                         ErsteZeile         => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellesBauprojekt - 10_000 + 43,
                                         LetzteZeile        => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellesBauprojekt - 10_000 + 43);
               end case;
                                              
               Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesenNeu (9, 13)));   
               Put_Line (Item => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).VerbleibendeBauzeit'Wide_Wide_Image);

            else
               null;
            end if;
      end case;
      
      New_Line;
      
   end Beschreibung;

end KarteStadt;
