package body SpielEinstellungen is

   function SpielEinstellungen return Integer is
   begin

      Wahl := 1;

      AuswahlSchleife:
      loop

         case Wahl is
            when 1 =>
               Wahl := KartengrößeWählen;

            when 2 =>
               Wahl := KartenartWählen;

            when 3 =>            
               Wahl := KartentemperaturWählen;
               
            when 4 =>
               Wahl := SpieleranzahlWählen;

            when 5 =>
               Wahl := RasseWählen;

            when 6 =>
               exit AuswahlSchleife;

            when 0 =>
               return 0;
               
            when -1 =>
               return -1;

            when others =>
               Put_Line (Item => "SpielEinstellungen.SpielEinstellungen, when others =>");
               return 0;
         end case;

      end loop AuswahlSchleife;

      KartenGenerator.KartenGenerator;
      StartwerteErmitteln;
         
      return ImSpiel.ImSpiel;
              
   end SpielEinstellungen;



   function KartengrößeWählen return Integer is
   begin

      KartengrößeGewählt := False;
      
      KartengrößenSchleife:
      while KartengrößeGewählt = False loop
         
         Wahl := Auswahl.Auswahl (WelcheAuswahl => 1, WelcherText => 2);
         
         case Wahl is
            when 1 .. 9 =>
               Karten.Kartengröße := Wahl;
               KartengrößeGewählt := True;
               
            when 10 =>
               ZufälligeKartengrößeWählen.Reset (ZufälligeKartenGrößeGewählt);
               Karten.Kartengröße := ZufälligeKartengrößeWählen.Random (ZufälligeKartengrößeGewählt);
               KartengrößeGewählt := True;
               
            when 0 =>
               return 0;
               
            when -1 =>
               return -1;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
                  
      end loop KartengrößenSchleife;

      return 2;
      
   end KartengrößeWählen;



   function KartenartWählen return Integer is
   begin
      
      KartenartGewählt := False;
      
      KartenartSchleife:
      while KartenartGewählt = False loop

         Wahl := Auswahl.Auswahl (WelcheAuswahl => 2, WelcherText => 3);
                  
         case Wahl is
            when 1 .. 3 =>
               KartenGenerator.Kartenart := Wahl;
               KartenartGewählt := True;
               
            when 6 =>
               ZufälligeKartenartWählen.Reset (ZufälligeKartenartGewählt);
               KartenGenerator.Kartenart := ZufälligeKartenartWählen.Random (ZufälligeKartenartGewählt);
               KartenartGewählt := True;
               
            when -2 =>
               return 1;
               
            when 0 =>
               return 0;
               
            when -1 =>
               return -1;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");                  

      end loop KartenartSchleife;

      return 3;
      
   end KartenartWählen;



   function KartentemperaturWählen return Integer is
   begin
      
      KartentemperaturGewählt := False;
      
      KartentemperaturSchleife:
      while KartentemperaturGewählt = False loop

         Wahl := Auswahl.Auswahl (WelcheAuswahl =>  3, WelcherText => 4);
                  
         case Wahl is
            when 1 .. 3 =>
               KartenGenerator.Kartentemperatur := Wahl;
               KartentemperaturGewählt := True;
               
            when 6 =>
               ZufälligeKartentemperaturWählen.Reset (ZufälligeKartentemperaturGewählt);
               KartenGenerator.Kartentemperatur := ZufälligeKartentemperaturWählen.Random (ZufälligeKartentemperaturGewählt);
               KartentemperaturGewählt := True;
               
            when -2 =>
               return 2;
               
            when 0 =>
               return 0;
               
            when -1 =>
               return -1;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
                  
      end loop KartentemperaturSchleife;

      return 4;
      
   end KartentemperaturWählen;



   function SpieleranzahlWählen return Integer is
   begin
      
      SpieleranzahlGewählt := False; -- 1 .. 18

      SpieleranzahlSchleife:
      while SpieleranzahlGewählt = False loop

         Wahl := Auswahl.Auswahl (WelcheAuswahl => 4, WelcherText => 5);
         
         case Wahl is
            when 1 .. 18 =>
               GlobaleVariablen.SpielerAnzahl := Wahl;
               SpieleranzahlGewählt := True;

            when 19 => 
               ZufälligeSpieleranzahlWählen.Reset (ZufälligeSpieleranzahlGewählt);
               GlobaleVariablen.SpielerAnzahl := ZufälligeSpieleranzahlWählen.Random (ZufälligeSpieleranzahlGewählt);
               SpieleranzahlGewählt := True;
               
            when -2 =>
               return 3;
               
            when 0 =>
               return 0;
               
            when -1 =>
               return -1;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpieleranzahlSchleife;

      return 5;
      
   end SpielerAnzahlWählen;


   
   function RasseWählen return Integer is
   begin

      RasseGewählt := False; -- 1 .. 18

      RasseSchleife:
      while RasseGewählt = False loop
         
         Wahl := Auswahl.Auswahl (WelcheAuswahl => 5, WelcherText => 6);

         case Wahl is
            when 1 .. 18 =>      
               Anzeige.AnzeigeLangerText (WelcherText => 7, WelcheZeile => Wahl);
               Wahl2 := Auswahl.Auswahl (WelcheAuswahl => 6, WelcherText => 18);
               case Wahl2 is
                  when -3 =>
                     GlobaleVariablen.Rasse := Wahl;
                     GlobaleVariablen.RassenImSpiel (GlobaleVariablen.Rasse) := 1;
                     RasseGewählt := True;
                     
                  when others =>
                     null;
               end case;

            when 19 =>
               ZufälligeRasseWählen.Reset (ZufälligeRasseGewählt);
               GlobaleVariablen.Rasse := ZufälligeRasseWählen.Random (ZufälligeRasseGewählt);
               GlobaleVariablen.RassenImSpiel (GlobaleVariablen.Rasse) := 1;
               RasseGewählt := True;
               
            when -2 =>
               return 4;
               
            when 0 =>
               return 0;
               
            when -1 =>
               return -1;
               
            when others =>
               null;
         end case;               

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop RasseSchleife;

      return 6;
      
   end RasseWählen;



   procedure StartwerteErmitteln is -- Ab hier nochmal ganz neu bauen
   begin      
      
      case GlobaleVariablen.SpielerAnzahl is
         when 1 =>
            null;
            
         when others =>
            RassenAusgewählt := 1;
            RassenWählen.Reset (RassenGewählt);

            RassenWählenSchleife:
            loop

               Rasse := RassenWählen.Random (RassenGewählt);
               
               if GlobaleVariablen.RassenImSpiel (Rasse) = 0 then
                  GlobaleVariablen.RassenImSpiel (Rasse) := 2;
                  RassenAusgewählt := RassenAusgewählt + 1;
                  
               else
                  null;
               end if;

               if RassenAusgewählt = GlobaleVariablen.SpielerAnzahl then
                  exit RassenWählenSchleife;
                     
               else
                  null;
               end if;
               
            end loop RassenWählenSchleife;
      end case;
      
      SpieleranzahlWerteFestlegen:
      for Rasse in GlobaleVariablen.RassenImSpiel'Range loop -- Noch eine Abstandsprüfung zu anderen Rassen einbauen? Auf jeden Fall noch einmal verbessern.
        
         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;
               
            when others =>
               StartwerteFestgelegt := False;
               WerteWählen.Reset (PositionGewählt);
         
               StartwerteFestlegenSchleife:
               while StartwerteFestgelegt = False loop

                  GlobaleVariablen.CursorImSpiel.YAchse := WerteWählen.Random (PositionGewählt);
                  GlobaleVariablen.CursorImSpiel.XAchse := WerteWählen.Random (PositionGewählt);
                  FelderDrumHerum := 0;
         
                  if Karten.Karten (0, GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund > 2
                    and Karten.Karten (0, GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund /= 31 then
                     PositionWert := SchleifenPruefungen.KoordinatenEinheitOhneRasseSuchen (YAchse => GlobaleVariablen.CursorImSpiel.YAchse,
                                                                                            XAchse => GlobaleVariablen.CursorImSpiel.XAchse);
                     case PositionWert.Rasse is
                        when SchleifenPruefungen.RückgabeWert =>                           
                           YAchseSchleife:
                           for YÄnderung in -1 .. 1 loop
                              XAchseSchleife:
                              for XÄnderung in -1 .. 1 loop

                                 KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.CursorImSpiel.YAchse,
                                                                                   XKoordinate    => GlobaleVariablen.CursorImSpiel.XAchse,
                                                                                   YÄnderung      => YÄnderung,
                                                                                   XÄnderung      => XÄnderung,
                                                                                   ZusatzYAbstand => 0);
                                 case KartenWert.YWert is
                                    when GlobaleDatentypen.Kartenfeld'First =>
                                       exit XAchseSchleife;
                  
                                    when others =>
                                       if YÄnderung = 0 and XÄnderung = 0 then
                                          null;
                                          
                                       elsif Karten.Karten (0, KartenWert.YWert, KartenWert.XWert).Grund > 2
                                         and Karten.Karten (0, KartenWert.YWert, KartenWert.XWert).Grund /= 31 then
                                          PlatzBelegt := SchleifenPruefungen.KoordinatenEinheitOhneRasseSuchen (YAchse => GlobaleVariablen.CursorImSpiel.YAchse + GlobaleDatentypen.Kartenfeld (YÄnderung),
                                                                                                                XAchse => GlobaleVariablen.CursorImSpiel.XAchse + GlobaleDatentypen.Kartenfeld (XÄnderung));
                                          if PlatzBelegt.Rasse = SchleifenPruefungen.RückgabeWert then
                                             FelderDrumHerum := FelderDrumHerum + 1;
                                             case FelderDrumHerum is
                                                when 2 =>
                                                   StartpunktFestlegen (Rasse => Rasse);
                                                   StartwerteFestgelegt := True;
                              
                                                when others =>
                                                   null;
                                             end case;
                                             
                                          else
                                             null;
                                          end if;
                                             
                                       else
                                          null;
                                       end if;
                                 end case;

                              end loop XAchseSchleife;
                           end loop YAchseSchleife;
                           
                        when others =>
                           null;
                     end case;

                  else
                     null;
                  end if;      
         
               end loop StartwerteFestlegenSchleife;
         end case;
      end loop SpieleranzahlWerteFestlegen;

      GlobaleVariablen.CursorImSpiel.YAchse := GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, 1).YAchse;
      GlobaleVariablen.CursorImSpiel.XAchse := GlobaleVariablen.EinheitenGebaut (GlobaleVariablen.Rasse, 1).XAchse;
      GlobaleVariablen.CursorImSpiel.YAchseAlt := GlobaleVariablen.CursorImSpiel.YAchse;
      GlobaleVariablen.CursorImSpiel.XAchseAlt := GlobaleVariablen.CursorImSpiel.XAchse;
      
   end StartwerteErmitteln;



   procedure StartpunktFestlegen (Rasse : in Integer) is
   begin

      GlobaleVariablen.EinheitenGebaut (Rasse, 1).ID := 1;
      GlobaleVariablen.EinheitenGebaut (Rasse, 1).YAchse := GlobaleVariablen.CursorImSpiel.YAchse;
      GlobaleVariablen.EinheitenGebaut (Rasse, 1).XAchse := GlobaleVariablen.CursorImSpiel.XAchse;
      EinheitenDatenbank.LebenspunkteBewegungspunkteAufMaximumSetzen (Rasse, 1);

      YAchseSchleife:
      for YÄnderung in -1 .. 1 loop
         XAchseSchleife:
         for XÄnderung in -1 .. 1 loop

            KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.CursorImSpiel.YAchse,
                                                              XKoordinate    => GlobaleVariablen.CursorImSpiel.XAchse,
                                                              YÄnderung      => YÄnderung,
                                                              XÄnderung      => XÄnderung,
                                                              ZusatzYAbstand => 0);
            case KartenWert.YWert is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  PositionWert := SchleifenPruefungen.KoordinatenEinheitOhneRasseSuchen (YAchse => GlobaleVariablen.CursorImSpiel.YAchse + GlobaleDatentypen.Kartenfeld (YÄnderung),
                                                                                         XAchse => GlobaleVariablen.CursorImSpiel.XAchse + GlobaleDatentypen.Kartenfeld (XÄnderung));
                  case PositionWert.Rasse is
                     when SchleifenPruefungen.RückgabeWert =>  
                        if YÄnderung = 0 and XÄnderung = 0 then
                           null;
               
                        elsif Karten.Karten (0, KartenWert.YWert, KartenWert.XWert).Grund > 2 and Karten.Karten (0, KartenWert.YWert, KartenWert.XWert).Grund /= 31 then
                           GlobaleVariablen.EinheitenGebaut (Rasse, 2).ID := 2;
                           GlobaleVariablen.EinheitenGebaut (Rasse, 2).YAchse := KartenWert.YWert;
                           GlobaleVariablen.EinheitenGebaut (Rasse, 2).XAchse := KartenWert.XWert;
                           EinheitenDatenbank.LebenspunkteBewegungspunkteAufMaximumSetzen (Rasse => Rasse, EinheitNummer => 2);
                     
                        else
                           null;
                        end if;
                        
                     when others =>
                        null;
                  end case;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;   
      
   end StartpunktFestlegen;

end SpielEinstellungen;
