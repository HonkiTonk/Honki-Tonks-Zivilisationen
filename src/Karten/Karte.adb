pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten;

with Karten, KartePositionPruefen, KarteInformationen, GrafischeAnzeige;

package body Karte is
   
   procedure SichtweiteBewegungsfeldFestlegen
   is begin
      
      case
        Karten.Kartengröße
      is
         when GlobaleDatentypen.Karte_20_20 =>
            SichtweiteFestlegen := 1;
            BewegungsfeldFestlegen := 1;
            
         when GlobaleDatentypen.Karte_40_40 =>
            SichtweiteFestlegen := 2;
            BewegungsfeldFestlegen := 2;

         when GlobaleDatentypen.Karte_Nutzer =>
            if
              Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (GlobaleDatentypen.Karte_20_20).YAchsenGröße
              or
                Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (GlobaleDatentypen.Karte_20_20).XAchsenGröße
            then
               SichtweiteFestlegen := 1;
               BewegungsfeldFestlegen := 1;
               
            elsif
              Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (GlobaleDatentypen.Karte_40_40).YAchsenGröße
              or
                Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (GlobaleDatentypen.Karte_40_40).XAchsenGröße
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
      
   end SichtweiteBewegungsfeldFestlegen;
   
   

   procedure AnzeigeKarte
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      CursorPositionAltFestlegen (RasseExtern                  => RasseExtern,
                                  BewegungsfeldFestlegenExtern => BewegungsfeldFestlegen);
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      YAchseSchleife:
      for YAchseSchleifenwert in -Sichtweiten (SichtweiteFestlegen).YAchse .. Sichtweiten (SichtweiteFestlegen).YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Sichtweiten (SichtweiteFestlegen).XAchse .. Sichtweiten (SichtweiteFestlegen).XAchse loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                        ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            case
              KartenWert.XAchse
            is
               when GlobaleKonstanten.LeerYXKartenWert =>
                  null;
                  
               when others =>
                  GrafischeAnzeige.Sichtbarkeit (InDerStadtExtern  => False,
                                                 KoordinatenExtern => KartenWert,
                                                 RasseExtern       => RasseExtern);
            end case;
            
            if
              XAchseSchleifenwert = Sichtweiten (SichtweiteFestlegen).XAchse
            then
               if
                 (Karten.Kartenform = GlobaleDatentypen.X_Zylinder
                  or
                    Karten.Kartenform = GlobaleDatentypen.Torus
                  or
                    Karten.Kartenform = GlobaleDatentypen.Kugel
                  or
                    Karten.Kartenform = GlobaleDatentypen.Kugel_Gedreht
                  or
                    Karten.Kartenform = GlobaleDatentypen.Tugel
                  or
                    Karten.Kartenform = GlobaleDatentypen.Tugel_Gedreht
                  or
                    Karten.Kartenform = GlobaleDatentypen.Tugel_Extrem)
                 and
                   KartenWert.XAchse > GlobaleKonstanten.LeerYXKartenWert
               then
                  New_Line;
                  
               elsif
                 Karten.Kartenform = GlobaleDatentypen.Y_Zylinder
                 or
                   Karten.Kartenform = GlobaleDatentypen.Viereck
               then
                  New_Line;
               
               else
                  null;
               end if;              
                 
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      New_Line;
      
      KarteInformationen.KarteInformation (RasseExtern => RasseExtern);

   end AnzeigeKarte;
   
   
   
   procedure CursorPositionAltFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.EAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse
      then
         null;
            
      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.EAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse;
      end if;
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse
           > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse - Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse;         
            
         else
            null;
         end if;
         
      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse < Karten.WeltkarteArray'First (2)
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse
           < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse + Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse;         
            
         else
            null;
         end if;
         
      else
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
           or
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse;
            
         else
            null;
         end if;
      end if;
            
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse
           > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse;         
            
         else
            null;
         end if;
         
      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse < Karten.WeltkarteArray'First (3)
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse
           < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse;         
            
         else
            null;
         end if;
         
      else
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
           or
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse;
            
         else
            null;
         end if;
      end if;
      
   end CursorPositionAltFestlegen;
   
end Karte;
