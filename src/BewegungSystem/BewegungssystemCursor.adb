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
            BewegungCursorBerechnen;
            
         when False =>
            BewegungCursorBerechnenStadt;
      end case;
      
   end BewegungCursorRichtung;



   procedure GeheZuCursor is
   begin

      Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 30)));
      Put_Line (Item => Karten.Karten'First (1)'Wide_Wide_Image & " .." & Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße'Wide_Wide_Image);
      YPosition := Eingabe.GanzeZahl;
      if YPosition < Karten.Karten'First (1) or YPosition > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
         Ausgabe.Fehlermeldungen (WelcheFehlermeldung => 12);
         return;
         
      else
         Put (Item => To_Wide_Wide_String (Source => Einlesen.TexteEinlesen (19, 31)));
         Put_Line (Item => Karten.Karten'First (2)'Wide_Wide_Image & " .." & Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße'Wide_Wide_Image);
         XPosition := Eingabe.GanzeZahl;

         if XPosition < Karten.Karten'First (2) or XPosition > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
            Ausgabe.Fehlermeldungen (WelcheFehlermeldung => 12);
            return;
         
         else
            GlobaleVariablen.CursorImSpiel.YAchse := YPosition;
            GlobaleVariablen.CursorImSpiel.XAchse := XPosition;
         end if;
      end if;
      
   end GeheZuCursor;
                   
   

   procedure BewegungCursorBerechnen is
   begin
            
      if (GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung < Karten.Karten'First (1) or GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße) and XÄnderung = 0 then
         return;

      elsif GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung < Karten.Karten'First (1) or GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße then
         if GlobaleVariablen.CursorImSpiel.XAchse + XÄnderung < Karten.Karten'First (2) then
            GlobaleVariablen.CursorImSpiel.XAchse := Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
            
         elsif GlobaleVariablen.CursorImSpiel.XAchse + XÄnderung > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
            GlobaleVariablen.CursorImSpiel.XAchse := Karten.Karten'First (2);
            
         else
            GlobaleVariablen.CursorImSpiel.XAchse := GlobaleVariablen.CursorImSpiel.XAchse + XÄnderung;
         end if;
        
      elsif GlobaleVariablen.CursorImSpiel.XAchse + XÄnderung < Karten.Karten'First (2) then
         GlobaleVariablen.CursorImSpiel.XAchse := Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
         GlobaleVariablen.CursorImSpiel.YAchse := GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung;
         
      elsif GlobaleVariablen.CursorImSpiel.XAchse + XÄnderung > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
         GlobaleVariablen.CursorImSpiel.XAchse := Karten.Karten'First (2);
         GlobaleVariablen.CursorImSpiel.YAchse := GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung;
         
      else
         GlobaleVariablen.CursorImSpiel.YAchse := GlobaleVariablen.CursorImSpiel.YAchse + YÄnderung;
         GlobaleVariablen.CursorImSpiel.XAchse := GlobaleVariablen.CursorImSpiel.XAchse + XÄnderung;
      end if;
      
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
