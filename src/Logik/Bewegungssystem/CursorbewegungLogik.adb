with TextnummernKonstanten;
with KartenKonstanten;

with LeseWeltkarteneinstellungen;
with LeseCursor;

with ZahleneingabeLogik;
with NachGrafiktask;
with KartenkoordinatenberechnungssystemLogik;

package body CursorbewegungLogik is
   
   procedure CursorbewegungBerechnen
     (RichtungExtern : in TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type TastenbelegungDatentypen.Allgemeine_Belegung_Enum;
   begin
      
      -- Ist nötig, da sonst bei schnellem Scrollen die Ebene nicht korrekt gewechselt wird.
      case
        NachGrafiktask.GeheZu.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            BasisKoordinaten := LeseCursor.KoordinatenAlt (SpeziesExtern => SpeziesExtern);
            
         when others =>
            BasisKoordinaten := NachGrafiktask.GeheZu;
      end case;
      
      -- Das Scrollen duch die Ebenen auch noch von den Ebenenübergangeinstellungen abhängig machen? äöü
      if
        BasisKoordinaten.EAchse = KartenKonstanten.WeltraumKonstante
        and
          RichtungExtern = TastenbelegungDatentypen.Ebene_Hoch_Enum
      then
         KartenWert := (KartenKonstanten.PlaneteninneresKonstante, BasisKoordinaten.YAchse, BasisKoordinaten.XAchse);
           
      elsif
        BasisKoordinaten.EAchse = KartenKonstanten.PlaneteninneresKonstante
        and
          RichtungExtern = TastenbelegungDatentypen.Ebene_Runter_Enum
      then
         KartenWert := (KartenKonstanten.WeltraumKonstante, BasisKoordinaten.YAchse, BasisKoordinaten.XAchse);
         
      else
         KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => BasisKoordinaten,
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
      
      KoordinatenPunkt := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Integer (KartenKonstanten.AnfangEAchse),
                                                            ZahlenMaximumExtern => Integer (KartenKonstanten.EndeEAchse),
                                                            WelcheFrageExtern   => TextnummernKonstanten.FrageWelcheEbene);
      
      case
        KoordinatenPunkt.ErfolgreichAbbruch
      is
         when False =>
            return;
         
         when True =>
            NeueKoordinate.EAchse := KartenDatentypen.EbeneVorhanden (KoordinatenPunkt.EingegebeneZahl);
            KoordinatenPunkt := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Positive (KartenKonstanten.AnfangYAchse),
                                                                  ZahlenMaximumExtern => Positive (LeseWeltkarteneinstellungen.YAchse),
                                                                  WelcheFrageExtern   => TextnummernKonstanten.FrageWelcheYPosition);
      end case;
      
      case
        KoordinatenPunkt.ErfolgreichAbbruch
      is
         when False =>
            return;
         
         when True =>
            NeueKoordinate.YAchse := KartenDatentypen.KartenfeldPositiv (KoordinatenPunkt.EingegebeneZahl);
            KoordinatenPunkt := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Positive (KartenKonstanten.AnfangXAchse),
                                                                  ZahlenMaximumExtern => Positive (LeseWeltkarteneinstellungen.XAchse),
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
