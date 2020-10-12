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
                     RasseGewählt := True;
                     
                  when others =>
                     null;
               end case;

            when 19 =>
               ZufälligeRasseWählen.Reset (ZufälligeRasseGewählt);
               GlobaleVariablen.Rasse := ZufälligeRasseWählen.Random (ZufälligeRasseGewählt);
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
      
      RassenWählen.Reset (RassenGewählt);
      
      SpieleranzahlWerteFestlegen:
      for A in GlobaleVariablen.RassenImSpiel'Range loop

         if A = GlobaleVariablen.Rasse then
            GlobaleVariablen.RassenImSpiel (A) := 2;
            
         else
            AußenSchleife:
            loop

               Rasse := RassenWählen.Random (RassenGewählt);
               InnenSchleife:
               for B in GlobaleVariablen.RassenImSpiel'Range loop
                  
                  if GlobaleVariablen.EinheitenGebaut (B, 1).ID = Rasse then
                     exit InnenSchleife;

                  elsif GlobaleVariablen.EinheitenGebaut (B, 1).ID /= Rasse and GlobaleVariablen.EinheitenGebaut (B, 1).ID = 0 then
                     exit AußenSchleife;
                     
                  else
                     null;
                  end if;
                  
               end loop InnenSchleife;
            end loop AußenSchleife;
         end if;
         
         StartwerteFestgelegt := False;
         WerteWählen.Reset (PositionGewählt);
         
         StartwerteFestlegenSchleife:
         while StartwerteFestgelegt = False loop

            GlobaleVariablen.CursorImSpiel.YAchse := WerteWählen.Random (PositionGewählt);
            GlobaleVariablen.CursorImSpiel.XAchse := WerteWählen.Random (PositionGewählt);
            FelderDrumHerum := 0;
         
            if Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund > 2 and Karten.Karten (GlobaleVariablen.CursorImSpiel.YAchse, GlobaleVariablen.CursorImSpiel.XAchse).Grund /= 31 then
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
                        when -1_000_000 =>
                           exit XAchseSchleife;
                  
                        when others =>
                           if YÄnderung = 0 and XÄnderung = 0 then
                              null;
                     
                           elsif Karten.Karten (KartenWert.YWert, KartenWert.XWert).Grund > 2 and 
                             (Karten.Karten (KartenWert.YWert, KartenWert.XWert).Grund < 29 or Karten.Karten (KartenWert.YWert, KartenWert.XWert).Grund > 31) then
                              FelderDrumHerum := FelderDrumHerum + 1;
                              case FelderDrumHerum is
                                 when 3 =>
                                    StartpunktFestlegen (Rasse => GlobaleVariablen.Rasse);
                                    StartwerteFestgelegt := True;
                              
                                 when others =>
                                    null;
                              end case;
                     
                           else
                              null;
                           end if;
                     end case;

                  end loop XAchseSchleife;
               end loop YAchseSchleife;

            else
               null;
            end if;      
         
         end loop StartwerteFestlegenSchleife;
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
               when -1_000_000 =>
                  exit XAchseSchleife;
                  
               when others =>
                  if YÄnderung = 0 and XÄnderung = 0 then
                     null;
               
                  elsif Karten.Karten (KartenWert.YWert, KartenWert.XWert).Grund > 2 and (Karten.Karten (KartenWert.YWert, KartenWert.XWert).Grund < 29
                                                                                          or Karten.Karten (KartenWert.YWert, KartenWert.XWert).Grund > 31) then
                     GlobaleVariablen.EinheitenGebaut (Rasse, 2).ID := 2;
                     GlobaleVariablen.EinheitenGebaut (Rasse, 2).YAchse := KartenWert.YWert;
                     GlobaleVariablen.EinheitenGebaut (Rasse, 2).XAchse := KartenWert.XWert;
                     EinheitenDatenbank.LebenspunkteBewegungspunkteAufMaximumSetzen (Rasse => Rasse, EinheitNummer => 2);
                  
                  elsif Karten.Karten (KartenWert.YWert, KartenWert.XWert).Grund = 2 or (Karten.Karten (KartenWert.YWert, KartenWert.XWert).Grund >= 29
                                                                                         and Karten.Karten (KartenWert.YWert, KartenWert.XWert).Grund <= 31) then
                     GlobaleVariablen.EinheitenGebaut (Rasse, 3).ID := 6;
                     GlobaleVariablen.EinheitenGebaut (Rasse, 3).YAchse := KartenWert.YWert;
                     GlobaleVariablen.EinheitenGebaut (Rasse, 3).XAchse := KartenWert.XWert;
                     EinheitenDatenbank.LebenspunkteBewegungspunkteAufMaximumSetzen (Rasse => Rasse, EinheitNummer => 3);
                  
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;   
      
   end StartpunktFestlegen;

end SpielEinstellungen;
