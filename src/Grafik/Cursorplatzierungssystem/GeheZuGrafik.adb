with KartenartDatentypen;
with KartenRecordKonstanten;
with KartenKonstanten;

with SchreibeCursor;

with NachGrafiktask;
with SichtweitenGrafik;
with KartenkoordinatenberechnungssystemLogik;

package body GeheZuGrafik is

   procedure GeheZuFestlegung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
                
      Kartenwert := Koordinatenberechnung (KoordinatenExtern => NachGrafiktask.GeheZu);
      
      case
        Kartenwert.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            SchreibeCursor.KoordinatenAlt (SpeziesExtern     => SpeziesExtern,
                                           KoordinatenExtern => NachGrafiktask.GeheZu);
            
         when others =>
            SchreibeCursor.KoordinatenAlt (SpeziesExtern     => SpeziesExtern,
                                           KoordinatenExtern => Kartenwert);
      end case;
      
      NachGrafiktask.GeheZu := KartenRecordKonstanten.LeerKoordinate;
      
   end GeheZuFestlegung;
   
   
   
   -- Muss später wahrscheinlich noch an die anderen Übergangsarten angepasst werden. äöü
   function Koordinatenberechnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      KartenwertKoordinatenberechnung.EAchse := KoordinatenExtern.EAchse;
      AktuelleSichtweite := SichtweitenGrafik.SichtbereichLesen;
      YAchseÜbergänge := LeseWeltkarteneinstellungen.KartenformYAchse;
      XAchseÜbergänge := LeseWeltkarteneinstellungen.KartenformXAchse;
        
      if
        2 * AktuelleSichtweite.YAchse >= LeseWeltkarteneinstellungen.YAchse
      then
         KartenwertKoordinatenberechnung.YAchse := LeseWeltkarteneinstellungen.YAchse / 2;
         
      elsif
        YAchseÜbergänge.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
        and
          YAchseÜbergänge.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.YAchse <= KartenKonstanten.AnfangYAchse + AktuelleSichtweite.YAchse
         then
            KartenwertKoordinatenberechnung.YAchse := KartenKonstanten.AnfangYAchse + AktuelleSichtweite.YAchse;
            
         elsif
           KoordinatenExtern.YAchse >= LeseWeltkarteneinstellungen.YAchse - AktuelleSichtweite.YAchse
         then
            KartenwertKoordinatenberechnung.YAchse := LeseWeltkarteneinstellungen.YAchse - AktuelleSichtweite.YAchse;
         
         else
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
         end if;
         
      elsif
        YAchseÜbergänge.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.YAchse <= KartenKonstanten.AnfangYAchse + AktuelleSichtweite.YAchse
         then
            KartenwertKoordinatenberechnung.YAchse := KartenKonstanten.AnfangYAchse + AktuelleSichtweite.YAchse;
         
         else
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
         end if;
         
      elsif
        YAchseÜbergänge.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.YAchse >= LeseWeltkarteneinstellungen.YAchse - AktuelleSichtweite.YAchse
         then
            KartenwertKoordinatenberechnung.YAchse := LeseWeltkarteneinstellungen.YAchse - AktuelleSichtweite.YAchse;
         
         else
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
         end if;
         
      else
         KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
      end if;
      
      if
        2 * AktuelleSichtweite.XAchse >= LeseWeltkarteneinstellungen.XAchse
      then
         KartenwertKoordinatenberechnung.XAchse := LeseWeltkarteneinstellungen.XAchse / 2;
         
      elsif
        XAchseÜbergänge.XAchseWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
        and
          XAchseÜbergänge.XAchseOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.XAchse <= KartenKonstanten.AnfangXAchse + AktuelleSichtweite.XAchse
         then
            KartenwertKoordinatenberechnung.XAchse := KartenKonstanten.AnfangXAchse + AktuelleSichtweite.XAchse;
         
         elsif
           KoordinatenExtern.XAchse >= LeseWeltkarteneinstellungen.XAchse - AktuelleSichtweite.XAchse
         then
            KartenwertKoordinatenberechnung.XAchse := LeseWeltkarteneinstellungen.XAchse - AktuelleSichtweite.XAchse;
         
         else
            KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse;
         end if;
      
      elsif
        XAchseÜbergänge.XAchseWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.XAchse <= KartenKonstanten.AnfangXAchse + AktuelleSichtweite.XAchse
         then
            KartenwertKoordinatenberechnung.XAchse := KartenKonstanten.AnfangXAchse + AktuelleSichtweite.XAchse;
         
         else
            KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse;
         end if;
      
      elsif
        XAchseÜbergänge.XAchseOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.XAchse >= LeseWeltkarteneinstellungen.XAchse - AktuelleSichtweite.XAchse
         then
            KartenwertKoordinatenberechnung.XAchse := LeseWeltkarteneinstellungen.XAchse - AktuelleSichtweite.XAchse;
         
         else
            KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse;
         end if;
         
      else
         KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse;
      end if;
      
      return KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KartenwertKoordinatenberechnung,
                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, KartenKonstanten.LeerYAchseÄnderung, KartenKonstanten.LeerXAchseÄnderung),
                                                                                         LogikGrafikExtern => False);
      
   end Koordinatenberechnung;

end GeheZuGrafik;
