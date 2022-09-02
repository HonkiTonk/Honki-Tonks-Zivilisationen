pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.View;

with KartenKonstanten;
with KartenRecordKonstanten;
with ZeitKonstanten;
with Views;

with Kartenkoordinatenberechnungssystem;
with Sichtweiten;
with NachGrafiktask;
with GrafikEinstellungenSFML;
with NachLogiktask;
with BerechnungenKarteSFML;

package body CursorAltPlatzieren is

   procedure CursorAltPlatzieren
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        NachGrafiktask.GeheZu.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                                       point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                       view         => Views.KartenviewAccess);
              
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.EAchse := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse;
            
            Koordinatenänderung.EAchse := 0;
            Koordinatenänderung.YAchse := AlteYAchseFestlegen (MausachseExtern => Mausposition.y);
            
            Koordinatenänderung.XAchse := AlteXAchseFestlegen (MausachseExtern => Mausposition.x);
            
            -- AlteYAchseFestlegenSFML (RasseExtern => RasseExtern);
            -- AlteXAchseFestlegenSFML (RasseExtern => RasseExtern);
           
            Kartenwert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                                 ÄnderungExtern    => Koordinatenänderung,
                                                                                                 LogikGrafikExtern => False);
            
            case
              Kartenwert.EAchse
            is
               when KartenKonstanten.LeerEAchse =>
                  null;
                  
               when others =>
                  if
                    Ada.Calendar.Clock - Scrollzeit > ZeitKonstanten.Scrollverzögerung
                  then
                     SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt := Kartenwert;
                     Scrollzeit := Clock;
                     
                  else
                     null;
                  end if;
            end case;
                  
         when others =>
            GeheZuFestlegung (RasseExtern => RasseExtern);
      end case;
      
   end CursorAltPlatzieren;
   
   
   
   function AlteYAchseFestlegen
     (MausachseExtern : in Float)
      return KartenDatentypen.UmgebungsbereichEins
   is begin
      
      -- 0.001 sind dafür da, damit man beim Verlassen des Fensters nicht mehr weiterscrollt.
      -- Dafür später eine bessere Lösung finden. äöü
      if
        MausachseExtern in 0.001 .. BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00
      then
         return -1;
         
      elsif
        MausachseExtern in Sf.Graphics.View.getSize (view => Views.KartenviewAccess).y - BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00 .. Sf.Graphics.View.getSize (view => Views.KartenviewAccess).y - 0.001
      then
         return 1;
         
      else
         return 0;
      end if;
      
   end AlteYAchseFestlegen;
   
   
   
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
      
      if
        Kartenwert.YAchse = KartenKonstanten.LeerYAchse
      then
         null;
         
      elsif
        Mausposition.y < Sf.Graphics.View.getCenter (view => Views.KartenviewAccess).y
      then
         null;
         
      else
         if
           Kartenwert.YAchse = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse
           and
             Ada.Calendar.Clock - Scrollzeit > ZeitKonstanten.Scrollverzögerung
             and
               (Kartenwert.YAchse + 1 <= Karten.Karteneinstellungen.Kartengröße.YAchse
                or
                  Karten.Karteneinstellungen.Kartenform.YAchseSüden /= KartenDatentypen.Karte_Y_Kein_Übergang_Enum)
         then
            Scrollzeit := Clock;
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse
              := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                        ÄnderungExtern    => (0, 1, 0),
                                                                                        LogikGrafikExtern => False).YAchse;
            return;
               
         else
            null;
         end if;
      end if;
      
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
                Ada.Calendar.Clock - Scrollzeit > ZeitKonstanten.Scrollverzögerung
                and
                  (Kartenwert.YAchse - 1 >= Karten.WeltkarteArray'First (2)
                   or
                     Karten.Karteneinstellungen.Kartenform.YAchseNorden /= KartenDatentypen.Karte_Y_Kein_Übergang_Enum)
            then
               Scrollzeit := Clock;
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse
                 := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                           ÄnderungExtern    => (0, -1, 0),
                                                                                           LogikGrafikExtern => False).YAchse;
               
            else
               null;
            end if;
      end case;
      
   end AlteYAchseFestlegenSFML;
   
   
   
   function AlteXAchseFestlegen
     (MausachseExtern : in Float)
      return KartenDatentypen.UmgebungsbereichEins
   is begin
      
      if
        MausachseExtern in 0.001 .. BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00
      then
         return -1;
         
      elsif
        MausachseExtern in Sf.Graphics.View.getSize (view => Views.KartenviewAccess).x - BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00 .. Sf.Graphics.View.getSize (view => Views.KartenviewAccess).x
      then
         return 1;
         
      else
         return 0;
      end if;
      
   end AlteXAchseFestlegen;
   
   
   
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
      
      if
        Kartenwert.XAchse = KartenKonstanten.LeerXAchse
      then
         null;
         
      elsif
        Mausposition.x < Sf.Graphics.View.getCenter (view => Views.KartenviewAccess).x
      then
         null;
         
      else
         if
           Kartenwert.XAchse = SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse
           and
             Ada.Calendar.Clock - Scrollzeit > ZeitKonstanten.Scrollverzögerung
             and
               (Kartenwert.XAchse + 1 <= Karten.Karteneinstellungen.Kartengröße.XAchse
                or
                  Karten.Karteneinstellungen.Kartenform.XAchseOsten /= KartenDatentypen.Karte_X_Kein_Übergang_Enum)
         then
            Scrollzeit := Clock;
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse
              := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                        ÄnderungExtern    => (0, 0, 1),
                                                                                        LogikGrafikExtern => False).XAchse;
            return;
               
         else
            null;
         end if;
      end if;
      
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
                Ada.Calendar.Clock - Scrollzeit > ZeitKonstanten.Scrollverzögerung
                and
                  (Kartenwert.XAchse - 1 >= Karten.WeltkarteArray'First (3)
                   or
                     Karten.Karteneinstellungen.Kartenform.XAchseWesten /= KartenDatentypen.Karte_X_Kein_Übergang_Enum)
            then
               Scrollzeit := Clock;
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse
                 := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                           ÄnderungExtern    => (0, 0, -1),
                                                                                           LogikGrafikExtern => False).XAchse;
               
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
