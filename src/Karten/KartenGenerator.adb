package body KartenGenerator is

   procedure KartenGenerator is
   begin

      Reset (Gewählt);

      NochVerteilbareRessourcen := Karten.Kartengrößen (Karten.Kartengröße).Ressourcenmenge;
      GrößeLandart := (6, 15, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 10); -- Inseln, Kontinente, Pangäa
      -- GrößeLandart bekommt hier erst Werte, da sonst die Werte für Pangäa nicht bekannt wären.
      GeneratorKarte := (others => (others => (0)));

      GlobaleVariablen.Zeit (1, 2) := Clock;
      YAchseSchleife:
      for YAchse in Karten.Karten'Range (2) loop
         XAchseSchleife:
         for XAchse in Karten.Karten'Range (3) loop
                        
            if YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
               Karten.Karten (0, YAchse, XAchse).Grund := -2;
               exit YAchseSchleife;
               
            elsif XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
               Karten.Karten (0, YAchse, XAchse).Grund := -1;
               exit XAchseSchleife;   
               
            elsif YAchse = Karten.Karten'First (2) or YAchse = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
               Karten.Karten (0, YAchse, XAchse).Grund := 1;
               
            else
               case Karten.Karten (0, YAchse, XAchse).Grund is -- Abfrage ist hier nötig, da sonst eine erstellte Landmasse wieder überschrieben wird!
                  when 0 =>
                     Karten.Karten (0, YAchse, XAchse).Grund := 2;

                  when others =>
                     null;
               end case;
               GenerierungKartenart (YAchse => YAchse,
                                     XAchse => XAchse);
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      GlobaleVariablen.Zeit (2, 2) := Clock;
      Ladezeiten.Ladezeiten (WelcheZeit => 2);
            
      GlobaleVariablen.Zeit (1, 3) := Clock;
      GenerierungKüstenSeeGewässer;
      GlobaleVariablen.Zeit (2, 3) := Clock;   
      Ladezeiten.Ladezeiten (WelcheZeit => 3);   

      GlobaleVariablen.Zeit (1, 4) := Clock;
      GenerierungKartentemperatur;
      GlobaleVariablen.Zeit (2, 4) := Clock;
      Ladezeiten.Ladezeiten (WelcheZeit => 4);
      
      GlobaleVariablen.Zeit (1, 5) := Clock;
      GenerierungLandschaft;
      GlobaleVariablen.Zeit (2, 5) := Clock;
      Ladezeiten.Ladezeiten (WelcheZeit => 5);
      
      GlobaleVariablen.Zeit (1, 6) := Clock;
      GenerierungFlüsse;
      GlobaleVariablen.Zeit (2, 6) := Clock;
      Ladezeiten.Ladezeiten (WelcheZeit => 6);
      
      GlobaleVariablen.Zeit (1, 7) := Clock;
      GenerierungRessourcen;
      GlobaleVariablen.Zeit (2, 7) := Clock;
      Ladezeiten.Ladezeiten (WelcheZeit => 7);
      
      AndereEbenen;
      Ladezeiten.Ladezeiten (WelcheZeit => 8);
      Ladezeiten.Ladezeiten (WelcheZeit => 9);
      Ladezeiten.Ladezeiten (WelcheZeit => 10);
      Ladezeiten.Ladezeiten (WelcheZeit => 11);

      GlobaleVariablen.Zeit (1, 12) := Clock;
      KartenfelderBewerten;
      GlobaleVariablen.Zeit (2, 12) := Clock;
      Ladezeiten.Ladezeiten (WelcheZeit => 12);
      
   end KartenGenerator;



   procedure GenerierungKartenart (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) is
   begin

      Wert := Random (Gewählt);

      case GeneratorKarte (YAchse, XAchse) is
         when 1 .. 2 =>
            null;

         when 0 =>
            if YAchse <= Karten.Karten'First (2) + 3  or YAchse >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 3 then
               if Wert > WahrscheinlichkeitenFürLand (Kartenart, 1) and Wert < WahrscheinlichkeitenFürLand (Kartenart, 2) then
                  Karten.Karten (0, YAchse, XAchse).Grund := 3;
                           
               elsif Wert >= WahrscheinlichkeitenFürLand (Kartenart, 2) then
                  Karten.Karten (0, YAchse, XAchse).Grund := 3;
                  GenerierungLandmasse (YPositionLandmasse => YAchse,
                                        XPositionLandmasse => XAchse);
                           
               else
                  null;
               end if;
                              
            else
               if Wert > WahrscheinlichkeitenFürLand (Kartenart, 3) and Wert < WahrscheinlichkeitenFürLand (Kartenart, 4) then
                  Karten.Karten (0, YAchse, XAchse).Grund := 3;
                                 
               elsif Wert >= WahrscheinlichkeitenFürLand (Kartenart, 4) then
                  Karten.Karten (0, YAchse, XAchse).Grund := 3;
                  GenerierungLandmasse (YPositionLandmasse => YAchse,
                                        XPositionLandmasse => XAchse);
                                 
               else
                  null;
               end if;
            end if;

         when others =>
            if Wert >= WahrscheinlichkeitenFürLand (Kartenart, 5) then                           
               Karten.Karten (0, YAchse, XAchse).Grund := 3;
                           
            else
               null;
            end if;
      end case;
      
   end GenerierungKartenart;

   
   
   procedure GenerierungLandmasse (YPositionLandmasse, XPositionLandmasse : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      YAchseSchleife:
      for YÄnderung in -GrößeLandart (Kartenart) / 2 .. GrößeLandart (Kartenart) / 2 loop
         XAchseSchleife:
         for XÄnderung in -GrößeLandart (Kartenart) / 2 .. GrößeLandart (Kartenart) / 2 loop
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => YPositionLandmasse,
                                                              XKoordinate    => XPositionLandmasse,
                                                              YÄnderung      => YÄnderung,
                                                              XÄnderung      => XÄnderung,
                                                              ZusatzYAbstand => 1); -- Hier muss <= geprüft werden, deswegen 1

            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>         
                  Wert := Random (Gewählt);
                  GenerierungLandmasseÜberhang (YAchse  => KartenWert.YAchse,
                                                XAchse  => KartenWert.XAchse,
                                                Gezogen => Wert);
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      YAchseZweiSchleife: -- Funktioniert nicht mit Kontinenten bei kleinen Karten weil der Abstandswert zu groß ist! An Kartengrößen angepasste Werte anlegen, wie bei der Kartenanzeige.
      for YÄnderung in -FelderVonLandartZuLandart (Kartenart) .. FelderVonLandartZuLandart (Kartenart) loop
         XAchseZweiSchleife:
         for XÄnderung in -FelderVonLandartZuLandart (Kartenart) .. FelderVonLandartZuLandart (Kartenart) loop
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => YPositionLandmasse,
                                                              XKoordinate    => XPositionLandmasse,
                                                              YÄnderung      => YÄnderung,
                                                              XÄnderung      => XÄnderung,
                                                              ZusatzYAbstand => 1); -- Hier muss <= geprüft werden, deswegen 1
            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseZweiSchleife;
                  
               when others =>
                  case GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) is
                     when 1 .. 2 =>
                        null;
                        
                     when others =>
                        GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) := 3;                           
                  end case;
            end case;
                    
         end loop XAchseZweiSchleife; 
      end loop YAchseZweiSchleife;
      
   end GenerierungLandmasse;
   
   
   
   procedure GenerierungLandmasseÜberhang (YAchse, XAchse : in GlobaleDatentypen.Kartenfeld; Gezogen : in Float) is
   begin
   
      if Gezogen >= WahrscheinlichkeitenFürLand (Kartenart, 6) and GeneratorKarte (YAchse, XAchse) = 0 then
         Karten.Karten (0, YAchse, XAchse).Grund := 3;
         GeneratorKarte (YAchse, XAchse) := 1;

      elsif Gezogen >= WahrscheinlichkeitenFürLand (Kartenart, 7) then
         Karten.Karten (0, YAchse, XAchse).Grund := 3;
         GeneratorKarte (YAchse, XAchse) := 1;
               
      else
         null;
      end if;
         
      
   end GenerierungLandmasseÜberhang;



   procedure GenerierungKüstenSeeGewässer is
   begin
      
      YAchseSchleife:
      for YPosition in Karten.Karten'First (2) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseSchleife:
         for XPosition in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                              
            case Karten.Karten (0, YPosition, XPosition).Grund is
               when 2 =>
                  ZweiteYAchseSchleife:
                  for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     ZweiteXAchseSchleife:
                     for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     
                        KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => YPosition,
                                                                          XKoordinate    => XPosition,
                                                                          YÄnderung      => YÄnderung,
                                                                          XÄnderung      => XÄnderung,
                                                                          ZusatzYAbstand => 0);

                        case KartenWert.YAchse is
                           when GlobaleDatentypen.Kartenfeld'First =>
                              exit ZweiteYAchseSchleife;
                                
                           when others =>
                              case Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Grund is
                                 when 3 =>
                                    Karten.Karten (0, YPosition, XPosition).Grund := 31;
                                    exit ZweiteYAchseSchleife;

                                 when others =>
                                    null;
                              end case;
                        end case;
                        
                     end loop ZweiteXAchseSchleife;
                  end loop ZweiteYAchseSchleife;
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungKüstenSeeGewässer;
   
   
   
   procedure GenerierungKartentemperatur is
   begin

      EisWahrscheinlichkeitReduzierungspunkt := (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 6, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 8, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 10);
      GeneratorKarte := (others => (others => (0)));

      for A in Karten.Karten'First (2) .. Karten.Karten'First (2) + FelderVonTemperaturZuTemperatur + Eisrand loop
         for B in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            GeneratorKarte (A, B) := 4;
            
         end loop;
      end loop;
      
      for C in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - FelderVonTemperaturZuTemperatur - Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         for D in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            GeneratorKarte (C, D) := 4;
            
         end loop;
      end loop;
      
      YAchseSchleife:
      for Y in Karten.Karten'First (2) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop -- Nur bis halb loopen und dann mit reverse entgegenkommen?
         XAchseSchleife:
         for X in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            if Y = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
               exit YAchseSchleife;
               
            elsif Y = Karten.Karten'First (2) then
               null;                                 
                              
            elsif Karten.Karten (0, Y, X).Grund < 3 or Karten.Karten (0, Y, X).Grund = 31 then
               null;
               
               -- 4 = Tundra, 5 = Wüste
            elsif Y <= EisWahrscheinlichkeitReduzierungspunkt (Kartentemperatur) or Y >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - EisWahrscheinlichkeitReduzierungspunkt (Kartentemperatur) then
               Wert := Random (Gewählt);
               if Wert > WahrscheinlichkeitenFürLandart (Kartentemperatur, 1) then
                  Karten.Karten (0, Y, X).Grund := 4;
                  GenerierungTemperaturAbstand (YPosition => Y,
                                                XPosition => X,
                                                Geländeart => 4);
                     
               else
                  null;
               end if;
               
            else
               Wert := Random (Gewählt);
               if Wert > WahrscheinlichkeitenFürLandart (Kartentemperatur, 2) and GeneratorKarte (Y, X) /= 5 then
                  Karten.Karten (0, Y, X).Grund := 4;
                  GenerierungTemperaturAbstand (YPosition => Y,
                                                XPosition => X,
                                                Geländeart => 4);
                  
               elsif Wert > WahrscheinlichkeitenFürLandart (Kartentemperatur, 3) and GeneratorKarte (Y, X) /= 4 then
                  Karten.Karten (0, Y, X).Grund := 5;
                  GenerierungTemperaturAbstand (YPosition => Y,
                                                XPosition => X,
                                                Geländeart => 5);
                  
               else
                  null;
               end if;
            end if;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungKartentemperatur;



   procedure GenerierungTemperaturAbstand (Geländeart : GlobaleDatentypen.KartenGrund; YPosition, XPosition : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      YAchseSchleife:
      for YÄnderung in -FelderVonTemperaturZuTemperatur .. FelderVonTemperaturZuTemperatur loop
         XAchseSchleife:
         for XÄnderung in -FelderVonTemperaturZuTemperatur .. FelderVonTemperaturZuTemperatur loop
                        
            KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => YPosition,
                                                              XKoordinate    => XPosition,
                                                              YÄnderung      => YÄnderung,
                                                              XÄnderung      => XÄnderung,
                                                              ZusatzYAbstand => 1); -- Hier muss <= geprüft werden, deswegen 1

            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  case GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) is
                     when 0 =>
                        GenerierungTemperaturZusatz (YAchse     => KartenWert.YAchse,
                                                     XAchse     => KartenWert.XAchse,
                                                     Geländeart => Geländeart);
                        
                     when others =>
                        null;
                  end case;
            end case;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
   
   end GenerierungTemperaturAbstand;
   
   
   
   procedure GenerierungTemperaturZusatz (Geländeart : GlobaleDatentypen.KartenGrund; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) is
   begin

      if Karten.Karten (0, YAchse, XAchse).Grund < 3 or Karten.Karten (0, YAchse, XAchse).Grund = 31 then
         null;
         
      elsif GeneratorKarte (YAchse, XAchse) = 0 then
         GeneratorKarte (YAchse, XAchse) := GlobaleDatentypen.Kartenfeld (Geländeart);
            
      else
         null;
      end if;         
      
   end GenerierungTemperaturZusatz;

   
   
   procedure GenerierungLandschaft is
   begin
      
      GenerierungLandschaftZusatz;
      
      YAchseSchleife:
      for Y in Karten.Karten'First (2) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseSchleife:
         for X in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            if Karten.Karten (0, Y, X).Grund < 3 or Karten.Karten (0, Y, X).Grund = 31 then
               null;
               
            elsif Karten.Karten (0, Y, X).Grund = 5 then
               Wert := Random (Gewählt);
               if Wert >= WahrscheinlichkeitFürLandschaft (6) then
                  Karten.Karten (0, Y, X).Hügel := True;
                  
               else
                  null;
               end if;

            elsif Karten.Karten (0, Y, X).Grund = 4 then
               Wert := Random (Gewählt);
               if Wert >= WahrscheinlichkeitFürLandschaft (6) then
                  Karten.Karten (0, Y, X).Hügel := True;
                  
               else
                  null;
               end if;
               
            else
               Wert := Random (Gewählt);
               if Wert >= WahrscheinlichkeitFürLandschaft (6) then
                  Karten.Karten (0, Y, X).Grund := 6;
                  Karten.Karten (0, Y, X).Hügel := True;
                  
               elsif Wert >= WahrscheinlichkeitFürLandschaft (7) then
                  Karten.Karten (0, Y, X).Grund := 7;
                  
               elsif Wert >= WahrscheinlichkeitFürLandschaft (8) and GeneratorKarte (Y, X) = 0 then
                  Karten.Karten (0, Y, X).Grund := 8;
                  
               elsif Wert >= WahrscheinlichkeitFürLandschaft (9) and GeneratorKarte (Y, X) = 0 then
                  Karten.Karten (0, Y, X).Grund := 9;
                  
               elsif Wert >= WahrscheinlichkeitFürLandschaft (10) and GeneratorKarte (Y, X) = 0 then
                  Karten.Karten (0, Y, X).Grund := 32;
                  
               else
                  null;                  
               end if;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;         
         
   end GenerierungLandschaft;



   procedure GenerierungLandschaftZusatz is
   begin
      
      GeneratorKarte := (others => (others => (0)));

      YAchseSchleife:
      for Y in Karten.Karten'First (2) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseSchleife:
         for X in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                     
            case Karten.Karten (0, Y, X).Grund is
               when 4 | 5 =>
                  YAchseSchleifeZwei:
                  for A in -Abstand .. Abstand loop
                     XAchseSchleifeZwei:
                     for B in -Abstand .. Abstand loop

                        KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => Y,
                                                                          XKoordinate    => X,
                                                                          YÄnderung      => A,
                                                                          XÄnderung      => B,
                                                                          ZusatzYAbstand => 1); -- Hier muss <= geprüft werden, deswegen 1

                        case KartenWert.YAchse is
                           when GlobaleDatentypen.Kartenfeld'First =>
                              exit XAchseSchleifeZwei;
                           
                           when others =>             
                              GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) := 1;
                        end case;
                     
                     end loop XAchseSchleifeZwei;
                  end loop YAchseSchleifeZwei;
               
               when others =>
                  null;
            end case;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungLandschaftZusatz;
   


   procedure GenerierungFlüsse is
   begin
      
      YAchseSchleife:
      for Y in Karten.Karten'First (2) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseSchleife:
         for X in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop            

            Wert := Random (Gewählt);
            if Karten.Karten (0, Y, X).Grund < 3 or Karten.Karten (0, Y, X).Grund = 31 then
               null;
                           
            elsif Wert >= WahrscheinlichkeitFluss then
               Karten.Karten (0, Y, X).Fluss := 15;
               
            else
               YAchseSchleifeZwei:
               for A in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  XAchseSchleifeZwei:
                  for B in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  
                     KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => Y,
                                                                       XKoordinate    => X,
                                                                       YÄnderung      => A,
                                                                       XÄnderung      => B,
                                                                       ZusatzYAbstand => 0); -- Hier muss < geprüft werden, deswegen 0

                     case KartenWert.YAchse is
                        when GlobaleDatentypen.Kartenfeld'First =>
                           exit XAchseSchleifeZwei;
                           
                        when others =>
                           if Karten.Karten (0, KartenWert.YAchse, KartenWert.YAchse).Fluss /= 0 and Wert >= WahrscheinlichkeitFluss / 2.00 then                        
                              Karten.Karten (0, Y, X).Fluss := 15;

                           else
                              null;
                           end if;
                     end case;
                     
                  end loop XAchseSchleifeZwei;
               end loop YAchseSchleifeZwei;
            end if;
            case Karten.Karten (0, Y, X).Fluss is
               when 0 =>
                  null;
                  
               when others =>
                  FlussBerechnung (YKoordinate => Y,
                                   XKoordinate => X);
            end case;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungFlüsse;



   procedure FlussBerechnung (YKoordinate, XKoordinate : in GlobaleDatentypen.Kartenfeld) is -- Außerdem scheint hier noch etwas nicht zu stimmen, nochmal drüber schauen oder gleich was besseres zusammenbasteln.
   begin
                    
      Flusswert := 10000;   
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => YKoordinate,
                                                              XKoordinate    => XKoordinate,
                                                              YÄnderung      => YÄnderung,
                                                              XÄnderung      => XÄnderung,
                                                              ZusatzYAbstand => 0);

            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;

               when others =>
                  if XÄnderung = -1 and YÄnderung = 0 then
                     case Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss is
                        when 0 =>
                           Flusswert := Flusswert - 1000;

                        when 16 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 23;
                     
                        when 18 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 22;

                        when 20 =>                     
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 21;

                        when 24 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 14;

                        when 26 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 15;

                        when 27 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 19;

                        when 28 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 17;
                     
                        when others =>
                           null;
                     end case;
                     Flusswert := Flusswert + 1000;
               
                  elsif XÄnderung = 1 and YÄnderung = 0 then
                     case Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss is
                        when 0 =>
                           Flusswert := Flusswert - 100;

                        when 16 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 24;
                     
                        when 17 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 22;

                        when 19 =>                     
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 21;

                        when 23 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 14;

                        when 25 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 15;

                        when 27 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 20;

                        when 28 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 18;
                     
                        when others =>
                           null;
                     end case;
                     Flusswert := Flusswert + 100;
               
                  elsif YÄnderung = -1 and XÄnderung = 0 then
                     case Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss is
                        when 0 =>
                           Flusswert := Flusswert - 10;
                     
                        when 15 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 22;
                     
                        when 19 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 23;

                        when 20 =>                     
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 24;

                        when 21 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 14;

                        when 25 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 17;

                        when 26 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 18;

                        when 27 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 16;
                     
                        when others =>
                           null;
                     end case;
                     Flusswert := Flusswert + 10;
               
                  elsif YÄnderung = 1 and XÄnderung = 0 then
                     case Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss is
                        when 0 =>
                           Flusswert := Flusswert - 1;
                     
                        when 15 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 21;
                     
                        when 17 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 23;

                        when 18 =>                     
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 24;

                        when 22 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 14;

                        when 25 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 19;

                        when 26 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 20;

                        when 28 =>
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss := 16;
                     
                        when others =>
                           null;
                     end case;
                     Flusswert := Flusswert + 1;
               
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      case Flusswert is
         when 11000 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 26;

         when 10100 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 25;

         when 10010 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 27;

         when 10001 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 28;

         when 11010 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 20;

         when 11001 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 18;

         when 11110 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 21;

         when 11101 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 22;

         when 11111 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 14;

         when 10110 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 19;

         when 10101 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 17;

         when 10111 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 23;

         when 10011 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 16;
         
         when others =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 15;
      end case;
      
   end FlussBerechnung;
   
   
   
   procedure GenerierungRessourcen is -- Die Verteilung mehrmals loopen lassen? Einmal von oben zur mitte, von unten zur mitte, von mitte nach oben und von mitte nach unten?
   begin

      while NochVerteilbareRessourcen /= 0 loop      
         YAchseSchleife:
         for Y in Karten.Karten'First (2) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
            XAchseSchleife:
            for X in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               case NochVerteilbareRessourcen is
                  when 0 =>
                     return;
                  
                  when others =>
                     Wert := Random (Gewählt);
                     if Wert >= 0.98 and (Karten.Karten (0, Y, X).Grund = 2 or Karten.Karten (0, Y, X).Grund = 31) then
                        if Karten.Karten (0, Y, X).Grund = 2 and Wert > 0.99 then
                           Karten.Karten (0, Y, X).Ressource := 30;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                           
                        else
                           Karten.Karten (0, Y, X).Ressource := 29;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                        end if;
                        
                     elsif Wert <= 0.05 and Karten.Karten (0, Y, X).Grund /= 2 and Karten.Karten (0, Y, X).Grund /= 31 then
                        if Wert < 0.01 then
                           Karten.Karten (0, Y, X).Ressource := 11;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                        elsif Wert < 0.02 then
                           Karten.Karten (0, Y, X).Ressource := 12;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                        elsif Wert < 0.03 then
                           Karten.Karten (0, Y, X).Ressource := 13;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                        elsif Wert < 0.04 then
                           Karten.Karten (0, Y, X).Ressource := 33;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                           
                           
                        else
                           Karten.Karten (0, Y, X).Ressource := 10;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                        end if;
                        
                     else
                        null;
                     end if;
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop;
      
   end GenerierungRessourcen;



   procedure AndereEbenen is
      
      task Himmel;
      task Weltraum;
      task UnterwasserUnterirdisch;
      task PlanetenInneres;
      
      task body Himmel is
      begin
         
         GlobaleVariablen.Zeit (1, 8) := Clock;
         
         YAchseSchleife:
         for YAchse in Karten.Karten'Range (2) loop
            XAchseSchleife:
            for XAchse in Karten.Karten'Range (3) loop
               
               case Karten.Karten (0, YAchse, XAchse).Grund is
                  when -1 =>
                     Karten.Karten (1, YAchse, XAchse).Grund := -1;
                     exit XAchseSchleife;
                     
                  when -2 =>
                     Karten.Karten (1, YAchse, XAchse).Grund := -2;
                     exit YAchseSchleife;
                     
                  when 0 =>
                     null;
                     
                  when others =>
                     Karten.Karten (1, YAchse, XAchse).Grund := 37;
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         GlobaleVariablen.Zeit (2, 8) := Clock;
         
      end Himmel;
      
      
      
      task body Weltraum is
      begin

         GlobaleVariablen.Zeit (1, 9) := Clock;

         YAchseSchleife:
         for YAchse in Karten.Karten'Range (2) loop
            XAchseSchleife:
            for XAchse in Karten.Karten'Range (3) loop

               case Karten.Karten (0, YAchse, XAchse).Grund is
                  when -1 =>
                     Karten.Karten (1, YAchse, XAchse).Grund := -1;
                     exit XAchseSchleife;
                     
                  when -2 =>
                     Karten.Karten (1, YAchse, XAchse).Grund := -2;
                     exit YAchseSchleife;
                     
                  when 0 =>
                     null;
                     
                  when others =>
                     Karten.Karten (2, YAchse, XAchse).Grund := 38;
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;

         GlobaleVariablen.Zeit (2, 9) := Clock;
         
      end Weltraum;
      
      

      task body UnterwasserUnterirdisch is
      begin
         
         GlobaleVariablen.Zeit (1, 10) := Clock;
         
         YAchseSchleife:
         for YAchse in Karten.Karten'Range (2) loop
            XAchseSchleife:
            for XAchse in Karten.Karten'Range (3) loop
               
               case Karten.Karten (0, YAchse, XAchse).Grund is
                  when 0 =>
                     null;
                     
                  when -1 =>
                     Karten.Karten (1, YAchse, XAchse).Grund := -1;
                     exit XAchseSchleife;
                     
                  when -2 =>
                     Karten.Karten (1, YAchse, XAchse).Grund := -2;
                     exit YAchseSchleife;     
                     
                  when 1 | 2 | 31 =>
                     Karten.Karten (-1, YAchse, XAchse).Grund := Karten.Karten (0, YAchse, XAchse).Grund;
                     
                  when 7 =>
                     Karten.Karten (-1, YAchse, XAchse).Grund := 40;
                     
                  when others =>
                     Karten.Karten (-1, YAchse, XAchse).Grund := 35;
               end case;

               case Karten.Karten (0, YAchse, XAchse).Ressource is
                  when 10 .. 13 | 29 .. 30 | 33 =>
                     Karten.Karten (-1, YAchse, XAchse).Ressource := Karten.Karten (0, YAchse, XAchse).Ressource;
                       
                  when others =>
                     null;
               end case;

               case Karten.Karten (0, YAchse, XAchse).Fluss is
                  when 0 =>
                     null;
                     
                  when others =>
                     Karten.Karten (-1, YAchse, XAchse).Fluss := Karten.Karten (0, YAchse, XAchse).Fluss;
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         GlobaleVariablen.Zeit (2, 10) := Clock;
         
      end UnterwasserUnterirdisch;
      
      
      
      task body PlanetenInneres is
      begin
         
         GlobaleVariablen.Zeit (1, 11) := Clock;
         
         YAchseSchleife:
         for YAchse in Karten.Karten'Range (2) loop
            XAchseSchleife:
            for XAchse in Karten.Karten'Range (3) loop
               
               case Karten.Karten (0, YAchse, XAchse).Grund is
                  when -1 =>
                     Karten.Karten (1, YAchse, XAchse).Grund := -1;
                     exit XAchseSchleife;
                     
                  when -2 =>
                     Karten.Karten (1, YAchse, XAchse).Grund := -2;
                     exit YAchseSchleife;
                     
                  when 0 =>
                     null;
                     
                  when others =>
                     Karten.Karten (-2, YAchse, XAchse).Grund := 39;
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         GlobaleVariablen.Zeit (2, 11) := Clock;
         
      end PlanetenInneres;


      
   begin
            
      null;
      
   end AndereEbenen;



   procedure KartenfelderBewerten is

      task Himmel;
      task Weltraum;
      task UnterwasserUnterirdisch;
      task PlanetenInneres;
      
      task body Himmel is
      begin

         YAchseSchleife:
         for YAchse in Karten.Karten'Range (2) loop
            XAchseSchleife:
            for XAchse in Karten.Karten'Range (3) loop
            
               case Karten.Karten (0, YAchse, XAchse).Grund is
                  when -1 =>
                     exit XAchseSchleife;
                  
                  when -2 =>
                     exit YAchseSchleife;
                  
                  when others =>
                     WerteFestlegen.KartenfelderBewerten (Generierung => True,
                                                           EAchse      => 1,
                                                           YAchse      => YAchse,
                                                           XAchse      => XAchse);
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
      end Himmel;



      task body Weltraum is
      begin
         
         YAchseSchleife:
         for YAchse in Karten.Karten'Range (2) loop
            XAchseSchleife:
            for XAchse in Karten.Karten'Range (3) loop
            
               case Karten.Karten (0, YAchse, XAchse).Grund is
                  when -1 =>
                     exit XAchseSchleife;
                  
                  when -2 =>
                     exit YAchseSchleife;
                  
                  when others =>
                     WerteFestlegen.KartenfelderBewerten (Generierung => True,
                                                           EAchse      => 2,
                                                           YAchse      => YAchse,
                                                           XAchse      => XAchse);
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
      end Weltraum;
      
      
      
      task body UnterwasserUnterirdisch is
      begin
         
         YAchseSchleife:
         for YAchse in Karten.Karten'Range (2) loop
            XAchseSchleife:
            for XAchse in Karten.Karten'Range (3) loop
            
               case Karten.Karten (0, YAchse, XAchse).Grund is
                  when -1 =>
                     exit XAchseSchleife;
                  
                  when -2 =>
                     exit YAchseSchleife;
                  
                  when others =>
                     WerteFestlegen.KartenfelderBewerten (Generierung => True,
                                                           EAchse      => -1,
                                                           YAchse      => YAchse,
                                                           XAchse      => XAchse);
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
      end UnterwasserUnterirdisch;
      
      
      
      task body PlanetenInneres is
      begin
         
         YAchseSchleife:
         for YAchse in Karten.Karten'Range (2) loop
            XAchseSchleife:
            for XAchse in Karten.Karten'Range (3) loop
            
               case Karten.Karten (0, YAchse, XAchse).Grund is
                  when -1 =>
                     exit XAchseSchleife;
                  
                  when -2 =>
                     exit YAchseSchleife;
                  
                  when others =>
                     WerteFestlegen.KartenfelderBewerten (Generierung => True,
                                                           EAchse      => -2,
                                                           YAchse      => YAchse,
                                                           XAchse      => XAchse);
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
      end PlanetenInneres;


      
   begin
      
      YAchseSchleife:
      for YAchse in Karten.Karten'Range (2) loop
         XAchseSchleife:
         for XAchse in Karten.Karten'Range (3) loop
            
            case Karten.Karten (0, YAchse, XAchse).Grund is
               when -1 =>
                  exit XAchseSchleife;
                  
               when -2 =>
                  exit YAchseSchleife;
                  
               when others =>
                  WerteFestlegen.KartenfelderBewerten (Generierung => True,
                                                        EAchse      => 0,
                                                        YAchse      => YAchse,
                                                        XAchse      => XAchse);
            end case;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
   
   end KartenfelderBewerten;

end KartenGenerator;
