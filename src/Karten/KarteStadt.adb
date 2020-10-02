package body KarteStadt is

   procedure AnzeigeStadt (StadtNummer : in Integer) is
   begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      Stadtumgebungsgröße := StadtWerteFestlegen.StadtumgebungsgrößeFestlegen (Rasse       => GlobaleVariablen.Rasse,
                                                                                   StadtNummer => StadtNummer);

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
                     
                     if Y = GlobaleVariablen.CursorImSpiel.YAchseStadt and X + A = GlobaleVariablen.CursorImSpiel.XAchseStadt then
                        Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel.CursorGrafik & CSI & "0m");

                     else
                        Put (Item => " ");
                     end if;
                     
                  end loop;
                  
                  New_Line;
                  exit XAchseSchleife;

               elsif Stadtumgebungsgröße = 1 and Y < 3 then
                  for A in 0 .. 6 loop                  
                                          
                     if Y = GlobaleVariablen.CursorImSpiel.YAchseStadt and X + A = GlobaleVariablen.CursorImSpiel.XAchseStadt then
                        Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel.CursorGrafik & CSI & "0m");

                     else
                        Put (Item => " ");
                     end if;
                     
                  end loop;
                  
                  New_Line;
                  exit XAchseSchleife;

               elsif Stadtumgebungsgröße = 2 and Y < 2 then
                  for A in 0 .. 6 loop               
                                          
                     if Y = GlobaleVariablen.CursorImSpiel.YAchseStadt and X + A = GlobaleVariablen.CursorImSpiel.XAchseStadt then
                        Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel.CursorGrafik & CSI & "0m");

                     else                                            
                        Put (Item => " ");
                     end if;
                     
                  end loop;
                  
                  New_Line;
                  exit XAchseSchleife;
                  
               else
                  UmgebungsSchleife:
                  for A in -3 .. 3 loop

                     Cursor := CursorKonstant + A;
                     if Y = GlobaleVariablen.CursorImSpiel.YAchseStadt and X + Cursor = GlobaleVariablen.CursorImSpiel.XAchseStadt then
                        Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel.CursorGrafik & CSI & "0m");
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
                        KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.CursorImSpiel.YAchse,
                                                                          XKoordinate    => GlobaleVariablen.CursorImSpiel.XAchse,
                                                                          YÄnderung      => YAchsenabstraktion,
                                                                          XÄnderung      => A,
                                                                          ZusatzYAbstand => 0);

                        case KartenWert.YWert is
                           when -1_000_000 =>
                              Put (Item => " ");

                           when others =>
                              Sichtbarkeit.Sichtbarkeit (YAchse => KartenWert.YWert,
                                                         XAchse => KartenWert.XWert);
                        end case;
                     end if;

                  end loop UmgebungsSchleife;

                  New_Line;
                  YAchsenabstraktion := YAchsenabstraktion + 1;
                  exit XAchseSchleife;
               end if;
               
            elsif Y = GlobaleVariablen.CursorImSpiel.YAchseStadt and X = GlobaleVariablen.CursorImSpiel.XAchseStadt then
               Put (Item => CSI & "5m" & GlobaleVariablen.CursorImSpiel.CursorGrafik & CSI & "0m");

            elsif Y < Karten.Stadtkarte'First (1) + 7 and X = Karten.Stadtkarte'Last (2) - 7 then
               Put (Item => " ");

            elsif Y = Karten.Stadtkarte'First (1) + 7 and X >= Karten.Stadtkarte'Last (2) - 7 then
               Put (Item => " ");

            elsif Y = 1 and X < 13 then
               if GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, Stadtnummer).GebäudeVorhanden (X) /= '0' then
                  Put (Item => GebaeudeDatenbank.GebäudeListe (X).Anzeige);

               else
                  Sichtbarkeit.Farben (Einheit      => 0,
                                       Verbesserung => 0,
                                       Ressource    => 0,
                                       Grund        => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund);
               end if;

            elsif Y = 2 and X < 13 then
               if GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, Stadtnummer).GebäudeVorhanden (X + 12) /= '0' then
                  Put (Item => GebaeudeDatenbank.GebäudeListe (X + 12).Anzeige);

               else
                  Sichtbarkeit.Farben (Einheit      => 0,
                                       Verbesserung => 0,
                                       Ressource    => 0,
                                       Grund        => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund);
               end if;

            else
               Sichtbarkeit.Farben (Einheit      => 0,
                                    Verbesserung => 0,
                                    Ressource    => 0,
                                    Grund        => Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund);
            end if;

            case X is
               when Karten.Stadtkarte'Last (2) =>
                  New_Line;
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      Beschreibung (Rasse       => GlobaleVariablen.Rasse,
                    StadtNummer => Stadtnummer);
      InformationenStadt (YAufschlag => CursorYAchsePlus,
                          XAufschlag => CursorXAchsePlus);
      if GlobaleVariablen.CursorImSpiel.YAchseStadt = 1 and GlobaleVariablen.CursorImSpiel.XAchseStadt < 13 then
         if GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, Stadtnummer).GebäudeVorhanden (GlobaleVariablen.CursorImSpiel.XAchseStadt) /= '0' then
            GebaeudeDatenbank.Beschreibung (ID => GlobaleVariablen.CursorImSpiel.XAchseStadt);
            
         else
            null;
         end if;

      elsif GlobaleVariablen.CursorImSpiel.YAchseStadt = 2 and GlobaleVariablen.CursorImSpiel.XAchseStadt < 13 then
         if GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, Stadtnummer).GebäudeVorhanden (GlobaleVariablen.CursorImSpiel.XAchseStadt + 12) /= '0' then
            GebaeudeDatenbank.Beschreibung (ID => GlobaleVariablen.CursorImSpiel.XAchseStadt + 12);
            
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
   
   
   
   procedure InformationenStadt (YAufschlag, XAufschlag : in Integer) is
   begin      
      
      Nahrungsgewinnung := 0;
      Ressourcengewinnung := 0;
      Geldgewinnung := 0;
      Wissensgewinnung := 0;

      KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.CursorImSpiel.YAchse,
                                                        XKoordinate    => GlobaleVariablen.CursorImSpiel.XAchse,
                                                        YÄnderung      => YAufschlag,
                                                        XÄnderung      => XAufschlag,
                                                        ZusatzYAbstand => 0);

      case KartenWert.YWert is
         when -1_000_000 =>
            YAchse := -10;
         
         when others =>
            YAchse := GlobaleVariablen.CursorImSpiel.YAchse + YAufschlag;
      end case;

      if XAufschlag = -10 then
         XAchse := XAufschlag;

      else         
         XAchse := KartenWert.XWert;
      end if;
      
      if YAchse = -10 or XAchse = -10 then
         null;
         
      else
         if Karten.Karten (YAchse, XAchse).Hügel = True and Karten.Karten (YAchse, XAchse).Grund /= 6 then
            Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (9, 34)));
            KartenDatenbank.Beschreibung (ID => Karten.Karten (YAchse, XAchse).Grund);

            Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Nahrungsgewinnung;
            Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Ressourcengewinnung;
            Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Geldgewinnung;
            Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Wissensgewinnung;
         
         elsif Karten.Karten (YAchse, XAchse).Hügel = True then
            KartenDatenbank.Beschreibung (ID => Karten.Karten (YAchse, XAchse).Grund);

            Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Nahrungsgewinnung;
            Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Ressourcengewinnung;
            Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Geldgewinnung;
            Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Wissensgewinnung;
               
         else         
            KartenDatenbank.Beschreibung (ID => Karten.Karten (YAchse, XAchse).Grund);

            Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Nahrungsgewinnung;
            Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Ressourcengewinnung;
            Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Geldgewinnung;
            Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Grund).Wissensgewinnung;
         end if;
      
         if Karten.Karten (YAchse, XAchse).Ressource /= 0 then
            KartenDatenbank.Beschreibung (ID => Karten.Karten (YAchse, XAchse).Ressource);

            Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Ressource).Nahrungsgewinnung;
            Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Ressource).Ressourcengewinnung;
            Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Ressource).Geldgewinnung;
            Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Ressource).Wissensgewinnung;
         
         else
            null;
         end if;
      
         if Karten.Karten (YAchse, XAchse).VerbesserungGebiet /= 0 then
            VerbesserungenDatenbank.Beschreibung (ID => Karten.Karten (YAchse, XAchse).VerbesserungGebiet);

            Nahrungsgewinnung := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungGebiet).Nahrungsbonus;
            Ressourcengewinnung := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungGebiet).Ressourcenbonus;
            Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungGebiet).Geldbonus;
            Wissensgewinnung := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungGebiet).Wissensbonus;
         
         else
            null;
         end if;
      
         if Karten.Karten (YAchse, XAchse).VerbesserungStraße /= 0 then
            VerbesserungenDatenbank.Beschreibung (ID => Karten.Karten (YAchse, XAchse).VerbesserungStraße);

            Nahrungsgewinnung := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungStraße).Nahrungsbonus;
            Ressourcengewinnung := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungStraße).Ressourcenbonus;
            Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungStraße).Geldbonus;
            Wissensgewinnung := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (YAchse, XAchse).VerbesserungStraße).Wissensbonus;
         
         else
            null;
         end if;
      
         if Karten.Karten (YAchse, XAchse).Fluss /= 0 then
            KartenDatenbank.Beschreibung (ID => Karten.Karten (YAchse, XAchse).Fluss);

            Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Fluss).Nahrungsgewinnung;
            Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Fluss).Ressourcengewinnung;
            Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Fluss).Geldgewinnung;
            Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenObjektListe (Karten.Karten (YAchse, XAchse).Fluss).Wissensgewinnung;
         
         else
            null;
         end if;
            
         New_Line;
         Put (Item => "    " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 20)));
         Put_Line (Item => Nahrungsgewinnung'Wide_Wide_Image);
         Put (Item => "       " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 21)));
         Put (Item => Ressourcengewinnung'Wide_Wide_Image);
         Put (Item => "    " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 22)));
         Put (Item => Geldgewinnung'Wide_Wide_Image);
         Put (Item => "    " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 23)));
         Put_Line (Item => Wissensgewinnung'Wide_Wide_Image);
      end if;
      
   end InformationenStadt;



   procedure Beschreibung (Rasse, StadtNummer : in Integer) is
   begin
      
      Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ID)));
      Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Name) & "    ");
      Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 5)));
      Put_Line (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Einwohner'Wide_Wide_Image);
                     
      if Rasse = GlobaleVariablen.Rasse then
         Put (Item => "       " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 6)));
         Put (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsmittel'Wide_Wide_Image);
         Put (Item => "    " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 7)));
         Put_Line (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsproduktion'Wide_Wide_Image);
                        
         Put (Item => "       " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 8)));
         Put (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleProduktionrate'Wide_Wide_Image);
         Put (Item => "    " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 9)));
         Put_Line (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleGeldgewinnung'Wide_Wide_Image);

         Put (Item => "       " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 10)));
         Put (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleForschungsrate'Wide_Wide_Image);                        
         Put (Item => "    " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 11)));
         Put_Line (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Korruption'Wide_Wide_Image);
                        
         Put (Item => "       " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 12)));
         case GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuellesBauprojekt is
            when 0 =>
               Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 28)));
            
            when 1 .. 9999 => -- Gebäude
               Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (14, GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuellesBauprojekt - 1_000)));

            when others => -- Einheiten
               Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (10, GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuellesBauprojekt - 10_000)));
         end case;
                                              
         Put (Item => "    " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 13)));   
         Put_Line (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).VerbleibendeBauzeit'Wide_Wide_Image);

      else
         null;
      end if;
                     
      New_Line;
      
   end Beschreibung;

end KarteStadt;
