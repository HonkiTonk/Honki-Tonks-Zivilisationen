package body KarteStadt is

   procedure AnzeigeStadt (StadtNummer, RasseExtern : in Integer) is
   begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      Stadtumgebungsgröße := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße;

      YAchsenabstraktion := -Stadtumgebungsgröße;
      CursorYAchsePlus := -10;
      CursorXAchsePlus := -10;
      
      YAchseSchleife:
      for Y in Karten.Stadtkarte'Range (1) loop
         XAchseSchleife:
         for X in Karten.Stadtkarte'Range (2) loop
                        
            if Y < Karten.Stadtkarte'First (1) + 7 and X > Karten.Stadtkarte'Last (2) - 7 then               
               if YAchsenabstraktion > Stadtumgebungsgröße then
                  for A in 0 .. 6 loop
                     
                     if Y = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse and X + GlobaleDatentypen.Kartenfeld (A) = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse then
                        Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel (RasseExtern).CursorGrafik & CSI & "0m");

                     else
                        Put (Item => " ");
                     end if;
                     
                  end loop;
                  
                  New_Line;
                  exit XAchseSchleife;

               elsif Stadtumgebungsgröße = 1 and Y < 3 then
                  for A in 0 .. 6 loop                  
                                          
                     if Y = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse and X + GlobaleDatentypen.Kartenfeld (A) = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse then
                        Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel (RasseExtern).CursorGrafik & CSI & "0m");

                     else
                        Put (Item => " ");
                     end if;
                     
                  end loop;
                  
                  New_Line;
                  exit XAchseSchleife;

               elsif Stadtumgebungsgröße = 2 and Y < 2 then
                  for A in 0 .. 6 loop               
                                          
                     if Y = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse and X + GlobaleDatentypen.Kartenfeld (A) = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse then
                        Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel (RasseExtern).CursorGrafik & CSI & "0m");

                     else                                            
                        Put (Item => " ");
                     end if;
                     
                  end loop;
                  
                  New_Line;
                  exit XAchseSchleife;
                  
               else
                  UmgebungsSchleife:
                  for A in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop

                     Cursor := CursorKonstant + A;
                     if Y = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse and X + Cursor = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse then
                        Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel (RasseExtern).CursorGrafik & CSI & "0m");
                        CursorYAchsePlus := Y - 4;

                        if A < -Stadtumgebungsgröße or A > Stadtumgebungsgröße then
                           null;
                           
                        else
                           CursorXAchsePlus := A;
                        end if;
                           
                     elsif A < -Stadtumgebungsgröße then
                        Put (Item => " ");
                           
                     elsif A > Stadtumgebungsgröße then
                        Put (Item => " ");

                     else
                        KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                          XKoordinate    => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse,
                                                                          YÄnderung      => YAchsenabstraktion,
                                                                          XÄnderung      => A,
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
               
            elsif Y = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse and X = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse then
               Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel (RasseExtern).CursorGrafik & CSI & "0m");

            elsif Y < Karten.Stadtkarte'First (1) + 7 and X = Karten.Stadtkarte'Last (2) - 7 then
               Put (Item => " ");

            elsif Y = Karten.Stadtkarte'First (1) + 7 and X >= Karten.Stadtkarte'Last (2) - 7 then
               Put (Item => " ");

            elsif Y = 1 and X < 13 then
               if GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).GebäudeVorhanden (Integer (X)) /= '0' then
                  Put (Item => GebaeudeDatenbank.GebäudeListe (RasseExtern, Integer (X)).Anzeige);

               else
                  Sichtbarkeit.Farben (Einheit      => 0,
                                       Verbesserung => 0,
                                       Ressource    => 0,
                                       Grund        => Karten.Karten (0, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund,
                                       Cursor       => False,
                                       RasseExtern  => RasseExtern,
                                       RasseIntern  => 0);
               end if;

            elsif Y = 2 and X < 13 then
               if GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).GebäudeVorhanden (Integer (X) + 12) /= '0' then
                  Put (Item => GebaeudeDatenbank.GebäudeListe (RasseExtern, Integer (X) + 12).Anzeige);

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

            case X is
               when Karten.Stadtkarte'Last (2) =>
                  New_Line;
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      Beschreibung (RasseExtern => RasseExtern,
                    StadtNummer => Stadtnummer);
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
   
   
   
   procedure InformationenStadt (YAufschlag, XAufschlag : in GlobaleDatentypen.Kartenfeld; RasseExtern : Integer) is
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
            Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (9, 34)));
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
         Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 20)));
         Put_Line (Item => Nahrungsgewinnung'Wide_Wide_Image);
         Put (Item => "       " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 21)));
         Put (Item => Ressourcengewinnung'Wide_Wide_Image);
         Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 22)));
         Put (Item => Geldgewinnung'Wide_Wide_Image);
         Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 23)));
         Put_Line (Item => Wissensgewinnung'Wide_Wide_Image);
      end if;
      
   end InformationenStadt;



   procedure Beschreibung (RasseExtern, StadtNummer : in Integer) is
   begin
      
      Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ID)));
      Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Name) & "    ");
      Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 5)));
      Put_Line (Item => GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Einwohner'Wide_Wide_Image);

      RassenSchleife:
      for RasseIntern in GlobaleVariablen.StadtGebaut'Range (1) loop
         StadtSchleife:
         for StadtNummerIntern in GlobaleVariablen.StadtGebaut'Range (2) loop
         
            case GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummerIntern).ID is
               when 0 =>
                  exit StadtSchleife;
                  
               when others =>
                  if GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummerIntern).AchsenPosition.EAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse
                    and GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummerIntern).AchsenPosition.YAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse
                    and GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummerIntern).AchsenPosition.XAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse then                        
                     if RasseIntern = RasseExtern or GlobaleVariablen.FeindlicheInformationenSehen = True then
                        Put (Item => "       " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 6)));
                        Put (Item => GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleNahrungsmittel'Wide_Wide_Image);
                        Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 7)));
                        Put_Line (Item => GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleNahrungsproduktion'Wide_Wide_Image);
                        
                        Put (Item => "       " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 8)));
                        Put (Item => GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleProduktionrate'Wide_Wide_Image);
                        Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 9)));
                        Put_Line (Item => GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleGeldgewinnung'Wide_Wide_Image);

                        Put (Item => "       " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 10)));
                        Put (Item => GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleForschungsrate'Wide_Wide_Image);                        
                        Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 11)));
                        Put_Line (Item => GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Korruption'Wide_Wide_Image);
                        
                        Put (Item => "       " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 12)));
                        case GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuellesBauprojekt is
                           when 0 =>
                              Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 28)));
            
                           when 1 .. 9_999 => -- Gebäude
                              Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (14, GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuellesBauprojekt - 1_000)));

                           when others => -- Einheiten
                              Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (10, GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuellesBauprojekt - 10_000)));
                        end case;
                                              
                        Put (Item => "    " & To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 13)));   
                        Put_Line (Item => GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).VerbleibendeBauzeit'Wide_Wide_Image);

                     else
                        null;
                     end if;
                  end if;
            end case;
            
         end loop StadtSchleife;
      end loop RassenSchleife;
                     
      New_Line;
      
   end Beschreibung;

end KarteStadt;
