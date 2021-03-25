pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with Ladezeiten, WerteFestlegen, ZufallsGeneratoren, KartenPruefungen;

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
      GrößeLandart := (6, 15, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2, 10); -- Inseln, Kontinente, Pangäa
      -- GrößeLandart bekommt hier erst Werte, da sonst die Werte für Pangäa nicht bekannt wären.
      GeneratorKarte := (others => (others => (0)));

      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 2) := Clock;
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
            if YAchseSchleifenwert = Karten.WeltkarteArray'First (2) or YAchseSchleifenwert = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
               Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund := 1;
               
            else
               case Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund is -- Abfrage ist hier nötig, da sonst eine erstellte Landmasse wieder überschrieben wird!
                  when 0 =>
                     case Kartenart is
                        when 4 =>
                           Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund := 3;
                           
                        when others =>
                           Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund := 2;
                     end case;

                  when others =>
                     null;
               end case;
               
            
               case Kartenart is
                  when 3 =>
                     GenerierungPangäa (YAchseExtern => YAchseSchleifenwert,
                                         XAchseExtern => XAchseSchleifenwert);
                  
                  when others =>                     
                     GenerierungKartenart (YAchseExtern => YAchseSchleifenwert,
                                           XAchseExtern => XAchseSchleifenwert);
               end case;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 2) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 2);
            
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 3) := Clock;
      GenerierungKüstenSeeGewässer;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 3) := Clock;   
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 3);   
      
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 4) := Clock;
      GenerierungLandschaft;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 4) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 4);
      
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 5) := Clock;
      GenerierungFlüsse;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 5) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 5);
      
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 6) := Clock;
      GenerierungRessourcen;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 6) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 6);
      
      AndereEbenen;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 7);
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 8);
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 9);
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 10);

      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 11) := Clock;
      KartenfelderBewerten;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 11) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => 11);
      
   end KartenGenerator;



   procedure GenerierungKartenart (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv) is
   begin

      Wert := Random (Gewählt);

      case GeneratorKarte (YAchseExtern, XAchseExtern) is -- Die Werte werden eingetragen, wenn Landmassen erzeugt werden
         when 1 .. 2 =>
            null;

         when 0 =>
            if YAchseExtern <= Karten.WeltkarteArray'First (2) + 3  or YAchseExtern >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 3 then
               if Wert > WahrscheinlichkeitenFürLand (Kartenart, 1) and Wert < WahrscheinlichkeitenFürLand (Kartenart, 2) then
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
                           
               elsif Wert >= WahrscheinlichkeitenFürLand (Kartenart, 2) then
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
                  GenerierungLandmasse (YPositionLandmasseExtern => YAchseExtern,
                                        XPositionLandmasseExtern => XAchseExtern);
                           
               else
                  null;
               end if;
                              
            else
               if Wert > WahrscheinlichkeitenFürLand (Kartenart, 3) and Wert < WahrscheinlichkeitenFürLand (Kartenart, 4) then
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
                                 
               elsif Wert >= WahrscheinlichkeitenFürLand (Kartenart, 4) then
                  Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
                  GenerierungLandmasse (YPositionLandmasseExtern => YAchseExtern,
                                        XPositionLandmasseExtern => XAchseExtern);
                                 
               else
                  null;
               end if;
            end if;

         when others =>
            if Wert >= WahrscheinlichkeitenFürLand (Kartenart, 5) then                           
               Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
                           
            else
               null;
            end if;
      end case;
      
   end GenerierungKartenart;

   
   
   procedure GenerierungLandmasse (YPositionLandmasseExtern, XPositionLandmasseExtern : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      YAchseEinsSchleife:
      for YÄnderungEinsSchleifenwert in -GrößeLandart (Kartenart) / 2 .. GrößeLandart (Kartenart) / 2 loop
         XAchseEinsSchleife:
         for XÄnderungEinsSchleifenwert in -GrößeLandart (Kartenart) / 2 .. GrößeLandart (Kartenart) / 2 loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => (0, YPositionLandmasseExtern, XPositionLandmasseExtern),
                                                                    ÄnderungExtern       => (0, YÄnderungEinsSchleifenwert, XÄnderungEinsSchleifenwert),
                                                                    ZusatzYAbstandExtern => 1); -- Hier muss <= geprüft werden, deswegen 1

            case KartenWert.Erfolgreich is
               when False =>
                  exit XAchseEinsSchleife;
                  
               when True =>         
                  Wert := Random (Gewählt);
                  GenerierungLandmasseÜberhang (YAchseExtern => KartenWert.YAchse,
                                                 XAchseExtern => KartenWert.XAchse,
                                                 GezogenExtern => Wert);
            end case;
            
         end loop XAchseEinsSchleife;
      end loop YAchseEinsSchleife;
      
      YAchseZweiSchleife: -- Funktioniert nicht mit Kontinenten bei kleinen Karten weil der Abstandswert zu groß ist! An Kartengrößen angepasste Werte anlegen, wie bei der Kartenanzeige.
      for YÄnderungZweiSchleifenwert in -FelderVonLandartZuLandart (Kartenart) .. FelderVonLandartZuLandart (Kartenart) loop
         XAchseZweiSchleife:
         for XÄnderungZweiSchleifenwert in -FelderVonLandartZuLandart (Kartenart) .. FelderVonLandartZuLandart (Kartenart) loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => (0, YPositionLandmasseExtern, XPositionLandmasseExtern),
                                                                    ÄnderungExtern       => (0, YÄnderungZweiSchleifenwert, XÄnderungZweiSchleifenwert),
                                                                    ZusatzYAbstandExtern => 1); -- Hier muss <= geprüft werden, deswegen 1
            
            case KartenWert.Erfolgreich is
               when False =>
                  exit XAchseZweiSchleife;
                  
               when True =>
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
   
   
   
   procedure GenerierungLandmasseÜberhang (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv; GezogenExtern : in Float) is
   begin
   
      if GezogenExtern >= WahrscheinlichkeitenFürLand (Kartenart, 6) and GeneratorKarte (YAchseExtern, XAchseExtern) = 0 then
         Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
         GeneratorKarte (YAchseExtern, XAchseExtern) := 1;

      elsif GezogenExtern >= WahrscheinlichkeitenFürLand (Kartenart, 7) then
         Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
         GeneratorKarte (YAchseExtern, XAchseExtern) := 1;
               
      else
         null;
      end if;
         
      
   end GenerierungLandmasseÜberhang;



   procedure GenerierungPangäa (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      if YAchseExtern = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2 and XAchseExtern = Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 then
         GenerierungLandmasse (YPositionLandmasseExtern => YAchseExtern,
                               XPositionLandmasseExtern => XAchseExtern);
        
      else
         Wert := Random (Gewählt);
         if Wert >= WahrscheinlichkeitenFürLand (Kartenart, 2) then
            Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund := 3;
            GeneratorKarte (YAchseExtern, XAchseExtern) := 1;
         
         else
            null;
         end if;
      end if;
      
   end GenerierungPangäa;



   procedure GenerierungKüstenSeeGewässer is
   begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                              
            case Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund is
               when 2 =>
                  ZweiteYAchseSchleife:
                  for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     ZweiteXAchseSchleife:
                     for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     
                        KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                ZusatzYAbstandExtern => 0);

                        case KartenWert.Erfolgreich is
                           when False =>
                              exit ZweiteYAchseSchleife;
                                
                           when True =>
                              case Karten.Weltkarte (0, KartenWert.YAchse, KartenWert.XAchse).Grund is
                                 when 3 =>
                                    Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund := 31;
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

      YAbstandEisschichtEinsSchleife:
      for YAchseEinsSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.WeltkarteArray'First (2) + 3 loop
         XAbstandEisschichtEinsSchleife:
         for XAchseEinsSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            GeneratorKarte (YAchseEinsSchleifenwert, XAchseEinsSchleifenwert) := 4;
            
         end loop XAbstandEisschichtEinsSchleife;
      end loop YAbstandEisschichtEinsSchleife;

      YAbstandEisschichtZweiSchleife:
      for YAchseZweiSchleifenwert in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 3 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAbstandEisschichtZweiSchleife:
         for XAchseZweiSchleifenwert in Karten.Weltkarte'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            GeneratorKarte (YAchseZweiSchleifenwert, XAchseZweiSchleifenwert) := 4;
            
         end loop XAbstandEisschichtZweiSchleife;
      end loop YAbstandEisschichtZweiSchleife;
            
      YAchseSchleife:
      for YAchseDreiSchleifenwert in Karten.WeltkarteArray'First (2) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseSchleife:
         for XAchseDreiSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            if Karten.Weltkarte (0, YAchseDreiSchleifenwert, XAchseDreiSchleifenwert).Grund < 3 or Karten.Weltkarte (0, YAchseDreiSchleifenwert, XAchseDreiSchleifenwert).Grund = 31 then
               GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) := True;

            else
               Wert := Random (Gewählt);
               if Wert <= KartengrundWahrscheinlichkeiten (Kartentemperatur, 4) and GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
                 and GeneratorKarte (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) /= 5 then
                  GenerierungLandschaftFelder (GrundExtern  => 4,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif Wert <= KartengrundWahrscheinlichkeiten (Kartentemperatur, 5) and GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False
                 and GeneratorKarte (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) /= 4 then
                  GenerierungLandschaftFelder (GrundExtern  => 5,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif Wert <= KartengrundWahrscheinlichkeiten (Kartentemperatur, 6) and GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False then
                  GenerierungLandschaftFelder (GrundExtern  => 6,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif Wert <= KartengrundWahrscheinlichkeiten (Kartentemperatur, 7) and GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False then
                  GenerierungLandschaftFelder (GrundExtern  => 7,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif Wert <= KartengrundWahrscheinlichkeiten (Kartentemperatur, 8) and GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False then
                  GenerierungLandschaftFelder (GrundExtern  => 8,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif Wert <= KartengrundWahrscheinlichkeiten (Kartentemperatur, 9) and GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False then
                  GenerierungLandschaftFelder (GrundExtern  => 9,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);

               elsif Wert <= KartengrundWahrscheinlichkeiten (Kartentemperatur, 10) and GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) = False then
                  GenerierungLandschaftFelder (GrundExtern  => 32,
                                               YAchseExtern => YAchseDreiSchleifenwert,
                                               XAchseExtern => XAchseDreiSchleifenwert);
                  
               else
                  GeneratorGrund (YAchseDreiSchleifenwert, XAchseDreiSchleifenwert) := True;
               end if;
            end if;            
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;         
         
   end GenerierungLandschaft;



   procedure GenerierungLandschaftFelder (GrundExtern : in GlobaleDatentypen.KartenGrund; YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      YAchseEinsSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeNullZuEins'Range loop
         XAchseEinsSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeNullZuEins'Range loop            
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => (0, YAchseExtern, XAchseExtern),
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                    ZusatzYAbstandExtern => 1);

            case KartenWert.Erfolgreich is
               when False =>
                  exit XAchseEinsSchleife;
                  
               when True =>
                  if Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund < 3 or Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Grund = 31 then
                     null;
                     
                  elsif YÄnderungSchleifenwert = 0 and XÄnderungSchleifenwert = 0 then
                     Karten.Weltkarte (0, KartenWert.YAchse, KartenWert.XAchse).Grund := GrundExtern;
                     GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) := True;
                     
                  else
                     Wert := Random (Gewählt);
                     if Wert > 0.50 and GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) = False then
                        if GrundExtern = 4 and GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) = 5 then
                           null;
                           
                        elsif GrundExtern = 5 and GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) = 4 then
                           null;
                           
                        else
                           Karten.Weltkarte (0, KartenWert.YAchse, KartenWert.XAchse).Grund := GrundExtern;
                           GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) := True;
                        end if;
                        
                     else
                        GeneratorGrund (KartenWert.YAchse, KartenWert.XAchse) := True;                       
                     end if;
                  end if;
            end case;

            case GrundExtern is
               when 6 | 7 => -- Hügel - Gebirge
                  null;
                  
               when others =>
                  GenerierungLandschaftHügel (YAchseExtern => KartenWert.YAchse,
                                               XAchseExtern => KartenWert.XAchse);
            end case;
            
         end loop XAchseEinsSchleife;
      end loop YAchseEinsSchleife;      

      case GrundExtern is
         when 4 | 5 => -- Tundra - Wüste
            YAchseZweiSchleife:
            for YÄnderungZweiSchleifenwert in GlobaleDatentypen.LoopRangeMinusZweiZuZwei'Range loop
               XAchseZweiSchleife:
               for XÄnderungZweiSchleifenwert in GlobaleDatentypen.LoopRangeMinusZweiZuZwei'Range loop
            
                  KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => (0, YAchseExtern, XAchseExtern),
                                                                          ÄnderungExtern       => (0, YÄnderungZweiSchleifenwert, XÄnderungZweiSchleifenwert),
                                                                          ZusatzYAbstandExtern => 1);

                  case KartenWert.Erfolgreich is
                     when False =>
                        exit XAchseZweiSchleife;
                  
                     when True =>
                        if GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) /= 0 then
                           null;
                                     
                        else
                           GeneratorKarte (KartenWert.YAchse, KartenWert.XAchse) := GlobaleDatentypen.Kartenfeld (GrundExtern);
                        end if;
                  end case;
            
               end loop XAchseZweiSchleife;
            end loop YAchseZweiSchleife;
            
         when others =>
            null;
      end case;
      
   end GenerierungLandschaftFelder;



   procedure GenerierungLandschaftHügel (YAchseExtern, XAchseExtern : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      HügelGebirgeUmgebung := 0;
      YAchseHügelSchleife:
      for YÄnderungHügelSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseHügelSchleife:
         for XÄnderungHügelSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop            
            
            KartenWertHügel := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => (0, YAchseExtern, XAchseExtern),
                                                                          ÄnderungExtern       => (0, YÄnderungHügelSchleifenwert, XÄnderungHügelSchleifenwert),
                                                                          ZusatzYAbstandExtern => 1);

            case KartenWertHügel.Erfolgreich is
               when False =>
                  exit XAchseHügelSchleife;
                  
               when True =>
                  if YÄnderungHügelSchleifenwert = 0 and XÄnderungHügelSchleifenwert = 0 then
                     null;
                                 
                  elsif Karten.Weltkarte (0, KartenWertHügel.YAchse, KartenWertHügel.XAchse).Grund = 6 or Karten.Weltkarte (0, KartenWertHügel.YAchse, KartenWertHügel.XAchse).Grund = 7
                    or Karten.Weltkarte (0, KartenWertHügel.YAchse, KartenWertHügel.XAchse).Hügel = True then
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
               Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Hügel := True;
                     
            else
               null;
            end if;
                  
         when 4 .. 7 =>
            Wert := Random (Gewählt);
            if Wert >= 0.66 then
               Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Hügel := True;
                     
            else
               null;
            end if;
                  
         when 8 =>
            Wert := Random (Gewählt);
            if Wert >= 0.33 then
               Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Hügel := True;
                     
            else
               null;
            end if;
                  
         when others =>                  
            Wert := Random (Gewählt);
            if Wert >= 0.95 then
               Karten.Weltkarte (0, YAchseExtern, XAchseExtern).Hügel := True;
                     
            else
               null;
            end if;
      end case;
      
   end GenerierungLandschaftHügel;
   


   procedure GenerierungFlüsse is
   begin
      
      YAchseEinsSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseEinsSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop            

            Wert := Random (Gewählt);
            if Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund < 3 or Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund = 31 then
               null;
                           
            elsif Wert >= WahrscheinlichkeitFluss then
               Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Fluss := 15;
               
            else
               YAchseZweiSchleife:
               for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  XAchseZweiSchleife:
                  for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  
                     KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                             ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                             ZusatzYAbstandExtern => 0);
                     
                     case KartenWert.Erfolgreich is
                        when False =>
                           exit XAchseZweiSchleife;
                           
                        when True =>
                           if Karten.Weltkarte (0, KartenWert.YAchse, KartenWert.YAchse).Fluss /= 0 and Wert >= WahrscheinlichkeitFluss / 2.50 then                        
                              Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Fluss := 15;

                           else
                              null;
                           end if;
                     end case;
                     
                  end loop XAchseZweiSchleife;
               end loop YAchseZweiSchleife;
            end if;

            case Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Fluss is
               when 0 =>
                  null;
                  
               when others =>
                  FlussBerechnung (YKoordinateExtern => YAchseSchleifenwert,
                                   XKoordinateExtern => XAchseSchleifenwert);
            end case;
         
         end loop XAchseEinsSchleife;
      end loop YAchseEinsSchleife;
      
   end GenerierungFlüsse;



   -- Hier scheint noch etwas nicht zu stimmen, nochmal drüber schauen oder gleich was besseres zusammenbasteln.
   procedure FlussBerechnung (YKoordinateExtern, XKoordinateExtern : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
                    
      Flusswert := 10_000;   
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => (0, YKoordinateExtern, XKoordinateExtern),
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                    ZusatzYAbstandExtern => 0);

            case KartenWert.Erfolgreich is
               when False =>
                  exit XAchseSchleife;

               when True =>
                  if XÄnderungSchleifenwert = -1 and YÄnderungSchleifenwert = 0 then
                     case Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss is
                        when 0 =>
                           Flusswert := Flusswert - 1_000;

                        when 16 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 23;
                     
                        when 18 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 22;

                        when 20 =>                     
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 21;

                        when 24 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 14;

                        when 26 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 15;

                        when 27 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 19;

                        when 28 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 17;
                     
                        when others =>
                           null;
                     end case;
                     Flusswert := Flusswert + 1_000;
               
                  elsif XÄnderungSchleifenwert = 1 and YÄnderungSchleifenwert = 0 then
                     case Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss is
                        when 0 =>
                           Flusswert := Flusswert - 100;

                        when 16 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 24;
                     
                        when 17 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 22;

                        when 19 =>                     
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 21;

                        when 23 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 14;

                        when 25 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 15;

                        when 27 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 20;

                        when 28 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 18;
                     
                        when others =>
                           null;
                     end case;
                     Flusswert := Flusswert + 100;
               
                  elsif YÄnderungSchleifenwert = -1 and XÄnderungSchleifenwert = 0 then
                     case Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss is
                        when 0 =>
                           Flusswert := Flusswert - 10;
                     
                        when 15 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 22;
                     
                        when 19 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 23;

                        when 20 =>                     
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 24;

                        when 21 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 14;

                        when 25 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 17;

                        when 26 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 18;

                        when 27 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 16;
                     
                        when others =>
                           null;
                     end case;
                     Flusswert := Flusswert + 10;
               
                  elsif YÄnderungSchleifenwert = 1 and XÄnderungSchleifenwert = 0 then
                     case Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss is
                        when 0 =>
                           Flusswert := Flusswert - 1;
                     
                        when 15 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 21;
                     
                        when 17 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 23;

                        when 18 =>                     
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 24;

                        when 22 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 14;

                        when 25 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 19;

                        when 26 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 20;

                        when 28 =>
                           Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss := 16;
                     
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
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 26;

         when 10_100 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 25;

         when 10_010 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 27;

         when 10_001 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 28;

         when 11_010 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 20;

         when 11_001 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 18;

         when 11_110 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 21;

         when 11_101 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 22;

         when 11_111 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 14;

         when 10_110 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 19;

         when 10_101 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 17;

         when 10_111 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 23;

         when 10_011 =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 16;
         
         when others =>
            Karten.Weltkarte (0, YKoordinateExtern, XKoordinateExtern).Fluss := 15;
      end case;
      
   end FlussBerechnung;
   
   
   
   procedure GenerierungRessourcen is -- Die Verteilung mehrmals loopen lassen? Einmal von oben zur mitte, von unten zur mitte, von mitte nach oben und von mitte nach unten?
   begin

      while NochVerteilbareRessourcen /= 0 loop      
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               case NochVerteilbareRessourcen is
                  when 0 =>
                     return;
                  
                  when others =>
                     Wert := Random (Gewählt);
                     if Wert >= 0.98 and (Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund = 2 or Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund = 31) then
                        if Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund = 2 and Wert > 0.99 then
                           Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := 30;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                           
                        else
                           Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := 29;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                        end if;
                        
                     elsif Wert <= 0.05 and Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund /= 2 and Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Grund /= 31 then
                        if Wert < 0.01 then
                           Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := 11;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                        elsif Wert < 0.02 then
                           Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := 12;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                        elsif Wert < 0.03 then
                           Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := 13;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                        elsif Wert < 0.04 then
                           Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := 33;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                           
                           
                        else
                           Karten.Weltkarte (0, YAchseSchleifenwert, XAchseSchleifenwert).Ressource := 10;
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
         
         YAchseHimmelSchleife:
         for YAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseHimmelSchleife:
            for XAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               Karten.Weltkarte (1, YAchseHimmelSchleifenwert, XAchseHimmelSchleifenwert).Grund := 37;
               
            end loop XAchseHimmelSchleife;
         end loop YAchseHimmelSchleife;
         
         Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 8) := Clock;
         
      end Himmel;
      
      
      
      task body Weltraum is
      begin

         Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 9) := Clock;

         YAchseWeltraumSchleife:
         for YAchseWeltraumSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseWeltraumSchleife:
            for XAchseWeltraumSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop

               Karten.Weltkarte (2, YAchseWeltraumSchleifenwert, XAchseWeltraumSchleifenwert).Grund := 38;
               
            end loop XAchseWeltraumSchleife;
         end loop YAchseWeltraumSchleife;

         Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 9) := Clock;
         
      end Weltraum;
      
      

      task body UnterwasserUnterirdisch is
      begin
         
         Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 10) := Clock;
         
         YAchseUnterwasserSchleife:
         for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseUnterwasserSchleife:
            for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               case Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund is
                  when 1 =>
                     Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund;
                     
                  when 2 =>
                     Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := 41;
                     
                  when 31 =>
                     Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := 42;
                     
                  when 7 =>
                     Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := 40;
                     
                  when others =>
                     Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Grund := 35;
               end case;

               case Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Ressource is
                  when 10 .. 13 | 29 .. 30 | 33 =>
                     Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Ressource := Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Ressource;
                       
                  when others =>
                     null;
               end case;

               case Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Fluss is
                  when 0 =>
                     null;
                     
                  when others =>
                     Karten.Weltkarte (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Fluss := Karten.Weltkarte (0, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert).Fluss;
               end case;
               
            end loop XAchseUnterwasserSchleife;
         end loop YAchseUnterwasserSchleife;
         
         Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 10) := Clock;
         
      end UnterwasserUnterirdisch;
      
      
      
      task body PlanetenInneres is
      begin
         
         Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 11) := Clock;
         
         YAchseInneresSchleife:
         for YAchseInneresSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseInneresSchleife:
            for XAchseInneresSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               Karten.Weltkarte (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert).Grund := 39;
               
            end loop XAchseInneresSchleife;
         end loop YAchseInneresSchleife;
         
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

         YAchseHimmelSchleife:
         for YAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (2) + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 1 loop
            XAchseHimmelSchleife:
            for XAchseHimmelSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               WerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                    KoordinatenExtern => (1, YAchseHimmelSchleifenwert, XAchseHimmelSchleifenwert));
               
            end loop XAchseHimmelSchleife;
         end loop YAchseHimmelSchleife;
         
      end Himmel;



      task body Weltraum is
      begin
         
         YAchseWeltraumSchleife:
         for YAchseWeltraumSchleifenwert in Karten.WeltkarteArray'First (2) + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 1 loop
            XAchseWeltraumSchleife:
            for XAchseWeltraumSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               WerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                    KoordinatenExtern => (2, YAchseWeltraumSchleifenwert, XAchseWeltraumSchleifenwert));
               
            end loop XAchseWeltraumSchleife;
         end loop YAchseWeltraumSchleife;
         
      end Weltraum;
      
      
      
      task body UnterwasserUnterirdisch is
      begin
         
         YAchseUnterwasserSchleife:
         for YAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (2) + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 1 loop
            XAchseUnterwasserSchleife:
            for XAchseUnterwasserSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               WerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                    KoordinatenExtern => (-1, YAchseUnterwasserSchleifenwert, XAchseUnterwasserSchleifenwert));
               
            end loop XAchseUnterwasserSchleife;
         end loop YAchseUnterwasserSchleife;
         
      end UnterwasserUnterirdisch;
      
      
      
      task body PlanetenInneres is
      begin
         
         YAchseInneresSchleife:
         for YAchseInneresSchleifenwert in Karten.WeltkarteArray'First (2) + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 1 loop
            XAchseInneresSchleife:
            for XAchseInneresSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
               
               WerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                    KoordinatenExtern => (-2, YAchseInneresSchleifenwert, XAchseInneresSchleifenwert));
               
            end loop XAchseInneresSchleife;
         end loop YAchseInneresSchleife;
         
      end PlanetenInneres;


      
   begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) + 1 .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 1 loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            WerteFestlegen.KartenfelderBewerten (GenerierungExtern => True,
                                                 KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
   
   end KartenfelderBewerten;



   procedure Chaos is
   begin
            
      EAchseSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                        
               if YAchseSchleifenwert = Karten.Weltkarte'First (2) or YAchseSchleifenwert = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
                  Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert).Grund := 1;
               
               else
                  Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert).Grund := ZufallsGeneratoren.Chaoskarte;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;

      KartenfelderBewerten;
      
   end Chaos;

end KartenGenerator;
