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
            if
              Ada.Calendar.Clock - Scrollzeit > ZeitKonstanten.ScrollverzögernMinimalzoom
              and
                Sichtweiten.SichtweiteLesen <= 4
            then
               null;
                
            elsif
              Ada.Calendar.Clock - Scrollzeit > ZeitKonstanten.Scrollverzögerung
              and
                Sichtweiten.SichtweiteLesen > 4
            then
               null;
                     
            else
               return;
            end if;
            
            Scrollzeit := Clock;
            Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                                       point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                       view         => Views.KartenviewAccess);
            
            -- Die EAchse später auch noch über eine Funktion die Änderung ermitteln oder einfach so lassen? äöü
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.EAchse := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse;
            
            Koordinatenänderung.EAchse := 0;
            Koordinatenänderung.YAchse := AlteYAchseFestlegen (MausachseExtern => Mausposition.y,
                                                                YAchseAlt       => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse);
            
            Koordinatenänderung.XAchse := AlteXAchseFestlegen (MausachseExtern => Mausposition.x,
                                                                XAchseAlt       => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse);
           
            Kartenwert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                                 ÄnderungExtern    => Koordinatenänderung,
                                                                                                 LogikGrafikExtern => False);
            
            if
              Kartenwert.EAchse = KartenKonstanten.LeerEAchse
            then
               null;
                  
            else
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt := Kartenwert;
            end if;
                  
         when others =>
            GeheZuFestlegung (RasseExtern => RasseExtern);
      end case;
      
   end CursorAltPlatzieren;
   
   
   
   -- Eventuell später noch erweitern damit auch bei anderen Einstellungen die Verschiebung korrekter ist. äöü
   -- Gilt auch für die Anpassung in BewegungCursor. äöü
   function AlteYAchseFestlegen
     (MausachseExtern : in Float;
      YAchseAlt : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.UmgebungsbereichEins
   is begin
         
      -- 0.001 sind dafür da, damit man beim Verlassen des Fensters nicht mehr weiterscrollt.
      -- Dafür später eine bessere Lösung finden? äöü
      if
        MausachseExtern in 0.001 .. BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00
      then
         if
           YAchseAlt <= Karten.WeltkarteArray'First (2) + Sichtweiten.SichtweiteLesen
           and
             Karten.Karteneinstellungen.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
         then
            return 0;
            
         else
            return -1;
         end if;
         
      elsif
        MausachseExtern in Sf.Graphics.View.getSize (view => Views.KartenviewAccess).y - BerechnungenKarteSFML.KartenfelderAbmessung.y / 2.00 .. Sf.Graphics.View.getSize (view => Views.KartenviewAccess).y - 0.001
      then
         if
           YAchseAlt >= Karten.Karteneinstellungen.Kartengröße.YAchse - Sichtweiten.SichtweiteLesen
           and
             Karten.Karteneinstellungen.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
         then
            return 0;
         
         else
            return 1;
         end if;
      
      else
         return 0;
      end if;
      
   end AlteYAchseFestlegen;
   
   
   
   function AlteXAchseFestlegen
     (MausachseExtern : in Float;
      XAchseAlt : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.UmgebungsbereichEins
   is begin
      
      -- 0.001 sind dafür da, damit man beim Verlassen des Fensters nicht mehr weiterscrollt.
      -- Dafür später eine bessere Lösung finden? äöü
      if
        MausachseExtern in 0.001 .. BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00
      then
         if
           XAchseAlt <= Karten.WeltkarteArray'First (3) + Sichtweiten.SichtweiteLesen
           and
             Karten.Karteneinstellungen.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
         then
            return 0;
            
         else
            return -1;
         end if;
         
      elsif
        MausachseExtern in Sf.Graphics.View.getSize (view => Views.KartenviewAccess).x - BerechnungenKarteSFML.KartenfelderAbmessung.x / 2.00 .. Sf.Graphics.View.getSize (view => Views.KartenviewAccess).x
      then
         if
           XAchseAlt >= Karten.Karteneinstellungen.Kartengröße.XAchse - Sichtweiten.SichtweiteLesen
           and
             Karten.Karteneinstellungen.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
         then
            return 0;
         
         else
            return 1;
         end if;
         
      else
         return 0;
      end if;
      
   end AlteXAchseFestlegen;
   
   
   
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
