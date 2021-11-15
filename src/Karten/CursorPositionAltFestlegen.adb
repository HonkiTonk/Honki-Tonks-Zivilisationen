pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;

with Karten;

package body CursorPositionAltFestlegen is

   procedure CursorPositionAltFestlegen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive)
   is begin
      
      AlteEAchseFestlegen (RasseExtern => RasseExtern);
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            AlteYAchseFestlegenKonsole (RasseExtern                  => RasseExtern,
                                        BewegungsfeldFestlegenExtern => BewegungsfeldFestlegenExtern);
            AlteXAchseFestlegenKonsole (RasseExtern                  => RasseExtern,
                                        BewegungsfeldFestlegenExtern => BewegungsfeldFestlegenExtern);
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            AlteYAchseFestlegenSFML (RasseExtern                  => RasseExtern,
                                     BewegungsfeldFestlegenExtern => BewegungsfeldFestlegenExtern);
            AlteXAchseFestlegenSFML (RasseExtern                  => RasseExtern,
                                     BewegungsfeldFestlegenExtern => BewegungsfeldFestlegenExtern);
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
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse
           > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse - Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse;
            
         else
            null;
         end if;
         
      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse < Karten.WeltkarteArray'First (2)
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse
           < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse + Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse;
            
         else
            null;
         end if;
         
      else
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
           or
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse;
            
         else
            null;
         end if;
      end if;
      
   end AlteYAchseFestlegenKonsole;
   
   
   
   procedure AlteXAchseFestlegenKonsole
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse
           > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse;
            
         else
            null;
         end if;
         
      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse < Karten.WeltkarteArray'First (3)
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse
           < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse;
            
         else
            null;
         end if;
         
      else
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
           or
             GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse;
            
         else
            null;
         end if;
      end if;
      
   end AlteXAchseFestlegenKonsole;
   
   
   
   procedure AlteYAchseFestlegenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - 1;
         
      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse < Karten.WeltkarteArray'First (2)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + 1;
         
      else
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse + 1;
           
         elsif
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.YAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).YAchse
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.YAchse - 1;
            
         else
            null;
         end if;
      end if;
      
   end AlteYAchseFestlegenSFML;
   
   
   
   procedure AlteXAchseFestlegenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - 1;
         
      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse < Karten.WeltkarteArray'First (3)
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + 1;
         
      else
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse + 1;
            
         elsif
           GlobaleVariablen.CursorImSpiel (RasseExtern).Position.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - Sichtweiten.Bewegungsfeld (BewegungsfeldFestlegenExtern).XAchse
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.XAchse - 1;
            
         else
            null;
         end if;
      end if;
      
   end AlteXAchseFestlegenSFML;

end CursorPositionAltFestlegen;
