pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.View;

with KartenKonstanten;
with ZeitKonstanten;
with Views;
with EinheitenKonstanten;

with Kartenkoordinatenberechnungssystem;
with Sichtweiten;
with NachGrafiktask;
with EinstellungenGrafik;
with NachLogiktask;
with KartenberechnungenGrafik;
with Vergleiche;
with GeheZuGrafik;

package body CursorplatzierungAltGrafik is

   procedure CursorplatzierungAlt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
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
            
            if
              BefehlsknöpfePrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               return;
                  
            else
               Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                          point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                          view         => Views.KartenviewAccess);
            end if;
                                    
            -- Die EAchse später auch noch über eine Funktion die Änderung ermitteln oder einfach so lassen? äöü
            SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt.EAchse := SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAktuell.EAchse;
            
            Koordinatenänderung.EAchse := 0;
            Koordinatenänderung.YAchse := AlteYAchseFestlegen (MausachseExtern => Mausposition.y,
                                                                YAchseAlt       => SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt.YAchse);
            
            Koordinatenänderung.XAchse := AlteXAchseFestlegen (MausachseExtern => Mausposition.x,
                                                                XAchseAlt       => SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt.XAchse);
           
            Kartenwert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt,
                                                                                                 ÄnderungExtern    => Koordinatenänderung,
                                                                                                 LogikGrafikExtern => False);
            
            if
              Kartenwert.EAchse = KartenKonstanten.LeerEAchse
            then
               null;
                  
            else
               SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt := Kartenwert;
            end if;
                  
         when others =>
            GeheZuGrafik.GeheZuFestlegung (RasseExtern => EinheitRasseNummerExtern.Rasse);
      end case;
      
   end CursorplatzierungAlt;
   
   
   
   function BefehlsknöpfePrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      -- Hierfür später mal eine bessere Lösung einbauen. äöü
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.KartenbefehlsviewAccess);
            
      case
        Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                    TextboxExtern      => (Sf.Graphics.View.getCenter (view => Views.KartenbefehlsviewAccess).x - Sf.Graphics.View.getSize (view => Views.KartenbefehlsviewAccess).x / 2.00,
                                                           Sf.Graphics.View.getCenter (view => Views.KartenbefehlsviewAccess).y - Sf.Graphics.View.getSize (view => Views.KartenbefehlsviewAccess).y / 2.00,
                                                           Sf.Graphics.View.getSize (view => Views.KartenbefehlsviewAccess).x,
                                                           Sf.Graphics.View.getSize (view => Views.KartenbefehlsviewAccess).y))
      is
         when True =>
            return True;
               
         when False =>
            null;
      end case;
            
      if
        EinheitRasseNummerExtern.Nummer = EinheitenKonstanten.LeerNummer
      then
         null;
               
      else
         Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                    point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                    view         => Views.EinheitenbefehlsviewAccess);
            
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => (Sf.Graphics.View.getCenter (view => Views.EinheitenbefehlsviewAccess).x - Sf.Graphics.View.getSize (view => Views.EinheitenbefehlsviewAccess).x / 2.00,
                                                              Sf.Graphics.View.getCenter (view => Views.EinheitenbefehlsviewAccess).y - Sf.Graphics.View.getSize (view => Views.EinheitenbefehlsviewAccess).y / 2.00,
                                                              Sf.Graphics.View.getSize (view => Views.EinheitenbefehlsviewAccess).x,
                                                              Sf.Graphics.View.getSize (view => Views.EinheitenbefehlsviewAccess).y))
         is
            when True =>
               return True;
               
            when False =>
               null;
         end case;
      end if;
      
      return False;
      
   end BefehlsknöpfePrüfen;
   
   
   
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
        MausachseExtern in 0.001 .. KartenberechnungenGrafik.KartenfelderAbmessung.y / 2.00
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
        MausachseExtern in Sf.Graphics.View.getSize (view => Views.KartenviewAccess).y - KartenberechnungenGrafik.KartenfelderAbmessung.y / 2.00 .. Sf.Graphics.View.getSize (view => Views.KartenviewAccess).y - 0.001
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
        MausachseExtern in 0.001 .. KartenberechnungenGrafik.KartenfelderAbmessung.x / 2.00
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
        MausachseExtern in Sf.Graphics.View.getSize (view => Views.KartenviewAccess).x - KartenberechnungenGrafik.KartenfelderAbmessung.x / 2.00 .. Sf.Graphics.View.getSize (view => Views.KartenviewAccess).x
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

end CursorplatzierungAltGrafik;
