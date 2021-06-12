pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with Karten, KartenPruefungen, KarteInformationen, GrafischeAnzeige;

package body Karte is

   procedure AnzeigeKarte
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      case
        Karten.Kartengröße
      is
         when 1 =>
            SichtweiteFestlegen := 1;
            BewegungsfeldFestlegen := 1;
            
         when 2 =>
            SichtweiteFestlegen := 2;
            BewegungsfeldFestlegen := 2;

         when Karten.KartengrößenArray'Last =>
            if
              Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (1).YAchsenGröße
              or
                Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (1).XAchsenGröße
            then
               SichtweiteFestlegen := 1;
               BewegungsfeldFestlegen := 1;
               
            elsif
              Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (2).YAchsenGröße
              or
                Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (2).XAchsenGröße
            then
               SichtweiteFestlegen := 2;
               BewegungsfeldFestlegen := 2;
               
            else
               SichtweiteFestlegen := 3;
               BewegungsfeldFestlegen := 3; 
            end if;
            
         when others =>
            SichtweiteFestlegen := 3;
            BewegungsfeldFestlegen := 3;            
      end case;
      
      CursorPositionAltFestlegen (RasseExtern                  => RasseExtern,
                                  BewegungsfeldFestlegenExtern => BewegungsfeldFestlegen);
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      YAchseSchleife:
      for YAchseSchleifenwert in -Sichtweiten (SichtweiteFestlegen).YAchse .. Sichtweiten (SichtweiteFestlegen).YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Sichtweiten (SichtweiteFestlegen).XAchse .. Sichtweiten (SichtweiteFestlegen).XAchse loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt,
                                                                    ÄnderungExtern       => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                    ZusatzYAbstandExtern => 0);
            
            case
              KartenWert.YAchse
            is
               when 0 =>
                  exit XAchseSchleife;
                  
               when others =>
                  GrafischeAnzeige.Sichtbarkeit (InDerStadtExtern  => False,
                                                 KoordinatenExtern => KartenWert,
                                                 RasseExtern       => RasseExtern);
            end case;
            
            if
              XAchseSchleifenwert = Sichtweiten (SichtweiteFestlegen).XAchse
            then
               New_Line;
                  
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;    
         
      KarteInformationen.KarteInformation (RasseExtern => RasseExtern);

   end AnzeigeKarte;
   
   
   
   procedure CursorPositionAltFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen;
      BewegungsfeldFestlegenExtern : in Positive)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.EAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse
      then
         null;
            
      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.EAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse;
      end if;

      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.YAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
        or
          GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.YAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse;
         
      else
         null;
      end if;
            
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
           - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse;         
            
         else
            null;
         end if;
         
      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse < Karten.WeltkarteArray'First (3)
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
           + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse;         
            
         else
            null;
         end if;
         
      else
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
           or
             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse;
            
         else
            null;
         end if;
      end if;
      
   end CursorPositionAltFestlegen;
   
end Karte;
