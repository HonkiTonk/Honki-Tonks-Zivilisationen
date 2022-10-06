pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with TextnummernKonstanten;
with KartenKonstanten;

with Weltkarte;
with ZahleneingabeLogik;
with NachGrafiktask;
with KartenkoordinatenberechnungssystemLogik;

package body CursorbewegungLogik is
   
   procedure CursorbewegungBerechnen
     (RichtungExtern : in TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Das Scrollen duch die Ebenen auch noch von den Ebenenübergangeinstellungen abhängig machen? äöü
      if
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.EAchse = KartenKonstanten.WeltraumKonstante
        and
          RichtungExtern = TastenbelegungDatentypen.Ebene_Hoch_Enum
      then
         KartenWert := (KartenKonstanten.PlaneteninneresKonstante, SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse, SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse);
           
      elsif
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.EAchse = KartenKonstanten.PlaneteninneresKonstante
        and
          RichtungExtern = TastenbelegungDatentypen.Ebene_Runter_Enum
      then
         KartenWert := (KartenKonstanten.WeltraumKonstante, SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse, SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse);
         
      else
         KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                                   ÄnderungExtern    => Richtung (RichtungExtern),
                                                                                                   LogikGrafikExtern => True);
      end if;
      
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
               
         when others =>
            NachGrafiktask.GeheZu := KartenWert;
      end case;
      
   end CursorbewegungBerechnen;



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
