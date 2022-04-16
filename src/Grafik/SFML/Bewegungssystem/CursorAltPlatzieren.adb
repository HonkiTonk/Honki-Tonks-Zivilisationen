pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;
with GrafikDatentypen;

with Karten;
with KarteKoordinatenPruefen;
with Sichtweiten;

package body CursorAltPlatzieren is

   procedure CursorAltPlatzieren
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AlteEAchseFestlegen (RasseExtern => RasseExtern);
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when GrafikDatentypen.Grafik_Konsole_Enum =>
            AlteYAchseFestlegenKonsole (RasseExtern => RasseExtern);
            AlteXAchseFestlegenKonsole (RasseExtern => RasseExtern);
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            AlteYAchseFestlegenSFML (RasseExtern => RasseExtern);
            AlteXAchseFestlegenSFML (RasseExtern => RasseExtern);
      end case;
      
   end CursorAltPlatzieren;
   
   
   
   procedure AlteEAchseFestlegen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.EAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse
      then
         null;
            
      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.EAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse;
      end if;
      
   end AlteEAchseFestlegen;
   
   
   
   procedure AlteYAchseFestlegenKonsole
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) > Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True)
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse
           > GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) - Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse;
            
         else
            null;
         end if;
         
      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) < Karten.WeltkarteArray'First (2)
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True)
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse
           < GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) + Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse;
            
         else
            null;
         end if;
         
      else
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True)
           or
             GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True)
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse;
            
         else
            null;
         end if;
      end if;
      
   end AlteYAchseFestlegenKonsole;
   
   
   
   procedure AlteXAchseFestlegenKonsole
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) > Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False)
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse
           > GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) - Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse;
            
         else
            null;
         end if;
         
      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) < Karten.WeltkarteArray'First (3)
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False)
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse
           < GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) + Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse;
            
         else
            null;
         end if;
         
      else
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False)
           or
             GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False)
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse;
            
         else
            null;
         end if;
      end if;
      
   end AlteXAchseFestlegenKonsole;
   
   
   
   procedure AlteYAchseFestlegenSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse
      then
         return;
         
      else
         null;
      end if;
      
      KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                     ÄnderungExtern    => (0, Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) + 1, 0),
                                                                     LogikGrafikExtern => False);
      
      case
        KartenWert.YAchse
      is
         when KartenKonstanten.LeerYAchse =>
            null;
            
         when others =>
            if
              KartenWert.YAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse
            then
               GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                                                                      ÄnderungExtern    => (0, 1, 0),
                                                                                                                                      LogikGrafikExtern => False).YAchse;
               return;
               
            else
               null;
            end if;
      end case;
      
      KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                     ÄnderungExtern    => (0, -Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) - 1, 0),
                                                                     LogikGrafikExtern => False);
      
      case
        KartenWert.YAchse
      is
         when KartenKonstanten.LeerYAchse =>
            null;
            
         when others =>
            if
              KartenWert.YAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse
            then
               GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                                                                      ÄnderungExtern    => (0, -1, 0),
                                                                                                                                      LogikGrafikExtern => False).YAchse;
               return;
               
            else
               null;
            end if;
      end case;
      
   end AlteYAchseFestlegenSFML;
   
   
   
   procedure AlteXAchseFestlegenSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse
      then
         return;
         
      else
         null;
      end if;
      
      KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                     ÄnderungExtern    => (0, 0, Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) + 1),
                                                                     LogikGrafikExtern => False);
                                                                  
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            if
              KartenWert.XAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse
            then
               GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                                                                      ÄnderungExtern    => (0, 0, 1),
                                                                                                                                      LogikGrafikExtern => False).XAchse;
               return;
               
            else
               null;
            end if;
      end case;
      
      KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                     ÄnderungExtern    => (0, 0, -Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) - 1),
                                                                     LogikGrafikExtern => False);
      
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            if
              KartenWert.XAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse
            then
               GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                                                                      ÄnderungExtern    => (0, 0, -1),
                                                                                                                                      LogikGrafikExtern => False).XAchse;
               return;
               
            else
               null;
            end if;
      end case;
   
   end AlteXAchseFestlegenSFML;

end CursorAltPlatzieren;
