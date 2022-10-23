pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with Sf.Graphics.RenderWindow;
with Sf.Graphics.View;

with KartenartDatentypen; use KartenartDatentypen;
with KartenKonstanten;
with ZeitKonstanten;
with Views;
with EinheitenKonstanten;

with LeseEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with SichtweitenGrafik;
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
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.KartenviewAccess);
      
      -- Die EAchse später auch noch über eine Funktion die Änderung ermitteln oder einfach so lassen? äöü
      SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt.EAchse := SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAktuell.EAchse;
            
      
      -- case
      --   EinheitRasseNummerExtern.Nummer
      -- is
      --    when EinheitenKonstanten.LeerNummer =>
      EinheitFolgen := True;
                        
      --    when others =>
      -- EinheitFolgen := Einheitenbereich (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      -- end case;
      
      case
        EinheitFolgen
      is
         when False =>
            NachGrafiktask.GeheZu := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return;
            
         when True =>
            Koordinatenänderung.YAchse := AlteYAchseFestlegen (MauspositionExtern => Mausposition,
                                                                YAchseAltExtern    => SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt.YAchse);
            
            Koordinatenänderung.XAchse := AlteXAchseFestlegen (MausachseExtern => Mausposition.x,
                                                                XAchseAltExtern => SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt.XAchse);
      end case;
      
      Koordinatenänderung.EAchse := KartenKonstanten.LeerEAchseÄnderung;
      
      Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt,
                                                                                                ÄnderungExtern    => Koordinatenänderung,
                                                                                                LogikGrafikExtern => False);
            
      if
        Kartenwert.EAchse = KartenKonstanten.LeerEAchse
      then
         null;
                  
      else
         SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt := Kartenwert;
      end if;
      
   end Platzierung;
   
   
   
   -- Sorgt dafür das man mit ausgewählter Einheit zwar immer die Einheit im Blick hat, aber auch dass man nicht frei herumscrollen kann. äöü
   -- Löst auch nicht das Problem mit dem Übergang. äöü
   function Einheitenbereich
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      AlteCursorkoordinaten := SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt;
      
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
              True = Vergleiche.Koordinatenvergleich (KoordinateEinsExtern  => Einheitenkoordinaten,
                                                      KoordinatenZweiExtern => Kartenwert)
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
   is begin
      
      Achsenviewfläche := Sf.Graphics.View.getSize (view => Views.KartenviewAccess);
      AktuelleSichtweite := SichtweitenGrafik.SichtweiteLesen;
      
      if
        MauspositionExtern.x not in 0.00 .. Achsenviewfläche.x
      then
         return 0;
      
      elsif
        MauspositionExtern.y in 0.00 .. KartenberechnungenGrafik.KartenfelderAbmessung.y / 2.00
      then
         if
           YAchseAltExtern - AktuelleSichtweite <= Weltkarte.KarteArray'First (2)
           and
             Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
         then
            return 0;
            
         elsif
           YAchseAltExtern - AktuelleSichtweite <= Weltkarte.KarteArray'First (2) - 1
           and
             Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
         then
            return 0;
            
         else
            return -1;
         end if;
         
      elsif
        MauspositionExtern.y in Achsenviewfläche.y - KartenberechnungenGrafik.KartenfelderAbmessung.y / 2.00 .. Achsenviewfläche.y
      then
         if
           YAchseAltExtern + AktuelleSichtweite >= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
           and
             Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
         then
            return 0;
            
         elsif
           YAchseAltExtern + AktuelleSichtweite >= Weltkarte.Karteneinstellungen.Kartengröße.YAchse + 1
           and
             Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum
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
   is begin
      
      XAchsenbereich := Sf.Graphics.View.getSize (view => Views.KartenviewAccess).x;
      AktuelleSichtweite := SichtweitenGrafik.SichtweiteLesen;
      
      if
        MausachseExtern in 0.00 .. KartenberechnungenGrafik.KartenfelderAbmessung.x / 2.00
      then
         if
           XAchseAltExtern - AktuelleSichtweite <= Weltkarte.KarteArray'First (3)
           and
             Weltkarte.Karteneinstellungen.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
         then
            return 0;
            
         elsif
           XAchseAltExtern - AktuelleSichtweite <= Weltkarte.KarteArray'First (3) - 1
           and
             Weltkarte.Karteneinstellungen.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
         then
            return 0;
            
         else
            return -1;
         end if;
         
      elsif
        MausachseExtern in XAchsenbereich - KartenberechnungenGrafik.KartenfelderAbmessung.x / 2.00 .. XAchsenbereich
      then
         if
           XAchseAltExtern + AktuelleSichtweite >= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
           and
             Weltkarte.Karteneinstellungen.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
         then
            return 0;
            
         elsif
           XAchseAltExtern + AktuelleSichtweite >= Weltkarte.Karteneinstellungen.Kartengröße.XAchse + 1
           and
             Weltkarte.Karteneinstellungen.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum
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
