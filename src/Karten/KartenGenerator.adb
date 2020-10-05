package body KartenGenerator is

   procedure KartenGenerator is
   begin

      Reset (Gewählt);

      NochVerteilbareRessourcen := Karten.Kartengrößen (Karten.Kartengröße).Ressourcenmenge;
      GrößeLandart := (6, 15, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 10); -- Inseln, Kontinente, Pangäa
      -- Größe Landart bekommt hier erst Werte, da sonst die Werte für Pangäa nicht bekannt wären.
      GeneratorKarte := (others => (others => (0)));
      Zeit := (0, 0, 0, 0, 0, 0, 0);
      Test := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße * Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
      
      YAchseSchleife:
      for Y in Karten.Karten'Range (1) loop
         XAchseSchleife:
         for X in Karten.Karten'Range (2) loop
                        
            if Y > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
               Karten.Karten (Y, X).Grund := -2;
               exit YAchseSchleife;
               
            elsif X > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
               Karten.Karten (Y, X).Grund := -1;
               exit XAchseSchleife;   
               
            elsif Y = Karten.Karten'First (1) or Y = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
               Karten.Karten (Y, X).Grund := 1;
               
            else
               case Karten.Karten (Y, X).Grund is
                  when 0 =>
                     Karten.Karten (Y, X).Grund := 2;

                  when others =>
                     null;
               end case;
               GenerierungKartenart (Y, X);
            end if;

            Zeit (1) := Zeit (1) + 1;
            Put_Line (Item => "Berechne11: " & Zeit (1)'Wide_Wide_Image & "/" & Test'Wide_Wide_Image);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
            
      GenerierungKüstenSeeGewässer;

      GenerierungKartentemperatur;
      GenerierungLandschaft;
      GenerierungFlüsse;
      GenerierungRessourcen;
      
   end KartenGenerator;



   procedure GenerierungKartenart (Y, X : in Integer) is
   begin

      Wert := Random (Gewählt);

      case GeneratorKarte (Y, X) is
         when 1 .. 2 =>
            null;

         when 0 =>
            if Y <= Karten.Karten'First (1) + 3  or Y >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 3 then
               if Wert > WahrscheinlichkeitenFürLand (Kartenart, 1) and Wert < WahrscheinlichkeitenFürLand (Kartenart, 2) then
                  Karten.Karten (Y, X).Grund := 3;
                           
               elsif Wert >= WahrscheinlichkeitenFürLand (Kartenart, 2) then
                  Karten.Karten (Y, X).Grund := 3;
                  GenerierungLandmasse (YPositionLandmasse => Y, XPositionLandmasse => X);
                           
               else
                  null;
               end if;
                              
            else
               if Wert > WahrscheinlichkeitenFürLand (Kartenart, 3) and Wert < WahrscheinlichkeitenFürLand (Kartenart, 4) then
                  Karten.Karten (Y, X).Grund := 3;
                                 
               elsif Wert >= WahrscheinlichkeitenFürLand (Kartenart, 4) then
                  Karten.Karten (Y, X).Grund := 3;
                  GenerierungLandmasse (YPositionLandmasse => Y, XPositionLandmasse => X);
                                 
               else
                  null;
               end if;
            end if;

         when others =>
            if Wert >= WahrscheinlichkeitenFürLand (Kartenart, 5) then                           
               Karten.Karten (Y, X).Grund := 3;
                           
            else
               null;
            end if;
      end case;
      
   end GenerierungKartenart;

   
   
   procedure GenerierungLandmasse (YPositionLandmasse, XPositionLandmasse : in Integer) is
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

            case KartenWert.YWert is
               when -1_000_000 =>
                  exit XAchseSchleife;
                  
               when others =>         
                  Wert := Random (Gewählt);
                  GenerierungLandmasseÜberhang (YAchse  => KartenWert.YWert,
                                                XAchse  => KartenWert.XWert,
                                                Gezogen => Wert);
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      YAchseZweiSchleife: -- Funktioniert nicht mit Kontinenten bei kleinen Karten weil der Abstandswert zu groß ist!
      for YÄnderung in -FelderVonLandartZuLandart (Kartenart) .. FelderVonLandartZuLandart (Kartenart) loop
         XAchseZweiSchleife:
         for XÄnderung in -FelderVonLandartZuLandart (Kartenart) .. FelderVonLandartZuLandart (Kartenart) loop
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => YPositionLandmasse,
                                                              XKoordinate    => XPositionLandmasse,
                                                              YÄnderung      => YÄnderung,
                                                              XÄnderung      => XÄnderung,
                                                              ZusatzYAbstand => 1); -- Hier muss <= geprüft werden, deswegen 1
            case KartenWert.YWert is
               when -1_000_000 =>
                  exit XAchseZweiSchleife;
                  
               when others =>
                  case GeneratorKarte (KartenWert.YWert, KartenWert.XWert) is
                     when 1 .. 2 =>
                        null;
                        
                     when others =>
                        GeneratorKarte (KartenWert.YWert, KartenWert.XWert) := 3;                           
                  end case;
            end case;
                    
         end loop XAchseZweiSchleife; 
      end loop YAchseZweiSchleife;
      
   end GenerierungLandmasse;
   
   
   
   procedure GenerierungLandmasseÜberhang (YAchse, XAchse : in Integer; Gezogen : in Float) is
   begin
   
      if Gezogen >= WahrscheinlichkeitenFürLand (Kartenart, 6) and GeneratorKarte (YAchse, XAchse) = 0 then
         Karten.Karten (YAchse, XAchse).Grund := 3;
         GeneratorKarte (YAchse, XAchse) := 1;

      elsif Gezogen >= WahrscheinlichkeitenFürLand (Kartenart, 7) then
         Karten.Karten (YAchse, XAchse).Grund := 3;
         GeneratorKarte (YAchse, XAchse) := 1;
               
      else
         null;
      end if;
         
      
   end GenerierungLandmasseÜberhang;



   procedure GenerierungKüstenSeeGewässer is
   begin

      Test := (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - 2 * Eisrand) * Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
      
      YAchseSchleife:
      for YPosition in Karten.Karten'First (1) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseSchleife:
         for XPosition in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                              
            case Karten.Karten (YPosition, XPosition).Grund is
               when 2 =>
                  ZweiteYAchseSchleife:
                  for YÄnderung in -1 .. 1 loop
                     ZweiteXAchseSchleife:
                     for XÄnderung in -1 .. 1 loop
                     
                        KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => YPosition,
                                                                          XKoordinate    => XPosition,
                                                                          YÄnderung      => YÄnderung,
                                                                          XÄnderung      => XÄnderung,
                                                                          ZusatzYAbstand => 0);

                        case KartenWert.YWert is
                           when -1_000_000 =>
                              exit ZweiteYAchseSchleife;
                                
                           when others =>
                              case Karten.Karten (KartenWert.YWert, KartenWert.XWert).Grund is
                                 when 3 =>
                                    Karten.Karten (YPosition, XPosition).Grund := 31;
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

            Zeit (2) := Zeit (2) + 1;
            Put_Line (Item => "Berechne22: " & Zeit (2)'Wide_Wide_Image & "/" & Test'Wide_Wide_Image);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungKüstenSeeGewässer;
   
   
   
   procedure GenerierungKartentemperatur is
   begin

      EisWahrscheinlichkeitReduzierungspunkt := (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 6, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 8, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 10);
      GeneratorKarte := (others => (others => (0)));

      for A in Karten.Karten'First (1) .. Karten.Karten'First (1) + FelderVonTemperaturZuTemperatur + Eisrand loop
         for B in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            GeneratorKarte (A, B) := 4;
            
         end loop;
      end loop;
      
      for C in Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - FelderVonTemperaturZuTemperatur - Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         for D in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            GeneratorKarte (C, D) := 4;
            
         end loop;
      end loop;
      
      YAchseSchleife:
      for Y in Karten.Karten'First (1) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop -- Nur bis halb loopen und dann mit reverse entgegenkommen?
         XAchseSchleife:
         for X in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            if Y = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
               exit YAchseSchleife;
               
            elsif Y = Karten.Karten'First (1) then
               null;                                 
                              
            elsif Karten.Karten (Y, X).Grund < 3 or Karten.Karten (Y, X).Grund = 31 then
               null;
               
               -- 4 = Tundra, 5 = Wüste
            elsif Y <= EisWahrscheinlichkeitReduzierungspunkt (Kartentemperatur) or Y >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - EisWahrscheinlichkeitReduzierungspunkt (Kartentemperatur) then
               Wert := Random (Gewählt);
               if Wert > WahrscheinlichkeitenFürLandart (Kartentemperatur, 1) then
                  Karten.Karten (Y, X).Grund := 4;
                  GenerierungTemperaturAbstand (YPosition => Y,
                                                XPosition => X,
                                                Geländeart => 4);
                     
               else
                  null;
               end if;
               
            else
               Wert := Random (Gewählt);
               if Wert > WahrscheinlichkeitenFürLandart (Kartentemperatur, 2) and GeneratorKarte (Y, X) /= 5 then
                  Karten.Karten (Y, X).Grund := 4;
                  GenerierungTemperaturAbstand (YPosition => Y,
                                                XPosition => X,
                                                Geländeart => 4);
                  
               elsif Wert > WahrscheinlichkeitenFürLandart (Kartentemperatur, 3) and GeneratorKarte (Y, X) /= 4 then
                  Karten.Karten (Y, X).Grund := 5;
                  GenerierungTemperaturAbstand (YPosition => Y,
                                                XPosition => X,
                                                Geländeart => 5);
                  
               else
                  null;
               end if;
            end if;

            Zeit (3) := Zeit (3) + 1;
            Put_Line (Item => "Berechne33: " & Zeit (3)'Wide_Wide_Image & "/" & Test'Wide_Wide_Image);
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungKartentemperatur;



   procedure GenerierungTemperaturAbstand (YPosition, XPosition, Geländeart : in Integer) is
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

            case KartenWert.YWert is
               when -1_000_000 =>
                  exit XAchseSchleife;
                  
               when others =>
                  case GeneratorKarte (KartenWert.YWert, KartenWert.XWert) is
                     when 0 =>
                        GenerierungTemperaturZusatz (YAchse     => KartenWert.YWert,
                                                     XAchse     => KartenWert.XWert,
                                                     Geländeart => Geländeart);
                        
                     when others =>
                        null;
                  end case;
            end case;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
   
   end GenerierungTemperaturAbstand;
   
   
   
   procedure GenerierungTemperaturZusatz (YAchse, XAchse, Geländeart : in Integer) is
   begin

      if Karten.Karten (YAchse, XAchse).Grund < 3 or Karten.Karten (YAchse, XAchse).Grund = 31 then
         null;
         
      elsif GeneratorKarte (YAchse, XAchse) = 0 then
         GeneratorKarte (YAchse, XAchse) := Geländeart;
            
      else
         null;
      end if;         
      
   end GenerierungTemperaturZusatz;

   
   
   procedure GenerierungLandschaft is
   begin
      
      GenerierungLandschaftZusatz;
      
      YAchseSchleife:
      for Y in Karten.Karten'First (1) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseSchleife:
         for X in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            if Karten.Karten (Y, X).Grund < 3 or Karten.Karten (Y, X).Grund = 31 then
               null;
               
            elsif Karten.Karten (Y, X).Grund = 5 then
               Wert := Random (Gewählt);
               if Wert >= WahrscheinlichkeitFürLandschaft (6) then
                  Karten.Karten (Y, X).Hügel := True;
                  
               else
                  null;
               end if;

            elsif Karten.Karten (Y, X).Grund = 4 then
               Wert := Random (Gewählt);
               if Wert >= WahrscheinlichkeitFürLandschaft (6) then
                  Karten.Karten (Y, X).Hügel := True;
                  
               else
                  null;
               end if;
               
            else
               Wert := Random (Gewählt);
               if Wert >= WahrscheinlichkeitFürLandschaft (6) then
                  Karten.Karten (Y, X).Grund := 6;
                  Karten.Karten (Y, X).Hügel := True;
                  
               elsif Wert >= WahrscheinlichkeitFürLandschaft (7) then
                  Karten.Karten (Y, X).Grund := 7;
                  
               elsif Wert >= WahrscheinlichkeitFürLandschaft (8) and GeneratorKarte (Y, X) = 0 then
                  Karten.Karten (Y, X).Grund := 8;
                  
               elsif Wert >= WahrscheinlichkeitFürLandschaft (9) and GeneratorKarte (Y, X) = 0 then
                  Karten.Karten (Y, X).Grund := 9;
                  
               elsif Wert >= WahrscheinlichkeitFürLandschaft (10) and GeneratorKarte (Y, X) = 0 then
                  Karten.Karten (Y, X).Grund := 32;
                  
               else
                  null;                  
               end if;
            end if;

            Zeit (4) := Zeit (4) + 1;
            Put_Line (Item => "Berechne44: " & Zeit (4)'Wide_Wide_Image & "/" & Test'Wide_Wide_Image);
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;         
         
   end GenerierungLandschaft;



   procedure GenerierungLandschaftZusatz is -- Den Teil genauso zusammenfassen wie der Abstand der Inseln, sonst wird nur unnötig geloopt
   begin
      
      GeneratorKarte := (others => (others => (0)));

      YAchseSchleife:
      for Y in Karten.Karten'First (1) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseSchleife:
         for X in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                     
            case Karten.Karten (Y, X).Grund is
               when 4 | 5 =>
                  YAchseSchleifeZwei:
                  for A in -Abstand .. Abstand loop
                     XAchseSchleifeZwei:
                     for B in -Abstand .. Abstand loop

                        KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => Y,
                                                                          XKoordinate    => X,
                                                                          YÄnderung      => A,
                                                                          XÄnderung      => B,
                                                                          ZusatzYAbstand => 1);

                        case KartenWert.YWert is
                           when -1_000_000 =>
                              exit XAchseSchleifeZwei;
                           
                           when others =>             
                              GeneratorKarte (KartenWert.YWert, KartenWert.XWert) := 1;
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
      for Y in Karten.Karten'First (1) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseSchleife:
         for X in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop            

            Wert := Random (Gewählt);
            if Karten.Karten (Y, X).Grund < 3 or Karten.Karten (Y, X).Grund = 31 then
               null;
                           
            elsif Wert >= WahrscheinlichkeitFluss then
               Karten.Karten (Y, X).Fluss := 15; -- Hier nach die Flussberechung einbauen? Müsste doch schneller sein und mit der jetzigen Lösung auch funktionieren.
               
            else
               YAchseSchleifeZwei:
               for A in -1 .. 1 loop
                  XAchseSchleifeZwei:
                  for B in -1 .. 1 loop
                  
                     KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => Y,
                                                                       XKoordinate    => X,
                                                                       YÄnderung      => A,
                                                                       XÄnderung      => B,
                                                                       ZusatzYAbstand => 0);

                     case KartenWert.YWert is
                        when -1_000_000 =>
                           exit XAchseSchleifeZwei;
                           
                        when others =>
                           if Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss /= 0 and Wert >= WahrscheinlichkeitFluss / 2.00 then                        
                              Karten.Karten (Y, X).Fluss := 15; -- Hier nach die Flussberechung einbauen? Müsste doch schneller sein und mit der jetzigen Lösung auch funktionieren.

                           else
                              null;
                           end if;
                     end case;
                     
                  end loop XAchseSchleifeZwei;
               end loop YAchseSchleifeZwei;
            end if;

            Zeit (5) := Zeit (5) + 1;
            Put_Line (Item => "Berechne55: " & Zeit (5)'Wide_Wide_Image & "/" & Test'Wide_Wide_Image);
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      FlussBerechnung;
      
   end GenerierungFlüsse;



   procedure FlussBerechnung is -- Schneller wenn ich es mit der Ressourcenverteilung zusammenführe? -- Außerdem scheint hier noch etwas nicht zu stimmen, nochmal drüber schauen oder gleich was besseres zusammenbasteln.
   begin

      YSchleife:
      for YKoordinate in Karten.Karten'First (1) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XSchleife:
         for XKoordinate in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop

            case Karten.Karten (YKoordinate, XKoordinate).Fluss is
               when 0 =>
                  null;
                  
               when others =>         
                  Flusswert := 10000;   
                  YAchseSchleife:
                  for YÄnderung in -1 .. 1 loop
                     XAchseSchleife:
                     for XÄnderung in -1 .. 1 loop

                        KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => YKoordinate,
                                                                          XKoordinate    => XKoordinate,
                                                                          YÄnderung      => YÄnderung,
                                                                          XÄnderung      => XÄnderung,
                                                                          ZusatzYAbstand => 0);

                        case KartenWert.YWert is
                           when -1_000_000 =>
                              exit XAchseSchleife;

                           when others =>
                              if XÄnderung = -1 and YÄnderung = 0 then
                                 case Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss is
                                 when 0 =>
                                    Flusswert := Flusswert - 1000;

                                 when 16 =>
                                    Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 23;
                     
                                 when 18 =>
                                    Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 22;

                                 when 20 =>                     
                                    Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 21;

                                 when 24 =>
                                    Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 14;

                                 when 26 =>
                                    Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 15;

                                 when 27 =>
                                    Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 19;

                                 when 28 =>
                                    Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 17;
                     
                                 when others =>
                                    null;
                                 end case;
                                 Flusswert := Flusswert + 1000;
               
                              elsif XÄnderung = 1 and YÄnderung = 0 then
                                 case Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss is
                                    when 0 =>
                                       Flusswert := Flusswert - 100;

                                    when 16 =>
                                       Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 24;
                     
                                    when 17 =>
                                       Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 22;

                                    when 19 =>                     
                                       Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 21;

                                    when 23 =>
                                       Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 14;

                                    when 25 =>
                                       Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 15;

                                    when 27 =>
                                       Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 20;

                                    when 28 =>
                                       Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 18;
                     
                                    when others =>
                                       null;
                                 end case;
                                 Flusswert := Flusswert + 100;
               
                           elsif YÄnderung = -1 and XÄnderung = 0 then
                                 case Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss is
                                 when 0 =>
                                    Flusswert := Flusswert - 10;
                     
                                 when 15 =>
                                    Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 22;
                     
                                 when 19 =>
                                    Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 23;

                                 when 20 =>                     
                                    Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 24;

                                 when 21 =>
                                    Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 14;

                                 when 25 =>
                                    Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 17;

                                 when 26 =>
                                    Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 18;

                                 when 27 =>
                                    Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 16;
                     
                                 when others =>
                                    null;
                                 end case;
                                 Flusswert := Flusswert + 10;
               
                              elsif YÄnderung = 1 and XÄnderung = 0 then
                                 case Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss is
                                    when 0 =>
                                       Flusswert := Flusswert - 1;
                     
                                    when 15 =>
                                       Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 21;
                     
                                    when 17 =>
                                       Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 23;

                                    when 18 =>                     
                                       Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 24;

                                    when 22 =>
                                       Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 14;

                                    when 25 =>
                                       Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 19;

                                    when 26 =>
                                       Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 20;

                                    when 28 =>
                                       Karten.Karten (KartenWert.YWert, KartenWert.XWert).Fluss := 16;
                     
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
                        Karten.Karten (YKoordinate, XKoordinate).Fluss := 26;

                     when 10100 =>
                        Karten.Karten (YKoordinate, XKoordinate).Fluss := 25;

                     when 10010 =>
                        Karten.Karten (YKoordinate, XKoordinate).Fluss := 27;

                     when 10001 =>
                        Karten.Karten (YKoordinate, XKoordinate).Fluss := 28;

                     when 11010 =>
                        Karten.Karten (YKoordinate, XKoordinate).Fluss := 20;

                     when 11001 =>
                        Karten.Karten (YKoordinate, XKoordinate).Fluss := 18;

                     when 11110 =>
                        Karten.Karten (YKoordinate, XKoordinate).Fluss := 21;

                     when 11101 =>
                        Karten.Karten (YKoordinate, XKoordinate).Fluss := 22;

                     when 11111 =>
                        Karten.Karten (YKoordinate, XKoordinate).Fluss := 14;

                     when 10110 =>
                        Karten.Karten (YKoordinate, XKoordinate).Fluss := 19;

                     when 10101 =>
                        Karten.Karten (YKoordinate, XKoordinate).Fluss := 17;

                     when 10111 =>
                        Karten.Karten (YKoordinate, XKoordinate).Fluss := 23;

                     when 10011 =>
                        Karten.Karten (YKoordinate, XKoordinate).Fluss := 16;
         
                     when others =>
                        Karten.Karten (YKoordinate, XKoordinate).Fluss := 15;
                  end case;
            end case;

            Zeit (6) := Zeit (6) + 1;
            Put_Line (Item => "Berechne66: " & Zeit (6)'Wide_Wide_Image & "/" & Test'Wide_Wide_Image);
         
         end loop XSchleife;
      end loop YSchleife;
      
   end FlussBerechnung;
   
   
   
   procedure GenerierungRessourcen is -- Die Verteilung mehrmals loopen lassen? Einmal von oben zur mitte, von unten zur mitte, von mitte nach oben und von mitte nach unten?
   begin

      while NochVerteilbareRessourcen /= 0 loop      
         YAchseSchleife:
         for Y in Karten.Karten'First (1) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
            XAchseSchleife:
            for X in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               case NochVerteilbareRessourcen is
                  when 0 =>
                     return;
                  
                  when others =>
                     Wert := Random (Gewählt);
                     if Wert >= 0.98 and (Karten.Karten (Y, X).Grund = 2 or Karten.Karten (Y, X).Grund = 31) then
                        if Karten.Karten (Y, X).Grund = 2 and Wert > 0.99 then
                           Karten.Karten (Y, X).Ressource := 30;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                           
                        else
                           Karten.Karten (Y, X).Ressource := 29;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                        end if;
                        
                     elsif Wert <= 0.05 and Karten.Karten (Y, X).Grund /= 2 and Karten.Karten (Y, X).Grund /= 31 then
                        if Wert < 0.01 then
                           Karten.Karten (Y, X).Ressource := 11;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                        elsif Wert < 0.02 then
                           Karten.Karten (Y, X).Ressource := 12;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                        elsif Wert < 0.03 then
                           Karten.Karten (Y, X).Ressource := 13;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                      

                        elsif Wert < 0.04 then
                           Karten.Karten (Y, X).Ressource := 33;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;                           
                           
                        else
                           Karten.Karten (Y, X).Ressource := 10;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                        end if;
                        
                     else
                        null;
                     end if;
               end case;

               Zeit (7) := Zeit (7) + 1;
               Put_Line (Item => "Berechne77: " & Zeit (7)'Wide_Wide_Image & "/" & Test'Wide_Wide_Image);
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop;
      
   end GenerierungRessourcen;

end KartenGenerator;
