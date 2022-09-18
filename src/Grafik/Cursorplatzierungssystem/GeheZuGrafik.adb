pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecordKonstanten;
with KartenKonstanten;

with NachGrafiktask;
with Sichtweiten;
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
   
   
   
   -- Später noch einmal überarbeiten und auch besser an den Kartenrand anpassen und nicht nur eine halbe Sichtbreite wegschieben. äöü
   function Koordinatenberechnung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      KartenwertKoordinatenberechnung.EAchse := KoordinatenExtern.EAchse;
      
      if
        Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
        and
          Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.YAchse <= Weltkarte.KarteArray'First (2) + Sichtweiten.SichtweiteLesen / 2
         then
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse + Sichtweiten.BewegungsfeldLesen + 1;
            
         elsif
           KoordinatenExtern.YAchse >= Weltkarte.Karteneinstellungen.Kartengröße.YAchse - Sichtweiten.SichtweiteLesen / 2
         then
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse - Sichtweiten.BewegungsfeldLesen - 1;
         
         else
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
         end if;
         
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.YAchse <= Weltkarte.KarteArray'First (2) + Sichtweiten.SichtweiteLesen / 2
         then
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse + Sichtweiten.BewegungsfeldLesen + 1;
         
         else
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
         end if;
         
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.YAchse >= Weltkarte.Karteneinstellungen.Kartengröße.YAchse - Sichtweiten.SichtweiteLesen / 2
         then
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse - Sichtweiten.BewegungsfeldLesen - 1;
         
         else
            KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
         end if;
         
      else
         KartenwertKoordinatenberechnung.YAchse := KoordinatenExtern.YAchse;
      end if;
      
      if
        Weltkarte.Karteneinstellungen.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
        and
          Weltkarte.Karteneinstellungen.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.XAchse <= Weltkarte.KarteArray'First (3) + Sichtweiten.SichtweiteLesen / 2
         then
            KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse + Sichtweiten.BewegungsfeldLesen;
         
         elsif
           KoordinatenExtern.XAchse >= Weltkarte.Karteneinstellungen.Kartengröße.XAchse - Sichtweiten.SichtweiteLesen / 2
         then
            KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse - Sichtweiten.BewegungsfeldLesen;
         
         else
            KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse;
         end if;
      
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.XAchse <= Weltkarte.KarteArray'First (3) + Sichtweiten.SichtweiteLesen / 2
         then
            KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse + Sichtweiten.BewegungsfeldLesen;
         
         else
            KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse;
         end if;
      
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
      then
         if
           KoordinatenExtern.XAchse >= Weltkarte.Karteneinstellungen.Kartengröße.XAchse - Sichtweiten.SichtweiteLesen / 2
         then
            KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse - Sichtweiten.BewegungsfeldLesen;
         
         else
            KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse;
         end if;
         
      else
         KartenwertKoordinatenberechnung.XAchse := KoordinatenExtern.XAchse;
      end if;
      
      KartenwertKoordinatenberechnung := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KartenwertKoordinatenberechnung,
                                                                                                                ÄnderungExtern    => (0, 0, 0),
                                                                                                                LogikGrafikExtern => False);
      
      return KartenwertKoordinatenberechnung;
      
   end Koordinatenberechnung;

end GeheZuGrafik;
