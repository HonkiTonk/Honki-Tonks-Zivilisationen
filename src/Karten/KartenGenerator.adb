package body KartenGenerator is

   procedure KartenGenerator is
   begin

      case Kartenart is
         when 5 =>
            Chaos;
            return;
            
         when others =>
            null;
      end case;

      Reset (Gewählt);

      NochVerteilbareRessourcen := Karten.Kartengrößen (Karten.Kartengröße).Ressourcenmenge;
      GrößeLandart := (6, 15, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2); -- Inseln, Kontinente, Pangäa
      -- GrößeLandart bekommt hier erst Werte, da sonst die Werte für Pangäa nicht bekannt wären.
      GeneratorKarte := (others => (others => (0)));

      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 2) := Clock;
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
               
            
               case Kartenart is
                  when 3 =>
                     GenerierungPangäa (YAchse => YAchse,
                                        XAchse => XAchse);
                  
                  when others =>                     
                     GenerierungKartenart (YAchse => YAchse,
                                           XAchse => XAchse);
               end case;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 2) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeit => 2);
            
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 3) := Clock;
      GenerierungKüstenSeeGewässer;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 3) := Clock;   
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeit => 3);   
      
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 4) := Clock;
      GenerierungLandschaft;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 4) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeit => 4);
      
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 5) := Clock;
      GenerierungFlüsse;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 5) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeit => 5);
      
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 6) := Clock;
      GenerierungRessourcen;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 6) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeit => 6);
      
      AndereEbenen;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeit => 7);
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeit => 8);
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeit => 9);
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeit => 10);

      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 11) := Clock;
      KartenfelderBewerten;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 11) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeit => 11);
      
   end KartenGenerator;



   procedure GenerierungKartenart (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) is
   begin

      Wert := Random (Gewählt);

      case GeneratorKarte (YAchse, XAchse) is -- Die Werte werden eingetragen, wenn Landmassen erzeugt werden
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
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => (0, YPositionLandmasse, XPositionLandmasse),
                                                              Änderung      => (0, YÄnderung, XÄnderung),
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
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => (0, YPositionLandmasse, XPositionLandmasse),
                                                              Änderung      => (0, YÄnderung, XÄnderung),
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
   
   
   
   procedure GenerierungLandmasseÜberhang (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv; Gezogen : in Float) is
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



   procedure GenerierungPangäa (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      if YAchse = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2 and XAchse = Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 then
         GenerierungLandmasse (YPositionLandmasse => YAchse,
                               XPositionLandmasse => XAchse);
        
      else
         Wert := Random (Gewählt);
         if Wert >= WahrscheinlichkeitenFürLand (Kartenart, 2) then
            Karten.Karten (0, YAchse, XAchse).Grund := 3;
            GeneratorKarte (YAchse, XAchse) := 1;
         
         else
            null;
         end if;
      end if;
      
   end GenerierungPangäa;



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
                     
                        KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => (0, YPosition, XPosition),
                                                                          Änderung       => (0, YÄnderung, XÄnderung),
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
   
   
   
   procedure GenerierungLandschaft is
   begin

      GeneratorKarte := (others => (others => (0)));
      GeneratorGrund := (others => (others => (False)));

      YAbstandVonEisschichtSchleife:
      for YAchse in Karten.Karten'First (2) .. Karten.Karten'First (2) + 3 loop
         XAbstandVonEisschichtSchleife:
         for XAchse in Karten.Karten'Range (3) loop
            
            GeneratorKarte (YAchse, XAchse) := 4;
            
         end loop XAbstandVonEisschichtSchleife;
      end loop YAbstandVonEisschichtSchleife;

      YAbstandVonEisschichtSchleife2:
      for YAchse in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 3 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAbstandVonEisschichtSchleife2:
         for XAchse in Karten.Karten'Range (3) loop
            
            GeneratorKarte (YAchse, XAchse) := 4;
            
         end loop XAbstandVonEisschichtSchleife2;
      end loop YAbstandVonEisschichtSchleife2;
            
      YAchseSchleife:
      for YAchse in Karten.Karten'First (2) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseSchleife:
         for XAchse in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            if Karten.Karten (0, YAchse, XAchse).Grund < 3 or Karten.Karten (0, YAchse, XAchse).Grund = 31 then
               GeneratorGrund (YAchse, XAchse) := True;

            else
               Wert := Random (Gewählt);
               if Wert <= KartengrundWahrscheinlichkeiten (Kartentemperatur, 4) and GeneratorGrund (YAchse, XAchse) = False and GeneratorKarte (YAchse, XAchse) /= 5 then
                  GenerierungLandschaftFelder (Grund  => 4,
                                               YAchse => YAchse,
                                               XAchse => XAchse);

               elsif Wert <= KartengrundWahrscheinlichkeiten (Kartentemperatur, 5) and GeneratorGrund (YAchse, XAchse) = False and GeneratorKarte (YAchse, XAchse) /= 4 then
                  GenerierungLandschaftFelder (Grund  => 5,
                                               YAchse => YAchse,
                                               XAchse => XAchse);

               elsif Wert <= KartengrundWahrscheinlichkeiten (Kartentemperatur, 6) and GeneratorGrund (YAchse, XAchse) = False then
                  GenerierungLandschaftFelder (Grund  => 6,
                                               YAchse => YAchse,
                                               XAchse => XAchse);

               elsif Wert <= KartengrundWahrscheinlichkeiten (Kartentemperatur, 7) and GeneratorGrund (YAchse, XAchse) = False then
                  GenerierungLandschaftFelder (Grund  => 7,
                                               YAchse => YAchse,
                                               XAchse => XAchse);

               elsif Wert <= KartengrundWahrscheinlichkeiten (Kartentemperatur, 8) and GeneratorGrund (YAchse, XAchse) = False then
                  GenerierungLandschaftFelder (Grund  => 8,
                                               YAchse => YAchse,
                                               XAchse => XAchse);

               elsif Wert <= KartengrundWahrscheinlichkeiten (Kartentemperatur, 9) and GeneratorGrund (YAchse, XAchse) = False then
                  GenerierungLandschaftFelder (Grund  => 9,
                                               YAchse => YAchse,
                                               XAchse => XAchse);

               elsif Wert <= KartengrundWahrscheinlichkeiten (Kartentemperatur, 10) and GeneratorGrund (YAchse, XAchse) = False then
                  GenerierungLandschaftFelder (Grund  => 32,
                                               YAchse => YAchse,
                                               XAchse => XAchse);
                  
               else
                  GeneratorGrund (YAchse, XAchse) := True;
               end if;
            end if;            
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;         
         
   end GenerierungLandschaft;



   procedure GenerierungLandschaftFelder (Grund : in GlobaleDatentypen.KartenGrund; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeNullZuEins'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeNullZuEins'Range loop            
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => (0, YAchse, XAchse),
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);

            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  if Karten.Karten (0, YAchse, XAchse).Grund < 3 or Karten.Karten (0, YAchse, XAchse).Grund = 31 then
                     null;
                     
                  elsif YÄnderung = 0 and XÄnderung = 0 then
                     Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Grund := Grund;
                     GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) := True;
                     
                  else
                     Wert := Random (Gewählt);
                     if Wert > 0.50 and GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) = False then
                        if Grund = 4 and GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) = 5 then
                           null;
                           
                        elsif Grund = 5 and GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) = 4 then
                           null;
                           
                        else
                           Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Grund := Grund;
                           GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) := True;
                        end if;
                        
                     else
                        GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) := True;                       
                     end if;
                  end if;
            end case;

            case Grund is
               when 6 | 7 => -- Hügel - Gebirge
                  null;
                  
               when others =>
                  GenerierungLandschaftHügel (YAchse => KartenWert.YAchse,
                                              XAchse => KartenWert.XAchse);
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;      

      case Grund is
         when 4 | 5 => -- Tundra - Wüste
            ZweiteYAchseSchleife:
            for YÄnderung in GlobaleDatentypen.LoopRangeMinusZweiZuZwei'Range loop
               ZweiteXAchseSchleife:
               for XÄnderung in GlobaleDatentypen.LoopRangeMinusZweiZuZwei'Range loop
            
                  KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => (0, YAchse, XAchse),
                                                                    Änderung       => (0, YÄnderung, XÄnderung),
                                                                    ZusatzYAbstand => 0);

                  case KartenWert.YAchse is
                     when GlobaleDatentypen.Kartenfeld'First =>
                        exit ZweiteXAchseSchleife;
                  
                     when others =>
                        if GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) /= 0 then
                           null;
                                     
                        else
                           GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) := GlobaleDatentypen.Kartenfeld (Grund);
                        end if;
                  end case;
            
               end loop ZweiteXAchseSchleife;
            end loop ZweiteYAchseSchleife;
            
         when others =>
            null;
      end case;
      
   end GenerierungLandschaftFelder;



   procedure GenerierungLandschaftHügel (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      HügelGebirgeUmgebung := 0;
      YAchseHügelSchleife:
      for YÄnderungHügel in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseHügelSchleife:
         for XÄnderungHügel in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop            
            
            KartenWertHügel := SchleifenPruefungen.KartenUmgebung (Koordinaten    => (0, YAchse, XAchse),
                                                                   Änderung       => (0, YÄnderungHügel, XÄnderungHügel),
                                                                   ZusatzYAbstand => 0);

            case KartenWertHügel.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseHügelSchleife;
                  
               when others =>
                  if YÄnderungHügel = 0 and XÄnderungHügel = 0 then
                     null;
                                 
                  elsif Karten.Karten (0, KartenWertHügel.YAchse, KartenWertHügel.XAchse).Grund = 6 or Karten.Karten (0, KartenWertHügel.YAchse, KartenWertHügel.XAchse).Grund = 7
                    or Karten.Karten (0, KartenWertHügel.YAchse, KartenWertHügel.XAchse).Hügel = True then
                     HügelGebirgeUmgebung := HügelGebirgeUmgebung + 1;
                                 
                  else
                     null;
                  end if;                        
            end case;
            
         end loop XAchseHügelSchleife;
      end loop YAchseHügelSchleife;

      case HügelGebirgeUmgebung is
                  
         when 1 .. 3 =>
            Wert := Random (Gewählt);
            if Wert >= 0.85 then
               Karten.Karten (0, YAchse, XAchse).Hügel := True;
                     
            else
               null;
            end if;
                  
         when 4 .. 7 =>
            Wert := Random (Gewählt);
            if Wert >= 0.66 then
               Karten.Karten (0, YAchse, XAchse).Hügel := True;
                     
            else
               null;
            end if;
                  
         when 8 =>
            Wert := Random (Gewählt);
            if Wert >= 0.33 then
               Karten.Karten (0, YAchse, XAchse).Hügel := True;
                     
            else
               null;
            end if;
                  
         when others =>                  
            Wert := Random (Gewählt);
            if Wert >= 0.95 then
               Karten.Karten (0, YAchse, XAchse).Hügel := True;
                     
            else
               null;
            end if;
      end case;
      
   end GenerierungLandschaftHügel;
   


   procedure GenerierungFlüsse is
   begin
      
      YAchseSchleife:
      for YAchse in Karten.Karten'First (2) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseSchleife:
         for XAchse in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop            

            Wert := Random (Gewählt);
            if Karten.Karten (0, YAchse, XAchse).Grund < 3 or Karten.Karten (0, YAchse, XAchse).Grund = 31 then
               null;
                           
            elsif Wert >= WahrscheinlichkeitFluss then
               Karten.Karten (0, YAchse, XAchse).Fluss := 15;
               
            else
               YAchseSchleifeZwei:
               for A in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  XAchseSchleifeZwei:
                  for B in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  
                     KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => (0, YAchse, XAchse),
                                                                       Änderung       => (0, A, B),
                                                                       ZusatzYAbstand => 0); -- Hier muss < geprüft werden, deswegen 0
                     
                     case KartenWert.YAchse is
                        when GlobaleDatentypen.Kartenfeld'First =>
                           exit XAchseSchleifeZwei;
                           
                        when others =>
                           if Karten.Karten (0, KartenWert.YAchse, KartenWert.YAchse).Fluss /= 0 and Wert >= WahrscheinlichkeitFluss / 2.00 then                        
                              Karten.Karten (0, YAchse, XAchse).Fluss := 15;

                           else
                              null;
                           end if;
                     end case;
                     
                  end loop XAchseSchleifeZwei;
               end loop YAchseSchleifeZwei;
            end if;
            case Karten.Karten (0, YAchse, XAchse).Fluss is
               when 0 =>
                  null;
                  
               when others =>
                  FlussBerechnung (YKoordinate => YAchse,
                                   XKoordinate => XAchse);
            end case;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungFlüsse;



   procedure FlussBerechnung (YKoordinate, XKoordinate : in GlobaleDatentypen.KartenfeldPositiv) is -- Außerdem scheint hier noch etwas nicht zu stimmen, nochmal drüber schauen oder gleich was besseres zusammenbasteln.
   begin
                    
      Flusswert := 10_000;   
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => (0, YKoordinate, XKoordinate),
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);

            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;

               when others =>
                  if XÄnderung = -1 and YÄnderung = 0 then
                     case Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Fluss is
                        when 0 =>
                           Flusswert := Flusswert - 1_000;

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
                     Flusswert := Flusswert + 1_000;
               
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
         when 11_000 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 26;

         when 10_100 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 25;

         when 10_010 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 27;

         when 10_001 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 28;

         when 11_010 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 20;

         when 11_001 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 18;

         when 11_110 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 21;

         when 11_101 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 22;

         when 11_111 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 14;

         when 10_110 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 19;

         when 10_101 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 17;

         when 10_111 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 23;

         when 10_011 =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 16;
         
         when others =>
            Karten.Karten (0, YKoordinate, XKoordinate).Fluss := 15;
      end case;
      
   end FlussBerechnung;
   
   
   
   procedure GenerierungRessourcen is -- Die Verteilung mehrmals loopen lassen? Einmal von oben zur mitte, von unten zur mitte, von mitte nach oben und von mitte nach unten?
   begin

      while NochVerteilbareRessourcen /= 0 loop      
         YAchseSchleife:
         for YAchse in Karten.Karten'First (2) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
            XAchseSchleife:
            for XAchse in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               case NochVerteilbareRessourcen is
                  when 0 =>
                     return;
                  
                  when others =>
                     Wert := Random (Gewählt);
                     if Wert >= 0.98 and (Karten.Karten (0, YAchse, XAchse).Grund = 2 or Karten.Karten (0, YAchse, XAchse).Grund = 31) then
                        if Karten.Karten (0, YAchse, XAchse).Grund = 2 and Wert > 0.99 then
                           Karten.Karten (0, YAchse, XAchse).Ressource := 30;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                           
                        else
                           Karten.Karten (0, YAchse, XAchse).Ressource := 29;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                        end if;
                        
                     elsif Wert <= 0.05 and Karten.Karten (0, YAchse, XAchse).Grund /= 2 and Karten.Karten (0, YAchse, XAchse).Grund /= 31 then
                        if Wert < 0.01 then
                           Karten.Karten (0, YAchse, XAchse).Ressource := 11;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                        elsif Wert < 0.02 then
                           Karten.Karten (0, YAchse, XAchse).Ressource := 12;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                        elsif Wert < 0.03 then
                           Karten.Karten (0, YAchse, XAchse).Ressource := 13;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                        elsif Wert < 0.04 then
                           Karten.Karten (0, YAchse, XAchse).Ressource := 33;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                           
                           
                        else
                           Karten.Karten (0, YAchse, XAchse).Ressource := 10;
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
         
         Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 8) := Clock;
         
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
                     exit XAchseSchleife;
                     
                  when others =>
                     Karten.Karten (1, YAchse, XAchse).Grund := 37;
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 8) := Clock;
         
      end Himmel;
      
      
      
      task body Weltraum is
      begin

         Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 9) := Clock;

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
                     exit XAchseSchleife;
                     
                  when others =>
                     Karten.Karten (2, YAchse, XAchse).Grund := 38;
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;

         Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 9) := Clock;
         
      end Weltraum;
      
      

      task body UnterwasserUnterirdisch is
      begin
         
         Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 10) := Clock;
         
         YAchseSchleife:
         for YAchse in Karten.Karten'Range (2) loop
            XAchseSchleife:
            for XAchse in Karten.Karten'Range (3) loop
               
               case Karten.Karten (0, YAchse, XAchse).Grund is
                  when 0 =>
                     exit XAchseSchleife;
                     
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
         
         Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 10) := Clock;
         
      end UnterwasserUnterirdisch;
      
      
      
      task body PlanetenInneres is
      begin
         
         Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 11) := Clock;
         
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
                     exit XAchseSchleife;
                     
                  when others =>
                     Karten.Karten (-2, YAchse, XAchse).Grund := 39;
               end case;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 11) := Clock;
         
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
         for YAchse in Karten.Karten'First (2) + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 1 loop
            XAchseSchleife:
            for XAchse in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               WerteFestlegen.KartenfelderBewerten (Generierung => True,
                                                    Koordinaten => (1, YAchse, XAchse));
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
      end Himmel;



      task body Weltraum is
      begin
         
         YAchseSchleife:
         for YAchse in Karten.Karten'First (2) + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 1 loop
            XAchseSchleife:
            for XAchse in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               WerteFestlegen.KartenfelderBewerten (Generierung => True,
                                                    Koordinaten => (2, YAchse, XAchse));
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
      end Weltraum;
      
      
      
      task body UnterwasserUnterirdisch is
      begin
         
         YAchseSchleife:
         for YAchse in Karten.Karten'First (2) + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 1 loop
            XAchseSchleife:
            for XAchse in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               WerteFestlegen.KartenfelderBewerten (Generierung => True,
                                                    Koordinaten => (-1, YAchse, XAchse));
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
      end UnterwasserUnterirdisch;
      
      
      
      task body PlanetenInneres is
      begin
         
         YAchseSchleife:
         for YAchse in Karten.Karten'First (2) + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 1 loop
            XAchseSchleife:
            for XAchse in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               WerteFestlegen.KartenfelderBewerten (Generierung => True,
                                                    Koordinaten => (-2, YAchse, XAchse));
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
      end PlanetenInneres;


      
   begin
      
      YAchseSchleife:
      for YAchse in Karten.Karten'First (2) + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 1 loop
         XAchseSchleife:
         for XAchse in Karten.Karten'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            WerteFestlegen.KartenfelderBewerten (Generierung => True,
                                                 Koordinaten => (1, YAchse, XAchse));
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
   
   end KartenfelderBewerten;



   procedure Chaos is
   begin
            
      EAchseSchleife:
      for EAchse in Karten.Karten'Range (1) loop
         YAchseSchleife:
         for YAchse in Karten.Karten'Range (2) loop
            XAchseSchleife:
            for XAchse in Karten.Karten'Range (3) loop
                        
               if YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
                  Karten.Karten (EAchse, YAchse, XAchse).Grund := -2;
                  exit YAchseSchleife;
               
               elsif XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
                  Karten.Karten (EAchse, YAchse, XAchse).Grund := -1;
                  exit XAchseSchleife;   
               
               elsif YAchse = Karten.Karten'First (2) or YAchse = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
                  Karten.Karten (EAchse, YAchse, XAchse).Grund := 1;
               
               else
                  Karten.Karten (EAchse, YAchse, XAchse).Grund := ZufallsGeneratoren.Chaoskarte;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;

      KartenfelderBewerten;
      
   end Chaos;

end KartenGenerator;
