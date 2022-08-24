pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;
with KartenRecordKonstanten;

with Kartenkoordinatenberechnungssystem;
with Sichtweiten;
with NachGrafiktask;
with Karten;

package body CursorAltPlatzieren is

   procedure CursorAltPlatzieren
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        NachGrafiktask.GeheZu.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.EAchse := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse;
            AlteYAchseFestlegenSFML (RasseExtern => RasseExtern);
            AlteXAchseFestlegenSFML (RasseExtern => RasseExtern);
            
         when others =>
            GeheZuFestlegung (RasseExtern => RasseExtern);
      end case;
      
   end CursorAltPlatzieren;
   
   
   
   procedure AlteYAchseFestlegenSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse
      then
         return;
         
      else
         KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                              ÄnderungExtern    => (0, Sichtweiten.BewegungsfeldLesen + 1, 0),
                                                                                              LogikGrafikExtern => False);
      end if;
      
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
                                                                                           ÄnderungExtern    => (0, -Sichtweiten.BewegungsfeldLesen - 1, 0),
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
         KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                              ÄnderungExtern    => (0, 0, Sichtweiten.BewegungsfeldLesen + 1),
                                                                                              LogikGrafikExtern => False);
      end if;
                                                                        
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
                                                                                           ÄnderungExtern    => (0, 0, -Sichtweiten.BewegungsfeldLesen - 1),
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
   
   
   
   procedure GeheZuFestlegung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      KartenWert.EAchse := NachGrafiktask.GeheZu.EAchse;
      
      if
        NachGrafiktask.GeheZu.YAchse <= Karten.WeltkarteArray'First (2) + Sichtweiten.SichtweiteLesen / 2
      then
         KartenWert.YAchse := NachGrafiktask.GeheZu.YAchse + Sichtweiten.BewegungsfeldLesen;
         
      elsif
        NachGrafiktask.GeheZu.YAchse >= Karten.Karteneinstellungen.Kartengröße.YAchse - Sichtweiten.SichtweiteLesen / 2
      then
         KartenWert.YAchse := NachGrafiktask.GeheZu.YAchse - Sichtweiten.BewegungsfeldLesen;
         
      else
         KartenWert.YAchse := NachGrafiktask.GeheZu.YAchse;
      end if;
      
      if
        NachGrafiktask.GeheZu.XAchse <= Karten.WeltkarteArray'First (3) + Sichtweiten.SichtweiteLesen / 2
      then
         KartenWert.XAchse := NachGrafiktask.GeheZu.XAchse + Sichtweiten.BewegungsfeldLesen;
         
      elsif
        NachGrafiktask.GeheZu.XAchse >= Karten.Karteneinstellungen.Kartengröße.XAchse - Sichtweiten.SichtweiteLesen / 2
      then
         KartenWert.XAchse := NachGrafiktask.GeheZu.XAchse - Sichtweiten.BewegungsfeldLesen;
         
      else
         KartenWert.XAchse := NachGrafiktask.GeheZu.XAchse;
      end if;
      
      KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KartenWert,
                                                                                           ÄnderungExtern    => (0, 0, 0),
                                                                                           LogikGrafikExtern => False);
      
      case
        KartenWert.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt := NachGrafiktask.GeheZu;
            
         when others =>
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt := KartenWert;
      end case;
      
      NachGrafiktask.GeheZu := KartenRecordKonstanten.LeerKoordinate;
      
   end GeheZuFestlegung;

end CursorAltPlatzieren;
