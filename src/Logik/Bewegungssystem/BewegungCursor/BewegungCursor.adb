pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;

with Karten;
with Eingabe;
with KarteKoordinatenPruefen;

package body BewegungCursor is

   procedure BewegungCursorRichtung
     (KarteExtern : in Boolean;
      RichtungExtern : in TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum;
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
      
      KoordinatenPunkt := Eingabe.GanzeZahl (ZeileExtern         => 29,
                                             ZahlenMinimumExtern => Integer (Karten.Weltkarte'First (1)),
                                             ZahlenMaximumExtern => Integer (Karten.Weltkarte'Last (1)));
      
      case
        KoordinatenPunkt.EingabeAbbruch
      is
         when False =>
            return;
         
         when True =>
            Position.EAchse := KartenDatentypen.EbeneVorhanden (KoordinatenPunkt.EingegebeneZahl);
            KoordinatenPunkt := Eingabe.GanzeZahl (ZeileExtern         => 30,
                                                   ZahlenMinimumExtern => Positive (Karten.Weltkarte'First (2)),
                                                   ZahlenMaximumExtern => Positive (Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße));
      end case;
      
      case
        KoordinatenPunkt.EingabeAbbruch
      is
         when False =>
            return;
         
         when True =>
            Position.YAchse := KartenDatentypen.KartenfeldPositiv (KoordinatenPunkt.EingegebeneZahl);
            KoordinatenPunkt := Eingabe.GanzeZahl (ZeileExtern         => 31,
                                                   ZahlenMinimumExtern => Positive (Karten.Weltkarte'First (3)),
                                                   ZahlenMaximumExtern => Positive (Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße));
      end case;

      case
        KoordinatenPunkt.EingabeAbbruch
      is
         when False =>
            return;
         
         when True =>
            Position.XAchse := KartenDatentypen.KartenfeldPositiv (KoordinatenPunkt.EingegebeneZahl);
            GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell := Position;
            GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt := Position;
      end case;
      
   end GeheZuCursor;
   
   

   procedure BewegungCursorBerechnen
     (ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        ÄnderungExtern.EAchse = 1
        and
          GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse = Karten.Weltkarte'Last (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse := Karten.Weltkarte'First (1);
         return;
         
      elsif
        ÄnderungExtern.EAchse = -1
        and
          GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse = Karten.Weltkarte'First (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse := Karten.Weltkarte'Last (1);
         return;
         
      elsif
        ÄnderungExtern.EAchse /= 0
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse + ÄnderungExtern.EAchse;
         return;
         
      else
         null;
      end if;
            
      KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell,
                                                                     ÄnderungExtern    => ÄnderungExtern,
                                                                     LogikGrafikExtern => True);
      
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;

         when others =>
            GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell := KartenWert;
      end case;
      
   end BewegungCursorBerechnen;



   procedure BewegungCursorBerechnenStadt
     (ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin

      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse + ÄnderungExtern.YAchse < Karten.Stadtkarte'First (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse := Karten.Stadtkarte'Last (1);

      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse + ÄnderungExtern.YAchse > Karten.Stadtkarte'Last (1)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse := Karten.Stadtkarte'First (1);

      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse + ÄnderungExtern.YAchse;
      end if;
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.XAchse + ÄnderungExtern.XAchse < Karten.Stadtkarte'First (2)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.XAchse := Karten.Stadtkarte'Last (2);

      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.XAchse + ÄnderungExtern.XAchse > Karten.Stadtkarte'Last (2)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.XAchse := Karten.Stadtkarte'First (2);

      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.XAchse + ÄnderungExtern.XAchse;
      end if;
      
   end BewegungCursorBerechnenStadt;

end BewegungCursor;
