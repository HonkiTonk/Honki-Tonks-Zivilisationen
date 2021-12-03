pragma SPARK_Mode (On);

with GlobaleTexte;
with KartenKonstanten;

with Karten;
with Eingabe;
with KartePositionPruefen;

package body BewegungCursor is

   procedure BewegungCursorRichtung
     (KarteExtern : in Boolean;
      RichtungExtern : in SystemDatentypen.Tastenbelegung_Bewegung_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Änderung := Richtung (RichtungExtern);
      
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
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      KoordinatenPunkt := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Zeug,
                                             ZeileExtern         => 29,
                                             ZahlenMinimumExtern => Integer (Karten.Weltkarte'First (1)),
                                             ZahlenMaximumExtern => Integer (Karten.Weltkarte'Last (1)));
      
      case
        KoordinatenPunkt.EingabeAbbruch
      is
         when False =>
            return;
         
         when True =>
            Position.EAchse := KartenDatentypen.EbeneVorhanden (KoordinatenPunkt.EingegebeneZahl);
            KoordinatenPunkt := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Zeug,
                                                   ZeileExtern         => 30,
                                                   ZahlenMinimumExtern => Positive (Karten.Weltkarte'First (2)),
                                                   ZahlenMaximumExtern => Positive (Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße));
      end case;
      
      case
        KoordinatenPunkt.EingabeAbbruch
      is
         when False =>
            return;
         
         when True =>
            Position.YAchse := KartenDatentypen.Kartenfeld (KoordinatenPunkt.EingegebeneZahl);
            KoordinatenPunkt := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Zeug,
                                                   ZeileExtern         => 31,
                                                   ZahlenMinimumExtern => Positive (Karten.Weltkarte'First (3)),
                                                   ZahlenMaximumExtern => Positive (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
      end case;

      case
        KoordinatenPunkt.EingabeAbbruch
      is
         when False =>
            return;
         
         when True =>
            Position.XAchse := KartenDatentypen.Kartenfeld (KoordinatenPunkt.EingegebeneZahl);
            GlobaleVariablen.CursorImSpiel (RasseExtern).Position := Position;
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt := Position;
      end case;
      
   end GeheZuCursor;
   
   

   procedure BewegungCursorBerechnen
     (ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        ÄnderungExtern.EAchse = 1
        and
          GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse = Karten.Weltkarte'Last (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse := Karten.Weltkarte'First (1);
         return;
         
      elsif
        ÄnderungExtern.EAchse = -1
        and
          GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse = Karten.Weltkarte'First (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse := Karten.Weltkarte'Last (1);
         return;
         
      elsif
        ÄnderungExtern.EAchse /= 0
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse + ÄnderungExtern.EAchse;
         return;
         
      else
         null;
      end if;
            
      KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position,
                                                                  ÄnderungExtern    => ÄnderungExtern);
      
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;

         when others =>
            GlobaleVariablen.CursorImSpiel (RasseExtern).Position := KartenWert;
      end case;
      
   end BewegungCursorBerechnen;



   procedure BewegungCursorBerechnenStadt
     (ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin

      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse + ÄnderungExtern.YAchse < Karten.Stadtkarte'First (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse := Karten.Stadtkarte'Last (1);

      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse + ÄnderungExtern.YAchse > Karten.Stadtkarte'Last (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse := Karten.Stadtkarte'First (1);

      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.YAchse + ÄnderungExtern.YAchse;
      end if;
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse + ÄnderungExtern.XAchse < Karten.Stadtkarte'First (2)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse := Karten.Stadtkarte'Last (2);

      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse + ÄnderungExtern.XAchse > Karten.Stadtkarte'Last (2)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse := Karten.Stadtkarte'First (2);

      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt.XAchse + ÄnderungExtern.XAchse;
      end if;
      
   end BewegungCursorBerechnenStadt;

end BewegungCursor;
