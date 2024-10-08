with TextnummernKonstanten;
with KartenKonstanten;
with SystemDatentypen;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;
with LeseCursor;
with LeseGrafiktask;
with SchreibeGrafiktask;

with ZahleneingabeLogik;
with KartenkoordinatenberechnungssystemLogik;

package body CursorbewegungLogik is
   
   procedure CursorbewegungBerechnen
     (RichtungExtern : in TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type TastenbelegungDatentypen.Allgemeine_Belegung_Enum;
      use type KartenDatentypen.Ebene;
   begin
      
      -- Ist nötig, da sonst bei schnellem Scrollen die Ebene nicht korrekt gewechselt wird.
      case
        LeseGrafiktask.GeheZu.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            BasisKoordinaten := LeseCursor.KoordinatenAlt (SpeziesExtern => SpeziesExtern);
            
         when others =>
            BasisKoordinaten := LeseGrafiktask.GeheZu;
      end case;
      
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
                                                                                                   TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      end if;
      
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
               
         when others =>
            SchreibeGrafiktask.GeheZu (KoordinatenExtern => KartenWert);
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
            NeueKoordinate.YAchse := KartenDatentypen.SenkrechtePositiv (KoordinatenPunkt.EingegebeneZahl);
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
            NeueKoordinate.XAchse := KartenDatentypen.WaagerechtePositiv (KoordinatenPunkt.EingegebeneZahl);
            SchreibeGrafiktask.GeheZu (KoordinatenExtern => NeueKoordinate);
      end case;
      
   end GeheZu;

end CursorbewegungLogik;
