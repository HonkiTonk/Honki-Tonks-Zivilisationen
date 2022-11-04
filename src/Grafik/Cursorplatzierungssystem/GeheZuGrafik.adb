pragma Warnings (Off, "*array aggregate*");

with KartenartDatentypen; use KartenartDatentypen;
with KartenRecordKonstanten;
with KartenKonstanten;

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
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt := NachGrafiktask.GeheZu;
            
         when others =>
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt := Kartenwert;
      end case;
      
      NachGrafiktask.GeheZu := KartenRecordKonstanten.LeerKoordinate;
      
   end GeheZuFestlegung;
   
   
   
   -- Muss später wahrscheinlich noch an die anderen Übergangsarten angepasst werden. äöü
   function Koordinatenberechnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      KartenwertKoordinatenberechnung.EAchse := KoordinatenExtern.EAchse;
      AktuelleSichtweite := SichtweitenGrafik.SichtweiteLesen;
        
      if
        2 * AktuelleSichtweite >= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
      then
         KartenwertKoordinatenberechnung.YAchse := Weltkarte.Karteneinstellungen.Kartengröße.YAchse / 2;
         
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
        and
          Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.YAchse <= Weltkarte.KarteArray'First (2) + AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.YAchse := Weltkarte.KarteArray'First (2) + AktuelleSichtweite;
            
         elsif
           KoordinatenExtern.YAchse >= Weltkarte.Karteneinstellungen.Kartengröße.YAchse - AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.YAchse := Weltkarte.Karteneinstellungen.Kartengröße.YAchse - AktuelleSichtweite;
         
         else
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
         end if;
         
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.YAchse <= Weltkarte.KarteArray'First (2) + AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.YAchse := Weltkarte.KarteArray'First (2) + AktuelleSichtweite;
         
         else
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
         end if;
         
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.YAchse >= Weltkarte.Karteneinstellungen.Kartengröße.YAchse - AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.YAchse := Weltkarte.Karteneinstellungen.Kartengröße.YAchse - AktuelleSichtweite;
         
         else
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
         end if;
         
      else
         KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
      end if;
      
      if
        2 * AktuelleSichtweite >= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
      then
         KartenwertKoordinatenberechnung.XAchse := Weltkarte.Karteneinstellungen.Kartengröße.XAchse / 2;
         
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
        and
          Weltkarte.Karteneinstellungen.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.XAchse <= Weltkarte.KarteArray'First (3) + AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.XAchse := Weltkarte.KarteArray'First (3) + AktuelleSichtweite;
         
         elsif
           KoordinatenExtern.XAchse >= Weltkarte.Karteneinstellungen.Kartengröße.XAchse - AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.XAchse := Weltkarte.Karteneinstellungen.Kartengröße.XAchse - AktuelleSichtweite;
         
         else
            KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse;
         end if;
      
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.XAchseWesten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.XAchse <= Weltkarte.KarteArray'First (3) + AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.XAchse := Weltkarte.KarteArray'First (3) + AktuelleSichtweite;
         
         else
            KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse;
         end if;
      
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.XAchseOsten = KartenartDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.XAchse >= Weltkarte.Karteneinstellungen.Kartengröße.XAchse - AktuelleSichtweite
         then
            KartenwertKoordinatenberechnung.XAchse := Weltkarte.Karteneinstellungen.Kartengröße.XAchse - AktuelleSichtweite;
         
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
