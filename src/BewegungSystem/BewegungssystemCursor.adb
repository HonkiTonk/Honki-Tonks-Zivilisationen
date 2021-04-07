pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Karten, Eingabe, KartenPruefungen;

package body BewegungssystemCursor is

   procedure BewegungCursorRichtung
     (KarteExtern : in Boolean;
      RichtungExtern : in Wide_Wide_Character;
      RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      case
        RichtungExtern
      is
         when 'w' | '8' =>
            Änderung := (0, -1, 0);
            
         when 'a' | '4' =>
            Änderung := (0, 0, -1);
            
         when 's' | '2' =>
            Änderung := (0, 1, 0);
            
         when 'd' | '6'  =>
            Änderung := (0, 0, 1);
            
         when '1' =>
            Änderung := (0, 1, -1);

         when '3' =>
            Änderung := (0, 1, 1);
            
         when '7' =>
            Änderung := (0, -1, -1);
            
         when '9' =>
            Änderung := (0, -1, 1);
            
         when '+' =>
            Änderung := (1, 0, 0);
            
         when '-' =>
            Änderung := (-1, 0, 0);
            
         when others =>
            return;
      end case;
      
      case
        KarteExtern
      is
         when True =>
            BewegungCursorBerechnen (ÄnderungExtern => Änderung,
                                     RasseExtern    => RasseExtern);
            
         when False =>
            BewegungCursorBerechnenStadt (ÄnderungExtern => Änderung,
                                          RasseExtern    => RasseExtern);
      end case;
      
   end BewegungCursorRichtung;



   procedure GeheZuCursor
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      Wert := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleDatentypen.Zeug,
                                 ZeileExtern         => 40,
                                 ZahlenMinimumExtern => Integer (Karten.Weltkarte'First (1)),
                                 ZahlenMaximumExtern => Integer (Karten.Weltkarte'Last (1)));
      
      case
        Wert
      is
         when GlobaleKonstanten.GanzeZahlAbbruchKonstante =>
            return;
         
         when others =>
            Position.EAchse := GlobaleDatentypen.EbeneVorhanden (Wert);
      end case;
      
      Wert := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleDatentypen.Zeug,
                                 ZeileExtern         => 30,
                                 ZahlenMinimumExtern => Integer (Karten.Weltkarte'First (2)),
                                 ZahlenMaximumExtern => Integer (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));
      
      case
        Wert
      is
         when GlobaleKonstanten.GanzeZahlAbbruchKonstante =>
            return;
         
         when others =>
            Position.YAchse := GlobaleDatentypen.Kartenfeld (Wert);
      end case;

      Wert := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleDatentypen.Zeug,
                                 ZeileExtern         => 31,
                                 ZahlenMinimumExtern => Integer (Karten.Weltkarte'First (3)),
                                 ZahlenMaximumExtern => Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

      case
        Wert
      is
         when GlobaleKonstanten.GanzeZahlAbbruchKonstante =>
            return;
         
         when others =>
            Position.XAchse := GlobaleDatentypen.Kartenfeld (Wert);
      end case;
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition := Position;
      
   end GeheZuCursor;
   
   

   procedure BewegungCursorBerechnen
     (ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      if
        ÄnderungExtern.EAchse = 1
        and
          GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse = Karten.Weltkarte'Last (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse := Karten.Weltkarte'First (1);
         return;
         
      elsif
        ÄnderungExtern.EAchse = -1
        and
          GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse = Karten.Weltkarte'First (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse := Karten.Weltkarte'Last (1);
         return;
         
      elsif
        ÄnderungExtern.EAchse /= 0
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse + ÄnderungExtern.EAchse;
         return;
         
      else
         null;
      end if;
      
      KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition,
                                                              ÄnderungExtern       => ÄnderungExtern,
                                                              ZusatzYAbstandExtern => 0);
      
      case
        KartenWert.Erfolgreich
      is
         when False =>
            return;
              
         when True =>
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition := (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse);
      end case;
      
   end BewegungCursorBerechnen;



   procedure BewegungCursorBerechnenStadt
     (ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord;
      RasseExtern : in GlobaleDatentypen.Rassen)
   is begin

      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse + ÄnderungExtern.YAchse < Karten.Stadtkarte'First (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse := Karten.Stadtkarte'Last (1);

      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse + ÄnderungExtern.YAchse > Karten.Stadtkarte'Last (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse := Karten.Stadtkarte'First (1);

      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse + ÄnderungExtern.YAchse;
      end if;
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse + ÄnderungExtern.XAchse < Karten.Stadtkarte'First (2)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse := Karten.Stadtkarte'Last (2);

      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse + ÄnderungExtern.XAchse > Karten.Stadtkarte'Last (2)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse := Karten.Stadtkarte'First (2);

      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse + ÄnderungExtern.XAchse;
      end if;
      
   end BewegungCursorBerechnenStadt;

end BewegungssystemCursor;
