pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;

with Karten;

package body CursorPositionAltFestlegen is

   procedure CursorPositionAltFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      BewegungsfeldFestlegenExtern : in Positive)
   is begin
      
      AlteEAchseFestlegen (RasseExtern => RasseExtern);
      AlteYAchseFestlegen (RasseExtern                  => RasseExtern,
                           BewegungsfeldFestlegenExtern => BewegungsfeldFestlegenExtern);
      AlteXAchseFestlegen (RasseExtern                  => RasseExtern,
                           BewegungsfeldFestlegenExtern => BewegungsfeldFestlegenExtern);
      
   end CursorPositionAltFestlegen;
   
   
   
   procedure AlteEAchseFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.EAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse
      then
         null;
            
      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt.EAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).Position.EAchse;
      end if;
      
   end AlteEAchseFestlegen;
   
   
   
   procedure AlteYAchseFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
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
      
   end AlteYAchseFestlegen;
   
   
   
   procedure AlteXAchseFestlegen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
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
      
   end AlteXAchseFestlegen;

end CursorPositionAltFestlegen;
