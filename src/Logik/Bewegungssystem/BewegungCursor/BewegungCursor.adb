pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TextnummernKonstanten;

with Karten;
with EingabeSFML;
with NachGrafiktask;

package body BewegungCursor is
   
   procedure CursorbewegungBerechnen
     (RichtungExtern : in TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum;
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



   procedure GeheZu
   is begin
      
      KoordinatenPunkt := EingabeSFML.GanzeZahl (ZahlenMinimumExtern => Integer (Karten.Weltkarte'First (1)),
                                                 ZahlenMaximumExtern => Integer (Karten.Weltkarte'Last (1)),
                                                 WelcheFrageExtern   => TextnummernKonstanten.FrageWelcheEbene);
      
      case
        KoordinatenPunkt.EingabeAbbruch
      is
         when False =>
            return;
         
         when True =>
            NeueKoordinate.EAchse := KartenDatentypen.EbeneVorhanden (KoordinatenPunkt.EingegebeneZahl);
            KoordinatenPunkt := EingabeSFML.GanzeZahl (ZahlenMinimumExtern => Positive (Karten.Weltkarte'First (2)),
                                                       ZahlenMaximumExtern => Positive (Karten.Karteneinstellungen.Kartengröße.YAchse),
                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageWelcheYPosition);
      end case;
      
      case
        KoordinatenPunkt.EingabeAbbruch
      is
         when False =>
            return;
         
         when True =>
            NeueKoordinate.YAchse := KartenDatentypen.KartenfeldPositiv (KoordinatenPunkt.EingegebeneZahl);
            KoordinatenPunkt := EingabeSFML.GanzeZahl (ZahlenMinimumExtern => Positive (Karten.Weltkarte'First (3)),
                                                       ZahlenMaximumExtern => Positive (Karten.Karteneinstellungen.Kartengröße.XAchse),
                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageWelcheXPosition);
      end case;

      case
        KoordinatenPunkt.EingabeAbbruch
      is
         when False =>
            null;
         
         when True =>
            NeueKoordinate.XAchse := KartenDatentypen.KartenfeldPositiv (KoordinatenPunkt.EingegebeneZahl);
            NachGrafiktask.GeheZu := NeueKoordinate;
      end case;
      
   end GeheZu;

end BewegungCursor;
