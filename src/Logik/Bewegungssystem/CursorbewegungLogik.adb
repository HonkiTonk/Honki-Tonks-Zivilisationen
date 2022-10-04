pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TextnummernKonstanten;
with KartenKonstanten;

with Weltkarte;
with ZahleneingabeLogik;
with NachGrafiktask;
with Sichtweiten;
with KartenkoordinatenberechnungssystemLogik;

package body CursorbewegungLogik is
   
   procedure CursorbewegungBerechnen
     (RichtungExtern : in TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                                ÄnderungExtern    => Richtung (RichtungExtern),
                                                                                                LogikGrafikExtern => True);
      
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
               
         when others =>
            -- SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt := KartenWert;
            NachGrafiktask.GeheZu := KartenWert;
      end case;
      
   end CursorbewegungBerechnen;
   
   
   
   -- Eventuell später noch erweitern damit auch bei anderen Einstellungen die Verschiebung korrekter ist. äöü
   -- Gilt auch für die Anpassung in CursorplatzierungAltGrafik. äöü
   -- GeheZuGrafik.Koordinatenberechnung hat vergleichbare Berechnungen, mal zusammenführen. äöü
   -- Das Ergebnis nach NachGrafiktask.GeheZu schreiben, dann wird die Cursorposition gar nicht? mehr von der Logik Festgelegt, sondern nur noch von der Grafik. äöü
   procedure ZoomanpassungCursor
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      AktuelleSichtweite := Sichtweiten.SichtweiteLesen (YXExtern => True);
        
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
      
      AktuelleSichtweite := Sichtweiten.SichtweiteLesen (YXExtern => False);
      
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
