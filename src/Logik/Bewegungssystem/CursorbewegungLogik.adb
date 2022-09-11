pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TextnummernKonstanten;

with Karten;
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
              SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse = Karten.Weltkarte'Last (1)
            then
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse := Karten.Weltkarte'First (1);
               
            else
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse + Änderung;
            end if;
            
         when -1 =>
            if
              SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse = Karten.Weltkarte'First (1)
            then
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.EAchse := Karten.Weltkarte'Last (1);
               
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
        2 * AktuelleSichtweite >= Karten.Karteneinstellungen.Kartengröße.YAchse
        and
          Karten.Karteneinstellungen.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
          and
            Karten.Karteneinstellungen.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse := Karten.Karteneinstellungen.Kartengröße.YAchse / 2;
         
      elsif
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse <= Karten.WeltkarteArray'First (2) + AktuelleSichtweite
        and
          Karten.Karteneinstellungen.Kartenform.YAchseNorden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse := Karten.WeltkarteArray'First (2) + AktuelleSichtweite;
         
      elsif
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse >= Karten.Karteneinstellungen.Kartengröße.YAchse - AktuelleSichtweite
        and
          Karten.Karteneinstellungen.Kartenform.YAchseSüden = KartenDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse := Karten.Karteneinstellungen.Kartengröße.YAchse - AktuelleSichtweite;
         
      else
         null;
      end if;
      
      if
        2 * AktuelleSichtweite >= Karten.Karteneinstellungen.Kartengröße.XAchse
        and
          Karten.Karteneinstellungen.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
          and
            Karten.Karteneinstellungen.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
      then
         SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse := Karten.Karteneinstellungen.Kartengröße.XAchse / 2;
      
      elsif
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse <= Karten.WeltkarteArray'First (3) + AktuelleSichtweite
        and
          Karten.Karteneinstellungen.Kartenform.XAchseWesten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
      then
         SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse := Karten.WeltkarteArray'First (3) + AktuelleSichtweite;
         
      elsif
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse >= Karten.Karteneinstellungen.Kartengröße.XAchse - AktuelleSichtweite
        and
          Karten.Karteneinstellungen.Kartenform.XAchseOsten = KartenDatentypen.Karte_X_Kein_Übergang_Enum
      then
         SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse := Karten.Karteneinstellungen.Kartengröße.XAchse - AktuelleSichtweite;
         
      else
         null;
      end if;
      
   end ZoomanpassungCursor;



   procedure GeheZu
   is begin
      
      KoordinatenPunkt := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Integer (Karten.Weltkarte'First (1)),
                                                            ZahlenMaximumExtern => Integer (Karten.Weltkarte'Last (1)),
                                                            WelcheFrageExtern   => TextnummernKonstanten.FrageWelcheEbene);
      
      case
        KoordinatenPunkt.ErfolgreichAbbruch
      is
         when False =>
            return;
         
         when True =>
            NeueKoordinate.EAchse := KartenDatentypen.EbeneVorhanden (KoordinatenPunkt.EingegebeneZahl);
            KoordinatenPunkt := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Positive (Karten.Weltkarte'First (2)),
                                                                  ZahlenMaximumExtern => Positive (Karten.Karteneinstellungen.Kartengröße.YAchse),
                                                                  WelcheFrageExtern   => TextnummernKonstanten.FrageWelcheYPosition);
      end case;
      
      case
        KoordinatenPunkt.ErfolgreichAbbruch
      is
         when False =>
            return;
         
         when True =>
            NeueKoordinate.YAchse := KartenDatentypen.KartenfeldPositiv (KoordinatenPunkt.EingegebeneZahl);
            KoordinatenPunkt := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Positive (Karten.Weltkarte'First (3)),
                                                                  ZahlenMaximumExtern => Positive (Karten.Karteneinstellungen.Kartengröße.XAchse),
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
