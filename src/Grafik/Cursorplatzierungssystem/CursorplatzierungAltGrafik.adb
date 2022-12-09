with Ada.Calendar; use Ada.Calendar;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.View;

with KartenartDatentypen;
with KartenKonstanten;
with ZeitKonstanten;
with Views;
with EinheitenKonstanten;
with ViewKonstanten;

with LeseEinheitenGebaut;
with LeseCursor;
with SchreibeCursor;

with KartenkoordinatenberechnungssystemLogik;
with SichtweitenGrafik;
with NachGrafiktask;
with EinstellungenGrafik;
with NachLogiktask;
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
                SichtweitenGrafik.SichtweiteLesen <= 4
            then
               null;
                
            elsif
              Ada.Calendar.Clock - Scrollzeit > ZeitKonstanten.Scrollverzögerung
              and
                SichtweitenGrafik.SichtweiteLesen > 4
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
               Platzierung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            end if;
                  
         when others =>
            GeheZuGrafik.GeheZuFestlegung (RasseExtern => EinheitRasseNummerExtern.Rasse);
      end case;
      
   end CursorplatzierungAlt;
   
   
   
   procedure Platzierung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type KartenDatentypen.Ebene;
   begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.WeltkarteAccess (ViewKonstanten.WeltKarte));
      
      SchreibeCursor.EAchseAlt (RasseExtern  => EinheitRasseNummerExtern.Rasse,
                                EAchseExtern => LeseCursor.EAchseAktuell (RasseExtern => EinheitRasseNummerExtern.Rasse));
      
      case
        EinheitRasseNummerExtern.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            EinheitFolgen := True;
            
         when others =>
            EinheitFolgen := Einheitenbereich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
      case
        EinheitFolgen
      is
         when False =>
            NachGrafiktask.GeheZu := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return;
            
         when True =>
            Koordinatenänderung.YAchse := AlteYAchseFestlegen (MauspositionExtern => Mausposition,
                                                                YAchseAltExtern    => LeseCursor.YAchseAlt (RasseExtern => EinheitRasseNummerExtern.Rasse));
            
            Koordinatenänderung.XAchse := AlteXAchseFestlegen (MausachseExtern => Mausposition.x,
                                                                XAchseAltExtern => LeseCursor.XAchseAlt (RasseExtern => EinheitRasseNummerExtern.Rasse));
      end case;
      
      Koordinatenänderung.EAchse := KartenKonstanten.LeerEAchseÄnderung;
      
      Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseCursor.KoordinatenAlt (RasseExtern => EinheitRasseNummerExtern.Rasse),
                                                                                                ÄnderungExtern    => Koordinatenänderung,
                                                                                                LogikGrafikExtern => False);
      
      if
        Kartenwert.EAchse = KartenKonstanten.LeerEAchse
      then
         null;
                  
      else
         SchreibeCursor.KoordinatenAlt (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                        KoordinatenExtern => Kartenwert);
      end if;
      
   end Platzierung;
   
   
   
   function Einheitenbereich
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      case
        NachGrafiktask.EinheitBewegt
      is
         when False =>
            return True;
            
         when True =>
            NachGrafiktask.EinheitBewegt := False;
      end case;
      
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      AlteCursorkoordinaten := LeseCursor.KoordinatenAlt (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -SichtweitenGrafik.SichtweiteLesen .. SichtweitenGrafik.SichtweiteLesen loop
         XAchseSchleife:
         for XAchseSchleifenwert in -SichtweitenGrafik.SichtweiteLesen .. SichtweitenGrafik.SichtweiteLesen loop
            
            Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AlteCursorkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => False);
            
            if
              Kartenwert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              Einheitenkoordinaten = Kartenwert
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
            
      if
        NachLogiktask.Mausposition.x < 0.00
        or
          NachLogiktask.Mausposition.y < 0.00
      then
         null;
         
      else
         Viewfläche := Sf.Graphics.View.getSize (view => Views.KartenbefehlsviewAccess);
         Viewzentrum := Sf.Graphics.View.getCenter (view => Views.KartenbefehlsviewAccess);
         
         Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                    point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                    view         => Views.KartenbefehlsviewAccess);
      
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => (Viewzentrum.x - Viewfläche.x / 2.00, Viewzentrum.y - Viewfläche.y / 2.00, Viewfläche.x, Viewfläche.y))
         is
            when True =>
               return True;
               
            when False =>
               null;
         end case;
      end if;
                        
      if
        EinheitRasseNummerExtern.Nummer = EinheitenKonstanten.LeerNummer
      then
         null;
         
      elsif
        NachLogiktask.Mausposition.x <= 0.00
        or
          NachLogiktask.Mausposition.y <= 0.00
      then
         null;
         
      else
         Viewfläche := Sf.Graphics.View.getSize (view => Views.EinheitenbefehlsviewAccess);
         Viewzentrum := Sf.Graphics.View.getCenter (view => Views.EinheitenbefehlsviewAccess);
         
         Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                    point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                    view         => Views.EinheitenbefehlsviewAccess);
            
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => (Viewzentrum.x - Viewfläche.x / 2.00, Viewzentrum.y - Viewfläche.y / 2.00, Viewfläche.x, Viewfläche.y))
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
      YAchseAltExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.UmgebungsbereichEins
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      Achsenviewfläche := Sf.Graphics.View.getSize (view => Views.WeltkarteAccess (ViewKonstanten.WeltKarte));
      AktuelleSichtweite := SichtweitenGrafik.SichtweiteLesen;
      
      if
        MauspositionExtern.x not in 0.00 .. Achsenviewfläche.x
      then
         return 0;
      
      elsif
        MauspositionExtern.y in 0.00 .. SichtweitenGrafik.KartenfelderAbmessung.y / 2.00
      then
         if
           YAchseAltExtern - AktuelleSichtweite <= KartenKonstanten.AnfangYAchse
           and
             LeseWeltkarteneinstellungen.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
         then
            return 0;
            
         elsif
           YAchseAltExtern - AktuelleSichtweite <= KartenKonstanten.AnfangYAchse - 1
           and
             LeseWeltkarteneinstellungen.YAchseNorden = KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
         then
            return 0;
            
         else
            return -1;
         end if;
         
      elsif
        MauspositionExtern.y in Achsenviewfläche.y - SichtweitenGrafik.KartenfelderAbmessung.y / 2.00 .. Achsenviewfläche.y
      then
         if
           YAchseAltExtern + AktuelleSichtweite >= LeseWeltkarteneinstellungen.YAchse
           and
             LeseWeltkarteneinstellungen.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
         then
            return 0;
            
         elsif
           YAchseAltExtern + AktuelleSichtweite >= LeseWeltkarteneinstellungen.YAchse + 1
           and
             LeseWeltkarteneinstellungen.YAchseSüden = KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
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
      XAchseAltExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.UmgebungsbereichEins
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      XAchsenbereich := Sf.Graphics.View.getSize (view => Views.WeltkarteAccess (ViewKonstanten.WeltKarte)).x;
      AktuelleSichtweite := SichtweitenGrafik.SichtweiteLesen;
      XAchseÜbergänge := LeseWeltkarteneinstellungen.KartenformXAchse;
      
      if
        MausachseExtern in 0.00 .. SichtweitenGrafik.KartenfelderAbmessung.x / 2.00
      then
         if
           XAchseAltExtern - AktuelleSichtweite <= KartenKonstanten.AnfangXAchse
           and
             XAchseÜbergänge.XAchseWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
         then
            return 0;
            
         elsif
           XAchseAltExtern - AktuelleSichtweite <= KartenKonstanten.AnfangXAchse - 1
           and
             XAchseÜbergänge.XAchseWesten = KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
         then
            return 0;
            
         else
            return -1;
         end if;
         
      elsif
        MausachseExtern in XAchsenbereich - SichtweitenGrafik.KartenfelderAbmessung.x / 2.00 .. XAchsenbereich
      then
         if
           XAchseAltExtern + AktuelleSichtweite >= LeseWeltkarteneinstellungen.XAchse
           and
             XAchseÜbergänge.XAchseOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
         then
            return 0;
            
         elsif
           XAchseAltExtern + AktuelleSichtweite >= LeseWeltkarteneinstellungen.XAchse + 1
           and
             XAchseÜbergänge.XAchseOsten = KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
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
