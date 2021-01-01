package body InDerStadt is

   procedure InDerStadt (Rasse, StadtNummer : in Integer) is
   begin
      
      StadtSchleife:
      loop
    
         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         KarteStadt.AnzeigeStadt (StadtNummer => StadtNummer);
         New_Line;  

         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is
            when 'w' | 's' | 'a' | 'd' | '1' | '2' | '3' | '4' | '6' | '7' | '8' | '9' =>
               BewegungssystemCursor.BewegungCursorRichtung (Karte    => False,
                                                             Richtung => To_Lower (Item => Taste));

            when 'e' => -- Einwohner von Feld entfernen/zuweisen
               if GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.YAchse < Karten.Stadtkarte'First (1) + 7 and GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.XAchse > Karten.Stadtkarte'Last (2) - 7 then
                  RelativeCursorPositionY := GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.YAchse - 4;
                  RelativeCursorPositionX := Karten.Stadtkarte'First (2) + GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.XAchse - 18;
                  NutzbarerBereich := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).StadtUmgebungGröße;
                  if RelativeCursorPositionY < -NutzbarerBereich or RelativeCursorPositionY > NutzbarerBereich or RelativeCursorPositionX < -NutzbarerBereich or RelativeCursorPositionX > NutzbarerBereich then
                     null;
                  
                  elsif RelativeCursorPositionY = 0 and RelativeCursorPositionX = 0 then
                     null;
                  
                  else
                     case GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) is
                        when True =>
                           GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) := False;
                           GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ArbeitendeEinwohner := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ArbeitendeEinwohner - 1;
                        
                        when False =>
                           KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.YAchse,
                                                                             XKoordinate    => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.XAchse,
                                                                             YÄnderung      => RelativeCursorPositionY,
                                                                             XÄnderung      => RelativeCursorPositionX,
                                                                             ZusatzYAbstand => 0);
                           
                           case KartenWert.YAchse is
                              when GlobaleDatentypen.Kartenfeld'First =>
                                 null;
                                 
                              when others =>
                                 if GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ArbeitendeEinwohner < GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Einwohner then
                                    GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) := True;
                                    GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ArbeitendeEinwohner := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ArbeitendeEinwohner + 1;
                           
                                 else
                                    null;
                                 end if;
                           end case;
                     end case;
                  end if;

               else
                  null;
               end if;
                  
               
            when 'b' => -- Gebäude/Einheit bauen
               case GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuellesBauprojekt is
                  when 0 =>
                     Bauen.Bauen (Rasse       => Rasse,
                                  StadtNummer => StadtNummer);
                     
                  when others =>
                     Wahl := Auswahl.Auswahl (WelcheAuswahl => 14,
                                              WelcherText => 18);
                     case Wahl is
                        when -3 =>
                           Bauen.Bauen (Rasse       => Rasse,
                                        StadtNummer => StadtNummer);
                     
                        when others =>
                           null;
                     end case;
               end case;
               
            when 'v' => -- Gebäude verkaufen
               if GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.YAchse = 1 and GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.XAchse < 13 then
                  case GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, Stadtnummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.XAchse)) is
                     when '0' =>
                        null;
                        
                     when others =>
                        GlobaleVariablen.Wichtiges (Rasse).AktuelleGeldmenge
                          := GlobaleVariablen.Wichtiges (Rasse).AktuelleGeldmenge + Integer (GebaeudeDatenbank.GebäudeListe (GlobaleVariablen.Rasse, Integer (GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.XAchse)).PreisGeld / 2);
                        GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, Stadtnummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.XAchse)) := '0';
                  end case;
            
               elsif GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.YAchse = 2 and GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.XAchse < 13 then
                  case GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, Stadtnummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.XAchse) + 12) is
                     when '0' =>
                        null;
                        
                     when others =>
                        GlobaleVariablen.Wichtiges (Rasse).AktuelleGeldmenge
                          := GlobaleVariablen.Wichtiges (Rasse).AktuelleGeldmenge + Integer (GebaeudeDatenbank.GebäudeListe (GlobaleVariablen.Rasse, Integer (GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.XAchse) + 12).PreisGeld / 2);
                        GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, Stadtnummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel.AchsenPositionStadt.XAchse) + 12) := '0';
                  end case;
                  
               else
                  null;
               end if;

            when 'q' =>
               return;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
   end InDerStadt;
   
   
   
   function StadtBauen (Rasse, EinheitNummer : in Integer) return Boolean is
   begin

      BauMöglich := StadtBauenPrüfen (Rasse         => Rasse,
                                      EinheitNummer => EinheitNummer);      
        
      case BauMöglich is
         when True =>
            null;
                  
         when False =>
            if Rasse = GlobaleVariablen.Rasse then
               Anzeige.Fehlermeldungen (WelcheFehlermeldung => 6);
                  
            else
               null;
            end if;
            return False;
      end case;

      for StadtNummer in GlobaleVariablen.StadtGebaut'Range (2) loop
         
         if GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ID /= 0 then
            null;
            
         elsif StadtNummer = GlobaleVariablen.StadtGebaut'Last (2) and GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ID /= 0 and Rasse = GlobaleVariablen.Rasse then
            Anzeige.Fehlermeldungen (WelcheFehlermeldung => 7);
            
         else
            if StadtNummer = 1 and Rasse = GlobaleVariablen.Rasse then
               Stadtart := 1;
               
            elsif Rasse = GlobaleVariablen.Rasse then
               Stadtart := 2;
               
            elsif StadtNummer = 1 and Rasse /= GlobaleVariablen.Rasse then
               Stadtart := 3;
               
            else
               Stadtart := 4;
            end if;

            GlobaleVariablen.StadtGebaut (Rasse, StadtNummer) := 
              (Stadtart, (GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.YAchse,
               GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.XAchse), False, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => "Name"),
               (0 => (0 => True, others => False), 
                others => (others => False)), 1, 1);
               
            case GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.EAchse is
               when 0 | 1 =>
                  YAchsenSchleife:
                  for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     XAchsenSchleife:
                     for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  
                        KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.YAchse,
                                                                          XKoordinate    => GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.XAchse,
                                                                          YÄnderung      => YÄnderung,
                                                                          XÄnderung      => XÄnderung,
                                                                          ZusatzYAbstand => 0);
                     
                        case KartenWert.YAchse is
                           when GlobaleDatentypen.Kartenfeld'First =>
                              exit XAchsenSchleife;
                        
                           when others =>
                              case Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Grund is
                              when 2 | 29 .. 31 =>
                                 GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AmWasser := True;
                                 exit YAchsenSchleife;
                        
                              when others =>
                                 null;
                              end case;
                        end case;
                  
                     end loop XAchsenSchleife;
                  end loop YAchsenSchleife;
                  
               when others =>
                  null;
            end case;

            StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (Rasse       => Rasse,
                                                             StadtNummer => StadtNummer);
            StadtProduktionPrüfen (Rasse       => Rasse,
                                   StadtNummer => StadtNummer);
            ForschungsDatenbank.ForschungZeit (Rasse => Rasse);            
            
            if Rasse = GlobaleVariablen.Rasse then
               EinheitenDatenbank.EinheitEntfernen (Rasse         => Rasse,
                                                    EinheitNummer => EinheitNummer);
               GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Name := Eingabe.StadtName;
               
            else
               null;
            end if;
            return True;
         end if;
         
      end loop;
      
      return False;
      
   end StadtBauen;



   procedure StadtProduktionPrüfen (Rasse, StadtNummer : in Integer) is
   begin
      
      case Rasse is
         when 0 => -- Überprüfung für alle Rassen bei Runde beenden.
            RassenSchleife:
            for Rassen in GlobaleVariablen.StadtGebaut'Range (1) loop
               StadtSchleife:
               for Stadt in GlobaleVariablen.StadtGebaut'Range (2) loop
               
                  case GlobaleVariablen.StadtGebaut (Rassen, Stadt).ID is
                     when 0 =>
                        exit StadtSchleife;
                  
                     when others =>
                        StadtProduktionPrüfenBerechnung (Rasse       => Rassen,
                                                         StadtNummer => Stadt);             
                  end case;
               
               end loop StadtSchleife;
            end loop RassenSchleife;
         
         when others => -- Überprüfung beim Bauen einer Stadt
            StadtProduktionPrüfenBerechnung (Rasse       => Rasse,
                                             StadtNummer => StadtNummer);
            Wachstum.WachstumBeiStadtGründung (Rasse => Rasse);
      end case;
      
   end StadtProduktionPrüfen;
   


   procedure StadtProduktionPrüfenBerechnung (Rasse, StadtNummer : in Integer) is -- Legt erst eine Runde später die neuen Werte fest, prüfen warum.
   begin
      
      GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsproduktion := 0;
      GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleProduktionrate := 0;
      GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleGeldgewinnung := 0;
      GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleForschungsrate := 0;

      NutzbarerBereich := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).StadtUmgebungGröße;
      
      YAchseSchleife:
      for YÄnderung in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XÄnderung in -NutzbarerBereich .. NutzbarerBereich loop

            KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.YAchse,
                                                              XKoordinate    => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.XAchse,
                                                              YÄnderung      => YÄnderung,
                                                              XÄnderung      => XÄnderung,
                                                              ZusatzYAbstand => 0);

            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;                                 
                                 
               when others =>
                  case GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).UmgebungBewirtschaftung (YÄnderung, XÄnderung) is
                     when True =>
                        GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsproduktion
                          := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleNahrungsproduktion
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Nahrungsgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Ressource).Nahrungsgewinnung
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Nahrungsbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Nahrungsbonus;

                        GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleProduktionrate
                          := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleProduktionrate
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Ressourcengewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Ressourcengewinnung
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Ressourcenbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Ressourcenbonus;

                        GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleGeldgewinnung
                          := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleGeldgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Geldgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Geldgewinnung
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Geldbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Geldbonus;

                        GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleForschungsrate
                          := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AktuelleForschungsrate
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Wissensgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Wissensgewinnung
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Wissensbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Wissensbonus;

                     when others =>
                        null;
                  end case;
            end case;
                           
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end StadtProduktionPrüfenBerechnung;
   


   function StadtBauenPrüfen (Rasse, EinheitNummer : in Integer) return Boolean is
   begin
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.YAchse,
                                                              XKoordinate    => GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.XAchse,
                                                              YÄnderung      => YÄnderung,
                                                              XÄnderung      => XÄnderung,
                                                              ZusatzYAbstand => 0);
                     
            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  case Karten.Karten (GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund is
                     when 0 =>
                        null;
                        
                     when others =>
                        return False;
                  end case;
            end case;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      return True;
      
   end StadtBauenPrüfen;
   
   
   
   procedure BelegteStadtfelderFreigeben (Rasse, StadtNummer : in Integer) is
   begin
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.YAchse,
                                                              XKoordinate    => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.XAchse,
                                                              YÄnderung      => YÄnderung,
                                                              XÄnderung      => XÄnderung,
                                                              ZusatzYAbstand => 0);
            
            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  if Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                    = GlobaleDatentypen.BelegterGrund (Rasse) * StadtWerteFestlegen.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtNummer) then
                        Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;
                        
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BelegteStadtfelderFreigeben;

end InDerStadt;
