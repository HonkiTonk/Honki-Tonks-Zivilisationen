pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TextnummernKonstanten;

with Weltkarte;
with ZahleneingabeLogik;
with NachGrafiktask;
with Sichtweiten;

package body CursorbewegungLogik is
   
   procedure CursorbewegungBerechnen
     (RichtungExtern : in TastenbelegungDatentypen.Tastenbelegung_Bewegung_Ebene_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Änderung := Richtung (RichtungExtern);
      
      case
        Änderung
      is
         when 1 =>
            if
              SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse = Weltkarte.Karte'Last (1)
            then
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse := Weltkarte.Karte'First (1);
               
            else
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse + Änderung;
            end if;
            
         when -1 =>
            if
              SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse = Weltkarte.Karte'First (1)
            then
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse := Weltkarte.Karte'Last (1);
               
            else
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse + Änderung;
            end if;
            
         when others =>
            null;
      end case;
      
   end CursorbewegungBerechnen;
   
   
   
   -- Eventuell später noch erweitern damit auch bei anderen Einstellungen die Verschiebung korrekter ist. äöü
   -- Gilt auch für die Anpassung in CursorplatzierungAltGrafik. äöü
   procedure ZoomanpassungCursor
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuelleSichtweite := Sichtweiten.SichtweiteLesen;
        
      if
        2 * AktuelleSichtweite >= Weltkarte.Karteneinstellungen.Kartengröße.YAchse
        and
          Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
          and
            Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse := Weltkarte.Karteneinstellungen.Kartengröße.YAchse / 2;
         
      elsif
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse <= Weltkarte.KarteArray'First (2) + AktuelleSichtweite
        and
          Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse := Weltkarte.KarteArray'First (2) + AktuelleSichtweite;
         
      elsif
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse >= Weltkarte.Karteneinstellungen.Kartengröße.YAchse - AktuelleSichtweite
        and
          Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse := Weltkarte.Karteneinstellungen.Kartengröße.YAchse - AktuelleSichtweite;
         
      else
         null;
      end if;
      
      if
        2 * AktuelleSichtweite >= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
        and
          Weltkarte.Karteneinstellungen.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
          and
            Weltkarte.Karteneinstellungen.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
      then
         SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse := Weltkarte.Karteneinstellungen.Kartengröße.XAchse / 2;
      
      elsif
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse <= Weltkarte.KarteArray'First (3) + AktuelleSichtweite
        and
          Weltkarte.Karteneinstellungen.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
      then
         SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse := Weltkarte.KarteArray'First (3) + AktuelleSichtweite;
         
      elsif
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse >= Weltkarte.Karteneinstellungen.Kartengröße.XAchse - AktuelleSichtweite
        and
          Weltkarte.Karteneinstellungen.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
      then
         SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse := Weltkarte.Karteneinstellungen.Kartengröße.XAchse - AktuelleSichtweite;
         
      else
         null;
      end if;
      
   end ZoomanpassungCursor;



   procedure GeheZu
   is begin
      
      KoordinatenPunkt := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Integer (Weltkarte.Karte'First (1)),
                                                            ZahlenMaximumExtern => Integer (Weltkarte.Karte'Last (1)),
                                                            WelcheFrageExtern   => TextnummernKonstanten.FrageWelcheEbene);
      
      case
        KoordinatenPunkt.ErfolgreichAbbruch
      is
         when False =>
            return;
         
         when True =>
            NeueKoordinate.EAchse := KartenDatentypen.EbeneVorhanden (KoordinatenPunkt.EingegebeneZahl);
            KoordinatenPunkt := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Positive (Weltkarte.Karte'First (2)),
                                                                  ZahlenMaximumExtern => Positive (Weltkarte.Karteneinstellungen.Kartengröße.YAchse),
                                                                  WelcheFrageExtern   => TextnummernKonstanten.FrageWelcheYPosition);
      end case;
      
      case
        KoordinatenPunkt.ErfolgreichAbbruch
      is
         when False =>
            return;
         
         when True =>
            NeueKoordinate.YAchse := KartenDatentypen.KartenfeldPositiv (KoordinatenPunkt.EingegebeneZahl);
            KoordinatenPunkt := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Positive (Weltkarte.Karte'First (3)),
                                                                  ZahlenMaximumExtern => Positive (Weltkarte.Karteneinstellungen.Kartengröße.XAchse),
                                                                  WelcheFrageExtern   => TextnummernKonstanten.FrageWelcheXPosition);
      end case;

      case
        KoordinatenPunkt.ErfolgreichAbbruch
      is
         when False =>
            null;
         
         when True =>
            NeueKoordinate.XAchse := KartenDatentypen.KartenfeldPositiv (KoordinatenPunkt.EingegebeneZahl);
            NachGrafiktask.GeheZu := NeueKoordinate;
      end case;
      
   end GeheZu;

end CursorbewegungLogik;
