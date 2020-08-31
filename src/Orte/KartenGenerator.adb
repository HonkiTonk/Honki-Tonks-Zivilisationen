package body KartenGenerator is

   procedure KartenGenerator is -- Überall noch die XAchsen Ende zu XAchsen Anfang und umgekehrt wie in Cursor/Einheitensystem einbauen
   begin

      Reset (Gewählt);

      NochVerteilbareRessourcen := Karten.Kartengrößen (Karten.Kartengröße).Ressourcenmenge;
      GrößeLandart := (6, 15, Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 4); -- Inseln, Kontinente, Pangäa
      GeneratorKarte := (others => (others => (0)));
      
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
               Karten.Karten (Y, X).Grund := 2;
               GenerierungKartenart (Y, X);
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
            
      GenerierungKüstenSeeGewässer;

      GenerierungKartentemperatur;
      GenerierungLandschaft;
      -- GenerierungFlüsse;
      GenerierungRessourcen;
      
   end KartenGenerator;



   procedure GenerierungKartenart (Y, X : in Integer) is
   begin
                                
      if GeneratorKarte (Y, X) = 1 or GeneratorKarte (Y, X) = 2 then
         null;           
               
      else               
         Wert := Random (Gewählt);
         if GeneratorKarte (Y, X) = 0 then
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
                           
         else
            if Wert >= WahrscheinlichkeitenFürLand (Kartenart, 5) then                           
               Karten.Karten (Y, X).Grund := 3;
                           
            else
               null;
            end if;
         end if;   
      end if;
      
   end GenerierungKartenart;
   
   
   
   procedure GenerierungLandmasse (YPositionLandmasse, XPositionLandmasse : in Integer) is
   begin
      
      YAchseSchleife:
      for Y in -GrößeLandart (Kartenart) / 2 .. GrößeLandart (Kartenart) / 2 loop
         XAchseSchleife:
         for X in -GrößeLandart (Kartenart) / 2 .. GrößeLandart (Kartenart) / 2 loop
         
            Wert := Random (Gewählt); 
            if YPositionLandmasse + Y <= Karten.Karten'First (1) or YPositionLandmasse + Y >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
               null;
            
            elsif XPositionLandmasse + X < Karten.Karten'First (2) then
               Überhang := XPositionLandmasse + X + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
               GenerierungLandmasseÜberhang (YAchse => YPositionLandmasse + Y, XAchse => Überhang, Gezogen => Wert);
               
            elsif XPositionLandmasse + X > Karten.Karten'Last (2) then
               Überhang := XPositionLandmasse + X - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;                  
               GenerierungLandmasseÜberhang (YAchse => YPositionLandmasse + Y, XAchse => Überhang, Gezogen => Wert);
               
            else
               GenerierungLandmasseÜberhang (YAchse => YPositionLandmasse + Y, XAchse => XPositionLandmasse + X, Gezogen => Wert);
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      YAchseGeneratorKarteSchleife:
      for Y in GeneratorKarte'First (1) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
         XAchseGeneratorKarteSchleife:
         for X in GeneratorKarte'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            if Y = Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
               return;
               
            elsif Y = GeneratorKarte'First (1) then
               exit XAchseGeneratorKarteSchleife;

            elsif GeneratorKarte (Y, X) = 1 then
               YAchseZweiSchleife:
               for A in -FelderVonLandartZuLandart (Kartenart) .. FelderVonLandartZuLandart (Kartenart) loop
                  XAchseZweiSchleife:
                  for B in -FelderVonLandartZuLandart (Kartenart) .. FelderVonLandartZuLandart (Kartenart) loop
                  
                     if Y + A <= Karten.Karten'First (1) or Y + A >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
                        null;
                        
                     elsif X + B < Karten.Karten'First (2) then
                        Überhang := X + B + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                        GeneratorKarte (Y + A, Überhang) := 3;
                          
                     elsif X + B > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
                        Überhang := X + B - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                        GeneratorKarte (Y + A, Überhang) := 3;                          
                        
                     elsif GeneratorKarte (Y + A, X + B) = 1 or GeneratorKarte (Y + A, X + B) = 2 then
                        null;
                        
                     else
                        GeneratorKarte (Y + A, X + B) := 3;                           
                     end if;
                    
                  end loop XAchseZweiSchleife; 
               end loop YAchseZweiSchleife;
               
            else
               null;
            end if;                  
               
         end loop XAchseGeneratorKarteSchleife;
      end loop YAchseGeneratorKarteSchleife;
      
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
         GeneratorKarte (YAchse, XAchse) := 2;
      end if;
         
      
   end GenerierungLandmasseÜberhang;



   procedure GenerierungKüstenSeeGewässer is
   begin
      
      YAchseSchleife:
      for Y in Karten.Karten'First (1) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseSchleife:
         for X in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                              
            if Karten.Karten (Y, X).Grund = 2 then
               ZweiteYAchseSchleife:
               for A in -1 .. 1 loop
                  ZweiteXAchseSchleife:
                  for B in -1 .. 1 loop
                     
                     if Y + A >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
                        exit ZweiteYAchseSchleife;

                     elsif Y + A < Karten.Karten'First (1) then
                        exit ZweiteYAchseSchleife;
                        
                     elsif X + B < Karten.Karten'First (2) then
                        Überhang := X + B + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                        if Karten.Karten (Y + A, Überhang).Grund = 3 then
                           Karten.Karten (Y, X).Grund := 31;
                           exit ZweiteYAchseSchleife;
                           
                        else
                           null;
                        end if;
                        
                     elsif X + B > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
                        Überhang := X + B - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
                        if Karten.Karten (Y + A, Überhang).Grund = 3 then
                           Karten.Karten (Y, X).Grund := 31;
                           exit ZweiteYAchseSchleife;
                           
                        else
                           null;
                        end if;
                        
                     elsif Karten.Karten (Y + A, X + B).Grund = 3 then
                        Karten.Karten (Y, X).Grund := 31;
                        exit ZweiteYAchseSchleife;
                        
                     else
                        null;
                     end if;
                     
                  end loop ZweiteXAchseSchleife;
               end loop ZweiteYAchseSchleife;
               
            else
               null;
            end if;
            
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
      for Y in Karten.Karten'First (1) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
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
                  GenerierungTemperaturAbstand (YPosition => Y, XPosition => X, Geländeart => 4);
                     
               else
                  null;
               end if;
               
            else
               Wert := Random (Gewählt);
               if Wert > WahrscheinlichkeitenFürLandart (Kartentemperatur, 2) and GeneratorKarte (Y, X) /= 5 then
                  Karten.Karten (Y, X).Grund := 4;
                  GenerierungTemperaturAbstand (YPosition => Y, XPosition => X, Geländeart => 4);
                  
               elsif Wert > WahrscheinlichkeitenFürLandart (Kartentemperatur, 3) and GeneratorKarte (Y, X) /= 4 then
                  Karten.Karten (Y, X).Grund := 5;
                  GenerierungTemperaturAbstand (YPosition => Y, XPosition => X, Geländeart => 5);
                  
               else
                  null;
               end if;
            end if;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungKartentemperatur;



   procedure GenerierungTemperaturAbstand (YPosition, XPosition, Geländeart : in Integer) is
   begin
      
      YAchseSchleife:
      for Y in -FelderVonTemperaturZuTemperatur .. FelderVonTemperaturZuTemperatur loop
         XAchseSchleife:
         for X in -FelderVonTemperaturZuTemperatur .. FelderVonTemperaturZuTemperatur loop
                              
            if Y + YPosition <= Karten.Karten'First (1) or Y + YPosition >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
               null;
               
            elsif X + XPosition < Karten.Karten'First (2) then
               Überhang := X + XPosition + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
               for A in Überhang .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                  
                  GenerierungTemperaturZusatz (YAchse => Y + YPosition, XAchse => Überhang, Geländeart => Geländeart);
                  
               end loop;
               
            elsif X + XPosition > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
               Überhang := X + XPosition - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
               for B in Karten.Karten'First (2) .. Überhang loop
                  
                  GenerierungTemperaturZusatz (YAchse => Y + YPosition, XAchse => Überhang, Geländeart => Geländeart);
                  
               end loop;
               
            elsif GeneratorKarte (Y + YPosition, X + XPosition) = 0 then
               GenerierungTemperaturZusatz (YAchse => Y + YPosition, XAchse => X + XPosition, Geländeart => Geländeart);
               
            else
               null;
            end if;
         
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
      for Y in Karten.Karten'First (1) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseSchleife:
         for X in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
                     
            if Karten.Karten (Y, X).Grund = 4 or Karten.Karten (Y, X).Grund = 5 then
               for A in -Abstand .. Abstand loop
                  for B in -Abstand .. Abstand loop

                     if Y + A <= Karten.Karten'First (1) or Y + A >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße or X + B < Karten.Karten'First (2) or X + B > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
                        null;
                        
                     else                    
                        GeneratorKarte (Y + A, X + B) := 1;
                     end if;
                     
                  end loop;
               end loop;
               
            else
               null;
            end if;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungLandschaftZusatz;



   procedure GenerierungFlüsse is
   begin

      Wahl.Reset (Wählen);
      
      YAchseSchleife:
      for Y in Karten.Karten'First (1) + Eisrand .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - Eisrand loop
         XAchseSchleife:
         for X in Karten.Karten'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            if Karten.Karten (Y, X).Grund < 3 or Karten.Karten (Y, X).Grund = 31 then
               null;
               
            else
               Wert := Random (Gewählt);
               if Wert >= WahrscheinlichkeitFluss then
                  Wert2 := Wahl.Random (Wählen);
                  Karten.Karten (Y, X).Fluss := Wert2;
                  Karten.Karten (Y, X).Grund := Wert2;
                  
               else
                  null;
               end if;
            end if;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungFlüsse;
   
   
   
   procedure GenerierungRessourcen is
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
                     if Wert > 0.98 then
                        if Karten.Karten (Y, X).Grund < 3 or Karten.Karten (Y, X).Grund = 31 then
                           karten.Karten (Y, X).Ressource := 29;
                           NochVerteilbareRessourcen := NochVerteilbareRessourcen - 1;
                        
                        else
                           Karten.Karten (Y, X).Ressource := 10;
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

end KartenGenerator;
