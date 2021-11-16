pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with Karten;
with KartePositionPruefen;
with Sichtweiten;

package body CursorPositionAltFestlegen is

   procedure CursorPositionAltFestlegen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AlteEAchseFestlegen (RasseExtern => RasseExtern);
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            AlteYAchseFestlegenKonsole (RasseExtern => RasseExtern);
            AlteXAchseFestlegenKonsole (RasseExtern => RasseExtern);
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            AlteYAchseFestlegenSFML (RasseExtern => RasseExtern);
            AlteXAchseFestlegenSFML (RasseExtern => RasseExtern);
      end case;
      
   end CursorPositionAltFestlegen;
   
   
   
   procedure AlteEAchseFestlegen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.EAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse
      then
         null;
            
      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.EAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse;
      end if;
      
   end AlteEAchseFestlegen;
   
   
   
   procedure AlteYAchseFestlegenKonsole
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True)
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse
           > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) - Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse;
            
         else
            null;
         end if;
         
      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) < Karten.WeltkarteArray'First (2)
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True)
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse
           < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) + Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse;
            
         else
            null;
         end if;
         
      else
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True)
           or
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True)
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse;
            
         else
            null;
         end if;
      end if;
      
   end AlteYAchseFestlegenKonsole;
   
   
   
   procedure AlteXAchseFestlegenKonsole
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False)
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse
           > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse;
            
         else
            null;
         end if;
         
      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) < Karten.WeltkarteArray'First (3)
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False)
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse
           < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse;
            
         else
            null;
         end if;
         
      else
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False)
           or
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False)
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse;
            
         else
            null;
         end if;
      end if;
      
   end AlteXAchseFestlegenKonsole;
   
   
   
   procedure AlteYAchseFestlegenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                  ÄnderungExtern    => (0, Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) + 1, 0));
                                                                  
      case
        KartenWert.YAchse
      is
         when KartenKonstanten.LeerYAchse =>
            null;
            
         when others =>
            if
              KartenWert.YAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse
            then
               GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                                                                                ÄnderungExtern   => (0, 1, 0)).YAchse;
               return;
               
            else
               null;
            end if;
      end case;
      
      KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                  ÄnderungExtern    => (0, -Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) - 1, 0));
      
      case
        KartenWert.YAchse
      is
         when KartenKonstanten.LeerYAchse =>
            null;
            
         when others =>
            if
              KartenWert.YAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse
            then
               GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                                                                                ÄnderungExtern   => (0, -1, 0)).YAchse;
               return;
               
            else
               null;
            end if;
      end case;
      
   end AlteYAchseFestlegenSFML;
   
   
   
   procedure AlteXAchseFestlegenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                  ÄnderungExtern    => (0, 0, Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) + 1));
                                                                  
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            if
              KartenWert.XAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse
            then
               GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                                                                                ÄnderungExtern   => (0, 0, 1)).XAchse;
               return;
               
            else
               null;
            end if;
      end case;
      
      KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                  ÄnderungExtern    => (0, 0, -Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) - 1));
      
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            if
              KartenWert.XAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse
            then
               GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                                                                                ÄnderungExtern   => (0, 0, -1)).XAchse;
               return;
               
            else
               null;
            end if;
      end case;
   
   end AlteXAchseFestlegenSFML;

end CursorPositionAltFestlegen;
