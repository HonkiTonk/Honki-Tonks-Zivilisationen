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
      EinheitenkoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      case
        LeseGrafiktask.GeheZu.Ebene
      is
         when KartenKonstanten.LeerEbene =>
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
      EinheitenkoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      case
        LeseCursor.EbeneAktuell (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
      is
         when KartenKonstanten.LeerEbene =>
            return;
            
         when others =>
            null;
      end case;
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                 point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                 view         => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte));
      
      SchreibeCursor.EbeneAlt (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                EbeneExtern  => LeseCursor.EbeneAktuell (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies));
      
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
            Koordinatenänderung.Senkrechte := AlteSenkrechteFestlegen (MauspositionExtern => Mausposition,
                                                                SenkrechteAltExtern    => LeseCursor.SenkrechteAlt (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies));
            
            Koordinatenänderung.Waagerechte := AlteWaagerechteFestlegen (MausachseExtern => Mausposition.x,
                                                                WaagerechteAltExtern => LeseCursor.WaagerechteAlt (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies));
      end case;
      
      Koordinatenänderung.Ebene := KartenKonstanten.LeerEbeneÄnderung;
      
      Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseCursor.KoordinatenAlt (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies),
                                                                                                ÄnderungExtern    => Koordinatenänderung,
                                                                                                TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
      
      case
        Kartenwert.Waagerechte
      is
         when KartenKonstanten.LeerWaagerechte =>
            null;
            
         when others =>
            SchreibeCursor.KoordinatenAlt (SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies,
                                           KoordinatenExtern => Kartenwert);
      end case;
      
   end Platzierung;
   
   
   
   function Einheitenbereich
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      EinheitenkoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenRecords.KartenfeldNaturalRecord;
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
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in -Sichtbereich.Senkrechte .. Sichtbereich.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in -Sichtbereich.Waagerechte .. Sichtbereich.Waagerechte loop
            
            Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AlteCursorkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
            
            if
              Kartenwert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              EinheitenkoordinatenExtern = Kartenwert
            then
               return True;
               
            else
               null;
            end if;
              
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
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
   
   
   
   function AlteSenkrechteFestlegen
     (MauspositionExtern : in Sf.System.Vector2.sfVector2f;
      SenkrechteAltExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechteUmgebungEins
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      Achsenviewfläche := Sf.Graphics.View.getSize (view => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte));
      AktuelleSichtweite := SichtweitenGrafik.SichthöheLesen;
      SenkrechteÜbergänge := LeseWeltkarteneinstellungen.KartenformSenkrechte;
      
      if
        MauspositionExtern.x not in GrafikKonstanten.Nullwert .. Achsenviewfläche.x
      then
         return KeineYÄnderung;
      
      elsif
        MauspositionExtern.y in GrafikKonstanten.Nullwert .. SichtweitenGrafik.Kartenfeldfläche.y / Scrollbereichanteil
      then
         if
           SenkrechteAltExtern - AktuelleSichtweite <= KartenKonstanten.AnfangSenkrechte
           and
             SenkrechteÜbergänge.SenkrechteNorden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
         then
            return KeineYÄnderung;
            
         elsif
           SenkrechteAltExtern - AktuelleSichtweite <= KartenKonstanten.AnfangSenkrechte - 1
           and
             SenkrechteÜbergänge.SenkrechteNorden = KartenartDatentypen.Senkrechte_Rückwärts_Verschobener_Übergang_Enum
         then
            return KeineYÄnderung;
            
         else
            return RichtungYNull;
         end if;
         
      elsif
        MauspositionExtern.y in Achsenviewfläche.y - SichtweitenGrafik.Kartenfeldfläche.y / Scrollbereichanteil .. Achsenviewfläche.y
      then
         if
           SenkrechteAltExtern + AktuelleSichtweite >= LeseWeltkarteneinstellungen.Senkrechte
           and
             SenkrechteÜbergänge.SenkrechteSüden = KartenartDatentypen.Senkrechte_Übergangslos_Enum
         then
            return KeineYÄnderung;
            
         elsif
           SenkrechteAltExtern + AktuelleSichtweite >= LeseWeltkarteneinstellungen.Senkrechte + 1
           and
             SenkrechteÜbergänge.SenkrechteSüden = KartenartDatentypen.Senkrechte_Rückwärts_Verschobener_Übergang_Enum
         then
            return KeineYÄnderung;
         
         else
            return RichtungYMaximum;
         end if;
      
      else
         return KeineYÄnderung;
      end if;
      
   end AlteSenkrechteFestlegen;
   
   
   
   function AlteWaagerechteFestlegen
     (MausachseExtern : in Float;
      WaagerechteAltExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechteUmgebungEins
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      Waagerechtebereich := Sf.Graphics.View.getSize (view => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte)).x;
      AktuelleSichtbreite := SichtweitenGrafik.SichtbreiteLesen;
      WaagerechteÜbergänge := LeseWeltkarteneinstellungen.KartenformWaagerechte;
      
      if
        MausachseExtern in GrafikKonstanten.Nullwert .. SichtweitenGrafik.Kartenfeldfläche.x / Scrollbereichanteil
      then
         if
           WaagerechteAltExtern - AktuelleSichtbreite <= KartenKonstanten.AnfangWaagerechte
           and
             WaagerechteÜbergänge.WaagerechteWesten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
         then
            return KeineXÄnderung;
            
         elsif
           WaagerechteAltExtern - AktuelleSichtbreite <= KartenKonstanten.AnfangWaagerechte - 1
           and
             WaagerechteÜbergänge.WaagerechteWesten = KartenartDatentypen.Waagerechte_Rückwärts_Verschobener_Übergang_Enum
         then
            return KeineXÄnderung;
            
         else
            return RichtungXNull;
         end if;
         
      elsif
        MausachseExtern in Waagerechtebereich - SichtweitenGrafik.Kartenfeldfläche.x / Scrollbereichanteil .. Waagerechtebereich
      then
         if
           WaagerechteAltExtern + AktuelleSichtbreite >= LeseWeltkarteneinstellungen.Waagerechte
           and
             WaagerechteÜbergänge.WaagerechteOsten = KartenartDatentypen.Waagerechte_Übergangslos_Enum
         then
            return KeineXÄnderung;
            
         elsif
           WaagerechteAltExtern + AktuelleSichtbreite >= LeseWeltkarteneinstellungen.Waagerechte + 1
           and
             WaagerechteÜbergänge.WaagerechteOsten = KartenartDatentypen.Waagerechte_Rückwärts_Verschobener_Übergang_Enum
         then
            return KeineXÄnderung;
         
         else
            return RichtungXMaximum;
         end if;
         
      else
         return KeineXÄnderung;
      end if;
      
   end AlteWaagerechteFestlegen;

end CursorplatzierungAltGrafik;
