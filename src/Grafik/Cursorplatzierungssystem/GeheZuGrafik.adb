with KartenartDatentypen;
with KartenRecordKonstanten;
with KartenKonstanten;

with SchreibeCursor;

with NachGrafiktask;
with SichtweitenGrafik;
with KartenkoordinatenberechnungssystemLogik;

package body GeheZuGrafik is

   procedure GeheZuFestlegung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
                
      Kartenwert := Koordinatenberechnung (KoordinatenExtern => NachGrafiktask.GeheZu);
      
      case
        Kartenwert.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            SchreibeCursor.KoordinatenAlt (RasseExtern       => RasseExtern,
                                           KoordinatenExtern => NachGrafiktask.GeheZu);
            
         when others =>
            SchreibeCursor.KoordinatenAlt (RasseExtern       => RasseExtern,
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
      AktuelleSichtweite := SichtweitenGrafik.SichtweiteLesen;
      YAchseÜbergänge := LeseWeltkarteneinstellungen.KartenformYAchse;
      XAchseÜbergänge := LeseWeltkarteneinstellungen.KartenformXAchse;
        
      if
        2 * AktuelleSichtweite >= LeseWeltkarteneinstellungen.YAchse
      then
         KartenwertKoordinatenberechnung.YAchse := LeseWeltkarteneinstellungen.YAchse / 2;
         
      elsif
        YAchseÜbergänge.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
        and
          YAchseÜbergänge.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.YAchse <= KartenKonstanten.AnfangYAchse + AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.YAchse := KartenKonstanten.AnfangYAchse + AktuelleSichtweite;
            
         elsif
           KoordinatenExtern.YAchse >= LeseWeltkarteneinstellungen.YAchse - AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.YAchse := LeseWeltkarteneinstellungen.YAchse - AktuelleSichtweite;
         
         else
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
         end if;
         
      elsif
        YAchseÜbergänge.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.YAchse <= KartenKonstanten.AnfangYAchse + AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.YAchse := KartenKonstanten.AnfangYAchse + AktuelleSichtweite;
         
         else
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
         end if;
         
      elsif
        YAchseÜbergänge.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.YAchse >= LeseWeltkarteneinstellungen.YAchse - AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.YAchse := LeseWeltkarteneinstellungen.YAchse - AktuelleSichtweite;
         
         else
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
         end if;
         
      else
         KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
      end if;
      
      if
        2 * AktuelleSichtweite >= LeseWeltkarteneinstellungen.XAchse
      then
         KartenwertKoordinatenberechnung.XAchse := LeseWeltkarteneinstellungen.XAchse / 2;
         
      elsif
        XAchseÜbergänge.XAchseWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
        and
          XAchseÜbergänge.XAchseOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.XAchse <= KartenKonstanten.AnfangXAchse + AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.XAchse := KartenKonstanten.AnfangXAchse + AktuelleSichtweite;
         
         elsif
           KoordinatenExtern.XAchse >= LeseWeltkarteneinstellungen.XAchse - AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.XAchse := LeseWeltkarteneinstellungen.XAchse - AktuelleSichtweite;
         
         else
            KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse;
         end if;
      
      elsif
        XAchseÜbergänge.XAchseWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.XAchse <= KartenKonstanten.AnfangXAchse + AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.XAchse := KartenKonstanten.AnfangXAchse + AktuelleSichtweite;
         
         else
            KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse;
         end if;
      
      elsif
        XAchseÜbergänge.XAchseOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.XAchse >= LeseWeltkarteneinstellungen.XAchse - AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.XAchse := LeseWeltkarteneinstellungen.XAchse - AktuelleSichtweite;
         
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
