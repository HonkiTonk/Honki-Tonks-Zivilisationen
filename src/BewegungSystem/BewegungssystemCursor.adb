package body BewegungssystemCursor is

   procedure BewegungCursorRichtung (Karte : in Boolean; Richtung : in Wide_Wide_Character) is -- Hier noch Bewegung für Stadt einbauen
   begin

   YÄnderung := 0;
   XÄnderung := 0;
      
      case Richtung is
         when 'w' | '8' =>
            YÄnderung := -1;
            XÄnderung := 0;
            
         when 'a' | '4' =>
            YÄnderung := 0;
            XÄnderung := -1;
            
         when 's' | '2' =>
            YÄnderung := 1;
            XÄnderung := 0;
            
         when 'd' | '6'  =>
            YÄnderung := 0;
            XÄnderung := 1;
            
         when '1' =>
            YÄnderung := 1;
            XÄnderung := -1;

         when '3' =>
            YÄnderung := 1;
            XÄnderung := 1;
            
         when '7' =>
            YÄnderung := -1;
            XÄnderung := -1;
            
         when '9' =>
            YÄnderung := -1;
            XÄnderung := 1;            
            
         when others =>
            return;
      end case;
      
      case Karte is
         when True =>
            BewegungCursorBerechnen (YÄnderung, XÄnderung);
            
         when False =>
            BewegungCursorBerechnenStadt;
      end case;
      
   end BewegungCursorRichtung;



   procedure GeheZuCursor is
   begin

      Put (Item => To_Wide_Wide_String (Source => GlobaleVariablen.TexteEinlesen (19, 30)));
      Put_Line (Item => Karten.Karten'First (2)'Wide_Wide_Image & " .." & Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße'Wide_Wide_Image);
      case Karten.Kartengröße is
         when 1 .. 3 =>
            Stellenanzahl := 2;
            
         when 4 .. 8 =>
            Stellenanzahl := 3;
            
         when others =>
            Stellenanzahl := 4;
      end case;
      Wert := Eingabe.GanzeZahl (Zahlengröße => Stellenanzahl);
      
      if Wert < 1 or Wert > Integer (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße) then
         Anzeige.Fehlermeldungen (WelcheFehlermeldung => 12);
         return;
         
      else
         YPosition := GlobaleDatentypen.Kartenfeld (Wert);
      end if;
      
      Put_Line (Item => Karten.Karten'First (3)'Wide_Wide_Image & " .." & Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße'Wide_Wide_Image);
      Wert := Eingabe.GanzeZahl (Zahlengröße => Stellenanzahl);

      if Wert < 1 or Wert > Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) then
         Anzeige.Fehlermeldungen (WelcheFehlermeldung => 12);
         return;
         
      else
         XPosition := GlobaleDatentypen.Kartenfeld (Wert);
      end if;
      
      GlobaleVariablen.CursorImSpiel.YAchse := YPosition;
      GlobaleVariablen.CursorImSpiel.XAchse := XPosition;
      
   end GeheZuCursor;
   
   

   procedure BewegungCursorBerechnen (YÄnderung, XÄnderung : in GlobaleDatentypen.LoopRangeMinusEinsZuEins) is
   begin
      
      KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.CursorImSpiel.YAchse,
                                                        XKoordinate    => GlobaleVariablen.CursorImSpiel.XAchse,
                                                        YÄnderung      => YÄnderung,
                                                        XÄnderung      => XÄnderung,
                                                        ZusatzYAbstand => 0);
      case KartenWert.YWert is
         when GlobaleDatentypen.Kartenfeld'First =>
            return;
              
         when others =>
            GlobaleVariablen.CursorImSpiel.YAchse := KartenWert.YWert;
            GlobaleVariablen.CursorImSpiel.XAchse := KartenWert.XWert;
      end case;
      
   end BewegungCursorBerechnen;



   procedure BewegungCursorBerechnenStadt is
   begin
      
      if GlobaleVariablen.CursorImSpiel.YAchseStadt + YÄnderung < Karten.Stadtkarte'First (1) and XÄnderung = 0 then
         GlobaleVariablen.CursorImSpiel.YAchseStadt := Karten.Stadtkarte'Last (1);

      elsif GlobaleVariablen.CursorImSpiel.YAchseStadt + YÄnderung > Karten.Stadtkarte'Last (1) and XÄnderung = 0 then
         GlobaleVariablen.CursorImSpiel.YAchseStadt := Karten.Stadtkarte'First (1);
         
      elsif GlobaleVariablen.CursorImSpiel.YAchseStadt + YÄnderung < Karten.Stadtkarte'First (1) then
         if GlobaleVariablen.CursorImSpiel.XAchseStadt + XÄnderung < Karten.Stadtkarte'First (2) then
            GlobaleVariablen.CursorImSpiel.YAchseStadt := Karten.Stadtkarte'Last (1);
            GlobaleVariablen.CursorImSpiel.XAchseStadt := Karten.Stadtkarte'Last (2);

         elsif GlobaleVariablen.CursorImSpiel.XAchseStadt + XÄnderung > Karten.Stadtkarte'Last (2) then
            GlobaleVariablen.CursorImSpiel.YAchseStadt := Karten.Stadtkarte'Last (1);
            GlobaleVariablen.CursorImSpiel.XAchseStadt := Karten.Stadtkarte'First (2);

         else
            GlobaleVariablen.CursorImSpiel.YAchseStadt := Karten.Stadtkarte'Last (1);
            GlobaleVariablen.CursorImSpiel.XAchseStadt := GlobaleVariablen.CursorImSpiel.XAchseStadt + XÄnderung;
         end if;

      elsif GlobaleVariablen.CursorImSpiel.YAchseStadt + YÄnderung > Karten.Stadtkarte'Last (1) then
         if GlobaleVariablen.CursorImSpiel.XAchseStadt + XÄnderung < Karten.Stadtkarte'First (2) then
            GlobaleVariablen.CursorImSpiel.YAchseStadt := Karten.Stadtkarte'First (1);
            GlobaleVariablen.CursorImSpiel.XAchseStadt := Karten.Stadtkarte'Last (2);

         elsif GlobaleVariablen.CursorImSpiel.XAchseStadt + XÄnderung > Karten.Stadtkarte'Last (2) then
            GlobaleVariablen.CursorImSpiel.YAchseStadt := Karten.Stadtkarte'First (1);
            GlobaleVariablen.CursorImSpiel.XAchseStadt := Karten.Stadtkarte'First (2);

         else
            GlobaleVariablen.CursorImSpiel.YAchseStadt := Karten.Stadtkarte'First (1);
            GlobaleVariablen.CursorImSpiel.XAchseStadt := GlobaleVariablen.CursorImSpiel.XAchseStadt + XÄnderung;
         end if;
            
      elsif GlobaleVariablen.CursorImSpiel.XAchseStadt + XÄnderung < Karten.Stadtkarte'First (2) then
         GlobaleVariablen.CursorImSpiel.YAchseStadt := GlobaleVariablen.CursorImSpiel.YAchseStadt + YÄnderung;
         GlobaleVariablen.CursorImSpiel.XAchseStadt := Karten.Stadtkarte'Last (2);

      elsif GlobaleVariablen.CursorImSpiel.XAchseStadt + XÄnderung > Karten.Stadtkarte'Last (2) then
         GlobaleVariablen.CursorImSpiel.YAchseStadt := GlobaleVariablen.CursorImSpiel.YAchseStadt + YÄnderung;
         GlobaleVariablen.CursorImSpiel.XAchseStadt := Karten.Stadtkarte'First (2);

      else         
         GlobaleVariablen.CursorImSpiel.YAchseStadt := GlobaleVariablen.CursorImSpiel.YAchseStadt + YÄnderung;
         GlobaleVariablen.CursorImSpiel.XAchseStadt := GlobaleVariablen.CursorImSpiel.XAchseStadt + XÄnderung;
      end if;
      
   end BewegungCursorBerechnenStadt;

end BewegungssystemCursor;
