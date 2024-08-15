with Sf.Graphics.RenderWindow;
with Sf.Graphics.View;

with KartenartDatentypen;
with KartenKonstanten;
with ZeitKonstanten;
with Views;
with EinheitenKonstanten;
with ViewKonstanten;
with GrafikKonstanten;
with SystemDatentypen;
with InteraktionAuswahl;

with LeseCursor;
with SchreibeCursor;
with LeseGrafiktask;
with SchreibeGrafiktask;

with KartenkoordinatenberechnungssystemLogik;
with SichtweitenGrafik;
with FensterGrafik;
with Vergleiche;
with GeheZuGrafik;

package body CursorplatzierungAltGrafik is

   procedure CursorplatzierungAlt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      EinheitenkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      case
        LeseGrafiktask.GeheZu.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            if
              Clock - Scrollzeit > ZeitKonstanten.ScrollverzögernMinimalzoom
              and
                SichtweitenGrafik.SichthöheLesen <= Scrollgeschwindigkeitsänderung
            then
               null;
                
            elsif
              Clock - Scrollzeit > ZeitKonstanten.Scrollverzögerung
              and
                SichtweitenGrafik.SichthöheLesen > Scrollgeschwindigkeitsänderung
            then
               null;
               
            else
               return;
            end if;
            
            Scrollzeit := Clock;
            
            if
              BefehlsknöpfePrüfen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
            then
               null;
                  
            else
               Platzierung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                            EinheitenkoordinatenExtern => EinheitenkoordinatenExtern);
            end if;
                  
         when others =>
            GeheZuGrafik.GeheZuFestlegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
      end case;
      
   end CursorplatzierungAlt;
   
   
   
   procedure Platzierung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      EinheitenkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      case
        LeseCursor.EAchseAktuell (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
      is
         when KartenKonstanten.LeerEAchse =>
            return;
            
         when others =>
            null;
      end case;
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte));
      
      SchreibeCursor.EAchseAlt (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                EAchseExtern  => LeseCursor.EAchseAktuell (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies));
      
      case
        EinheitSpeziesNummerExtern.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            EinheitFolgen := True;
            
         when others =>
            EinheitFolgen := Einheitenbereich (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                               EinheitenkoordinatenExtern => EinheitenkoordinatenExtern);
      end case;
      
      case
        EinheitFolgen
      is
         when False =>
            SchreibeGrafiktask.GeheZu (KoordinatenExtern => EinheitenkoordinatenExtern);
            return;
            
         when True =>
            Koordinatenänderung.YAchse := AlteYAchseFestlegen (MauspositionExtern => Mausposition,
                                                                YAchseAltExtern    => LeseCursor.YAchseAlt (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies));
            
            Koordinatenänderung.XAchse := AlteXAchseFestlegen (MausachseExtern => Mausposition.x,
                                                                XAchseAltExtern => LeseCursor.XAchseAlt (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies));
      end case;
      
      Koordinatenänderung.EAchse := KartenKonstanten.LeerEAchseÄnderung;
      
      Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseCursor.KoordinatenAlt (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies),
                                                                                                ÄnderungExtern    => Koordinatenänderung,
                                                                                                TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
      
      case
        Kartenwert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            SchreibeCursor.KoordinatenAlt (SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies,
                                           KoordinatenExtern => Kartenwert);
      end case;
      
   end Platzierung;
   
   
   
   function Einheitenbereich
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      EinheitenkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      case
        LeseGrafiktask.EinheitBewegt
      is
         when False =>
            return True;
            
         when True =>
            SchreibeGrafiktask.EinheitBewegt (JaNeinExtern => False);
      end case;
      
      AlteCursorkoordinaten := LeseCursor.KoordinatenAlt (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
      Sichtbereich := SichtweitenGrafik.SichtbereichLesen;
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Sichtbereich.YAchse .. Sichtbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Sichtbereich.XAchse .. Sichtbereich.XAchse loop
            
            Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AlteCursorkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
            
            if
              Kartenwert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              EinheitenkoordinatenExtern = Kartenwert
            then
               return True;
               
            else
               null;
            end if;
              
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return False;
      
   end Einheitenbereich;
   
   
   
   function BefehlsknöpfePrüfen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
            
      if
       InteraktionAuswahl.LeseXMausachse < GrafikKonstanten.Nullwert
        or
          InteraktionAuswahl.LeseYMausachse < GrafikKonstanten.Nullwert
      then
         null;
         
      else
         Viewfläche := Sf.Graphics.View.getSize (view => Views.KartenbefehlsviewAccess);
         Viewzentrum := Sf.Graphics.View.getCenter (view => Views.KartenbefehlsviewAccess);
         
         Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                    point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                    view         => Views.KartenbefehlsviewAccess);
      
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       RechteckExtern     => (Viewzentrum.x - Viewfläche.x / GrafikKonstanten.Halbierung, Viewzentrum.y - Viewfläche.y / GrafikKonstanten.Halbierung, Viewfläche.x, Viewfläche.y))
         is
            when True =>
               return True;
               
            when False =>
               null;
         end case;
      end if;
                        
      if
        EinheitSpeziesNummerExtern.Nummer = EinheitenKonstanten.LeerNummer
      then
         null;
         
      elsif
        InteraktionAuswahl.LeseXMausachse <= GrafikKonstanten.Nullwert
        or
          InteraktionAuswahl.LeseYMausachse <= GrafikKonstanten.Nullwert
      then
         null;
         
      else
         Viewfläche := Sf.Graphics.View.getSize (view => Views.EinheitenbefehlsviewAccess);
         Viewzentrum := Sf.Graphics.View.getCenter (view => Views.EinheitenbefehlsviewAccess);
         
         Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                    point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                    view         => Views.EinheitenbefehlsviewAccess);
            
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       RechteckExtern     => (Viewzentrum.x - Viewfläche.x / GrafikKonstanten.Halbierung, Viewzentrum.y - Viewfläche.y / GrafikKonstanten.Halbierung, Viewfläche.x, Viewfläche.y))
         is
            when True =>
               return True;
               
            when False =>
               null;
         end case;
      end if;
      
      return False;
      
   end BefehlsknöpfePrüfen;
   
   
   
   function AlteYAchseFestlegen
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      YAchseAltExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechteUmgebungEins
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      Achsenviewfläche := Sf.Graphics.View.getSize (view => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte));
      AktuelleSichtweite := SichtweitenGrafik.SichthöheLesen;
      YAchseÜbergänge := LeseWeltkarteneinstellungen.KartenformYAchse;
      
      if
        MauspositionExtern.x not in GrafikKonstanten.Nullwert .. Achsenviewfläche.x
      then
         return KeineYÄnderung;
      
      elsif
        MauspositionExtern.y in GrafikKonstanten.Nullwert .. SichtweitenGrafik.Kartenfeldfläche.y / Scrollbereichanteil
      then
         if
           YAchseAltExtern - AktuelleSichtweite <= KartenKonstanten.AnfangYAchse
           and
             YAchseÜbergänge.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
         then
            return KeineYÄnderung;
            
         elsif
           YAchseAltExtern - AktuelleSichtweite <= KartenKonstanten.AnfangYAchse - 1
           and
             YAchseÜbergänge.YAchseNorden = KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
         then
            return KeineYÄnderung;
            
         else
            return RichtungYNull;
         end if;
         
      elsif
        MauspositionExtern.y in Achsenviewfläche.y - SichtweitenGrafik.Kartenfeldfläche.y / Scrollbereichanteil .. Achsenviewfläche.y
      then
         if
           YAchseAltExtern + AktuelleSichtweite >= LeseWeltkarteneinstellungen.YAchse
           and
             YAchseÜbergänge.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
         then
            return KeineYÄnderung;
            
         elsif
           YAchseAltExtern + AktuelleSichtweite >= LeseWeltkarteneinstellungen.YAchse + 1
           and
             YAchseÜbergänge.YAchseSüden = KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
         then
            return KeineYÄnderung;
         
         else
            return RichtungYMaximum;
         end if;
      
      else
         return KeineYÄnderung;
      end if;
      
   end AlteYAchseFestlegen;
   
   
   
   function AlteXAchseFestlegen
     (MausachseExtern : in Float;
      XAchseAltExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechteUmgebungEins
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      XAchsenbereich := Sf.Graphics.View.getSize (view => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte)).x;
      AktuelleSichtbreite := SichtweitenGrafik.SichtbreiteLesen;
      XAchseÜbergänge := LeseWeltkarteneinstellungen.KartenformXAchse;
      
      if
        MausachseExtern in GrafikKonstanten.Nullwert .. SichtweitenGrafik.Kartenfeldfläche.x / Scrollbereichanteil
      then
         if
           XAchseAltExtern - AktuelleSichtbreite <= KartenKonstanten.AnfangXAchse
           and
             XAchseÜbergänge.XAchseWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
         then
            return KeineXÄnderung;
            
         elsif
           XAchseAltExtern - AktuelleSichtbreite <= KartenKonstanten.AnfangXAchse - 1
           and
             XAchseÜbergänge.XAchseWesten = KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
         then
            return KeineXÄnderung;
            
         else
            return RichtungXNull;
         end if;
         
      elsif
        MausachseExtern in XAchsenbereich - SichtweitenGrafik.Kartenfeldfläche.x / Scrollbereichanteil .. XAchsenbereich
      then
         if
           XAchseAltExtern + AktuelleSichtbreite >= LeseWeltkarteneinstellungen.XAchse
           and
             XAchseÜbergänge.XAchseOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
         then
            return KeineXÄnderung;
            
         elsif
           XAchseAltExtern + AktuelleSichtbreite >= LeseWeltkarteneinstellungen.XAchse + 1
           and
             XAchseÜbergänge.XAchseOsten = KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
         then
            return KeineXÄnderung;
         
         else
            return RichtungXMaximum;
         end if;
         
      else
         return KeineXÄnderung;
      end if;
      
   end AlteXAchseFestlegen;

end CursorplatzierungAltGrafik;
