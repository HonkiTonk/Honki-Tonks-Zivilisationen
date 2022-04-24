pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;
with GrafikDatentypen;
with OptionenVariablen;
with SpielVariablen;

with Karten;
with Kartenkoordinatenberechnungssystem;
with Sichtweiten;

package body CursorAltPlatzieren is

   procedure CursorAltPlatzieren
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AlteEAchseFestlegen (RasseExtern => RasseExtern);
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
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
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.EAchse = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse
      then
         null;
            
      else
         SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.EAchse := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse;
      end if;
      
   end AlteEAchseFestlegen;
   
   
   
   procedure AlteYAchseFestlegenKonsole
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) > Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
      then
         if
           SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse < SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True)
           and
             SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse
           > SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) - Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
         then
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse;
            
         else
            null;
         end if;
         
      elsif
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) < Karten.WeltkarteArray'First (2)
      then
         if
           SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse > SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True)
           and
             SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse
           < SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) + Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße
         then
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse;
            
         else
            null;
         end if;
         
      else
         if
           SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse > SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True)
           or
             SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse < SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True)
         then
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse;
            
         else
            null;
         end if;
      end if;
      
   end AlteYAchseFestlegenKonsole;
   
   
   
   procedure AlteXAchseFestlegenKonsole
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) > Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße
      then
         if
           SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse < SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False)
           and
             SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse
           > SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) - Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße
         then
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse;
            
         else
            null;
         end if;
         
      elsif
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) < Karten.WeltkarteArray'First (3)
      then
         if
           SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse > SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False)
           and
             SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse
           < SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) + Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße
         then
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse;
            
         else
            null;
         end if;
         
      else
         if
           SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse > SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse + Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False)
           or
             SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse < SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse - Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False)
         then
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse;
            
         else
            null;
         end if;
      end if;
      
   end AlteXAchseFestlegenKonsole;
   
   
   
   procedure AlteYAchseFestlegenSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse
      then
         return;
         
      else
         null;
      end if;
      
      KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                           ÄnderungExtern    => (0, Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) + 1, 0),
                                                                                           LogikGrafikExtern => False);
      
      case
        KartenWert.YAchse
      is
         when KartenKonstanten.LeerYAchse =>
            null;
            
         when others =>
            if
              KartenWert.YAchse = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse
            then
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse
                 := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                           ÄnderungExtern    => (0, 1, 0),
                                                                                           LogikGrafikExtern => False).YAchse;
               return;
               
            else
               null;
            end if;
      end case;
      
      KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                           ÄnderungExtern    => (0, -Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => True) - 1, 0),
                                                                                           LogikGrafikExtern => False);
      
      case
        KartenWert.YAchse
      is
         when KartenKonstanten.LeerYAchse =>
            null;
            
         when others =>
            if
              KartenWert.YAchse = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse
            then
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse
                 := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
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
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse
      then
         return;
         
      else
         null;
      end if;
      
      KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                           ÄnderungExtern    => (0, 0, Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) + 1),
                                                                                           LogikGrafikExtern => False);
                                                                  
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            if
              KartenWert.XAchse = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse
            then
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse
                 := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                           ÄnderungExtern    => (0, 0, 1),
                                                                                           LogikGrafikExtern => False).XAchse;
               return;
               
            else
               null;
            end if;
      end case;
      
      KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                           ÄnderungExtern    => (0, 0, -Sichtweiten.BewegungsfeldLesen (YAchseXAchseExtern => False) - 1),
                                                                                           LogikGrafikExtern => False);
      
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            if
              KartenWert.XAchse = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse
            then
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse
                 := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                           ÄnderungExtern    => (0, 0, -1),
                                                                                           LogikGrafikExtern => False).XAchse;
               return;
               
            else
               null;
            end if;
      end case;
   
   end AlteXAchseFestlegenSFML;

end CursorAltPlatzieren;
