pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;
with KartenRecordKonstanten;

with Kartenkoordinatenberechnungssystem;
with Sichtweiten;
with NachGrafiktask;

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
   
   
   
   -- Das Festlegen stattdessen auf Basis der Mauszeigerposition festlegen? äöü
   procedure AlteYAchseFestlegenSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse
      then
         return;
         
      else
         Kartenwert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                              ÄnderungExtern    => (0, Sichtweiten.BewegungsfeldLesen + 1, 0),
                                                                                              LogikGrafikExtern => False);
      end if;
      
      case
        Kartenwert.YAchse
      is
         when KartenKonstanten.LeerYAchse =>
            null;
            
         when others =>
            if
              Kartenwert.YAchse = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse
              and
                (Kartenwert.YAchse + 1 <= Karten.Karteneinstellungen.Kartengröße.YAchse
                 or
                   Karten.Karteneinstellungen.Kartenform.YAchseSüden /= KartenDatentypen.Karte_Y_Kein_Übergang_Enum)
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
      
      Kartenwert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                           ÄnderungExtern    => (0, -Sichtweiten.BewegungsfeldLesen - 1, 0),
                                                                                           LogikGrafikExtern => False);
      
      case
        Kartenwert.YAchse
      is
         when KartenKonstanten.LeerYAchse =>
            null;
            
         when others =>
            if
              Kartenwert.YAchse = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse
              and
                (Kartenwert.YAchse - 1 >= Karten.WeltkarteArray'First (2)
                 or
                   Karten.Karteneinstellungen.Kartenform.YAchseNorden /= KartenDatentypen.Karte_Y_Kein_Übergang_Enum)
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
         Kartenwert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                              ÄnderungExtern    => (0, 0, Sichtweiten.BewegungsfeldLesen + 1),
                                                                                              LogikGrafikExtern => False);
      end if;
                                                                        
      case
        Kartenwert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            if
              Kartenwert.XAchse = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse
              and
                (Kartenwert.XAchse + 1 <= Karten.Karteneinstellungen.Kartengröße.XAchse
                 or
                   Karten.Karteneinstellungen.Kartenform.XAchseOsten /= KartenDatentypen.Karte_X_Kein_Übergang_Enum)
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
      
      Kartenwert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                           ÄnderungExtern    => (0, 0, -Sichtweiten.BewegungsfeldLesen - 1),
                                                                                           LogikGrafikExtern => False);
      
      case
        Kartenwert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            if
              Kartenwert.XAchse = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse
              and
                (Kartenwert.XAchse - 1 >= Karten.WeltkarteArray'First (3)
                 or
                   Karten.Karteneinstellungen.Kartenform.XAchseWesten /= KartenDatentypen.Karte_X_Kein_Übergang_Enum)
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
                
      Kartenwert := Koordinatenberechnung (KoordinatenExtern => NachGrafiktask.GeheZu);
      
      case
        Kartenwert.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt := NachGrafiktask.GeheZu;
            
         when others =>
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt := Kartenwert;
      end case;
      
      NachGrafiktask.GeheZu := KartenRecordKonstanten.LeerKoordinate;
      
   end GeheZuFestlegung;
   
   
   
   function Koordinatenberechnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      KartenwertKoordinatenberechnung.EAchse := KoordinatenExtern.EAchse;
      
      if
        KoordinatenExtern.YAchse <= Karten.WeltkarteArray'First (2) + Sichtweiten.SichtweiteLesen / 2
      then
         KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse + Sichtweiten.BewegungsfeldLesen + 1;
         
      elsif
        KoordinatenExtern.YAchse >= Karten.Karteneinstellungen.Kartengröße.YAchse - Sichtweiten.SichtweiteLesen / 2
      then
         KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse - Sichtweiten.BewegungsfeldLesen - 1;
         
      else
         KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
      end if;
      
      if
        KoordinatenExtern.XAchse <= Karten.WeltkarteArray'First (3) + Sichtweiten.SichtweiteLesen / 2
      then
         KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse + Sichtweiten.BewegungsfeldLesen;
         
      elsif
        KoordinatenExtern.XAchse >= Karten.Karteneinstellungen.Kartengröße.XAchse - Sichtweiten.SichtweiteLesen / 2
      then
         KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse - Sichtweiten.BewegungsfeldLesen;
         
      else
         KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse;
      end if;
      
      KartenwertKoordinatenberechnung := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KartenwertKoordinatenberechnung,
                                                                                                                ÄnderungExtern    => (0, 0, 0),
                                                                                                                LogikGrafikExtern => False);
      
      return KartenwertKoordinatenberechnung;
      
   end Koordinatenberechnung;

end CursorAltPlatzieren;
