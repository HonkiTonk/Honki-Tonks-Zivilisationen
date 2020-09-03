package body InDerStadt is

   procedure InDerStadt (Rasse, StadtPositionInListe : in Integer) is
   begin         
      
      StadtSchleife:
      loop     
    
         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         KarteStadt.AnzeigeStadt (Stadtnummer => StadtPositionInListe);
         New_Line;
         Beschreibung (Rasse                => Rasse,
                       StadtPositionInListe => StadtPositionInListe);

         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is
            when 'w' | 's' | 'a' | 'd' | '1' | '2' | '3' | '4' | '6' | '7' | '8' | '9' =>
               BewegungssystemCursor.BewegungCursorRichtung (Karte => False,
                                                             Richtung => To_Lower (Item => Taste));

            when 'e' =>
               null;
               
            when 'b' =>
               null;
               
            when 'v' =>
               null;

            when 'q' =>
               return;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
   end InDerStadt;



   procedure Beschreibung (Rasse, StadtPositionInListe : in Integer) is
   begin
      
      Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).ID)));
      Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).Name) & "    ");
      Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 5)));
      Put_Line (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).Einwohner'Wide_Wide_Image);
                     
      if Rasse = GlobaleVariablen.Rasse then
         Put (Item => "       " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 6)));
         Put (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuelleNahrungsmittel'Wide_Wide_Image);
         Put (Item => "    " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 7)));
         Put_Line (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuelleNahrungsproduktion'Wide_Wide_Image);
                        
         Put (Item => "       " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 8)));
         Put (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuelleProduktionrate'Wide_Wide_Image);
         Put (Item => "    " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 9)));
         Put_Line (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuelleGeldgewinnung'Wide_Wide_Image);

         Put (Item => "       " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 10)));
         Put (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuelleForschungsrate'Wide_Wide_Image);                        
         Put (Item => "    " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 11)));
         Put_Line (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).Korruption'Wide_Wide_Image);
                        
         Put (Item => "       " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 12)));
         Put (Item => GlobaleVariablen.StadtGebaut (Rasse, StadtPositionInListe).AktuellesBauprojekt'Wide_Wide_Image);                       
         Put_Line (Item => "    " & To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 13)));                                 

      else
         null;
      end if;
                     
      New_Line;
      
   end Beschreibung;
   
   
   
   procedure StadtBauen (Rasse, Listenplatz : in Integer) is
   begin

      BauMöglich := True;
      
      YAchseSchleife:
      for Y in -3 .. 3 loop
         XAchseSchleife:
         for X in -3 .. 3 loop
                     
            if GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + Y > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße or GlobaleVariablen.StadtGebaut (Rasse, Listenplatz).YAchse + Y < Karten.Karten'First (1) then
               exit XAchseSchleife;

            elsif GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + X > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
               Überhang := GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + X - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
               BauMöglich := StadtBauenPrüfen (Y => GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + Y,
                                                 X => Überhang);
                     
                     
            elsif GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + X < Karten.Karten'First (1) then
               Überhang := GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + X + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
               BauMöglich := StadtBauenPrüfen (Y => GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + Y,
                                                 X => Überhang);
                     
            else
               BauMöglich := StadtBauenPrüfen (Y => GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse + Y,
                                                 X => GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse + X);
            end if;

            case BauMöglich is
               when True =>
                  null;
                  
               when False =>                  
                  Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 6);
                  return;
            end case;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      for A in GlobaleVariablen.StadtGebaut'Range (2) loop
         
         if GlobaleVariablen.StadtGebaut (Rasse, A).ID /= 0 then
            null;
            
         elsif A = GlobaleVariablen.StadtGebaut'Last (2) and GlobaleVariablen.StadtGebaut (Rasse, A).ID /= 0 then
            Fehlermeldungen.Fehlermeldungen (WelcheFehlermeldung => 7);
            
         else
            if A = 1 and Rasse = GlobaleVariablen.Rasse then
               Stadtart := 1;
               
            elsif Rasse = GlobaleVariablen.Rasse then
               Stadtart := 2;
               
            elsif A = 1 and Rasse /= GlobaleVariablen.Rasse then
               Stadtart := 3;
               
            else
               Stadtart := 4;
            end if;

            GlobaleVariablen.StadtGebaut (Rasse, A) := 
              (Stadtart, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, Listenplatz).XAchse, 1, 0, 0, 0, 0, 0, 0, 0, 0, "00000000000000000000", To_Unbounded_Wide_Wide_String (Source => "Name"));
            EinheitenDatenbank.EinheitEntfernen (Rasse => Rasse,
                                                 Platznummer => Listenplatz);

            GlobaleVariablen.StadtGebaut (Rasse, A).Name := Eingabe.StadtName;
            return;
         end if;
         
      end loop;
                           
   end StadtBauen;



   function StadtBauenPrüfen (Y, X : in Integer) return Boolean is
   begin
      
      RassenSchleife:
      for A in GlobaleVariablen.StadtGebaut'Range (1) loop
         StadtSchleife:
         for B in GlobaleVariablen.StadtGebaut'Range (2) loop
            
            if GlobaleVariablen.StadtGebaut (A, B).ID = 0 then
               exit StadtSchleife;
               
            elsif GlobaleVariablen.StadtGebaut (A, B).YAchse = Y and GlobaleVariablen.StadtGebaut (A, B).XAchse = X then
               return False;
               
            else
               null;
            end if;
            
         end loop StadtSchleife;
      end loop RassenSchleife;

      return True;
      
   end StadtBauenPrüfen;

end InDerStadt;
