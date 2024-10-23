with TextnummernKonstanten;
with KartenKonstanten;
with SystemDatentypen;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;
with LeseZeiger;
with LeseGrafiktask;
with SchreibeGrafiktask;

with ZahleneingabeLogik;
with KartenkoordinatenberechnungssystemLogik;

package body ZeigerbewegungLogik is
   
   procedure ZeigerbewegungBerechnen
     (RichtungExtern : in TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type TastenbelegungDatentypen.Allgemeine_Belegung_Enum;
      use type KartenDatentypen.Ebene;
   begin
      
      -- Ist nötig, da sonst bei schnellem Scrollen die Ebene nicht korrekt gewechselt wird.
      case
        LeseGrafiktask.GeheZu.Waagerechte
      is
         when KartenKonstanten.LeerWaagerechte =>
            BasisKoordinaten := LeseZeiger.KoordinatenAlt (SpeziesExtern => SpeziesExtern);
            
         when others =>
            BasisKoordinaten := LeseGrafiktask.GeheZu;
      end case;
      
      if
        BasisKoordinaten.Ebene = KartenKonstanten.WeltraumKonstante
        and
          RichtungExtern = TastenbelegungDatentypen.Ebene_Hoch_Enum
      then
         KartenWert := (KartenKonstanten.PlaneteninneresKonstante, BasisKoordinaten.Senkrechte, BasisKoordinaten.Waagerechte);
           
      elsif
        BasisKoordinaten.Ebene = KartenKonstanten.PlaneteninneresKonstante
        and
          RichtungExtern = TastenbelegungDatentypen.Ebene_Runter_Enum
      then
         KartenWert := (KartenKonstanten.WeltraumKonstante, BasisKoordinaten.Senkrechte, BasisKoordinaten.Waagerechte);
         
      else
         KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => BasisKoordinaten,
                                                                                                   ÄnderungExtern    => Richtung (RichtungExtern),
                                                                                                   TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      end if;
      
      case
        KartenWert.Waagerechte
      is
         when KartenKonstanten.LeerWaagerechte =>
            null;
               
         when others =>
            SchreibeGrafiktask.GeheZu (KoordinatenExtern => KartenWert);
      end case;
      
   end ZeigerbewegungBerechnen;



   procedure GeheZu
   is begin
      
      KoordinatenPunkt := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Integer (KartenKonstanten.AnfangEbene),
                                                            ZahlenMaximumExtern => Integer (KartenKonstanten.EndeEbene),
                                                            WelcheFrageExtern   => TextnummernKonstanten.FrageWelcheEbene);
      
      case
        KoordinatenPunkt.ErfolgreichAbbruch
      is
         when False =>
            return;
         
         when True =>
            NeueKoordinate.Ebene := KartenDatentypen.EbeneVorhanden (KoordinatenPunkt.EingegebeneZahl);
            KoordinatenPunkt := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Positive (KartenKonstanten.AnfangSenkrechte),
                                                                  ZahlenMaximumExtern => Positive (LeseWeltkarteneinstellungen.Senkrechte),
                                                                  WelcheFrageExtern   => TextnummernKonstanten.FrageWelcheYPosition);
      end case;
      
      case
        KoordinatenPunkt.ErfolgreichAbbruch
      is
         when False =>
            return;
         
         when True =>
            NeueKoordinate.Senkrechte := KartenDatentypen.SenkrechtePositiv (KoordinatenPunkt.EingegebeneZahl);
            KoordinatenPunkt := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Positive (KartenKonstanten.AnfangWaagerechte),
                                                                  ZahlenMaximumExtern => Positive (LeseWeltkarteneinstellungen.Waagerechte),
                                                                  WelcheFrageExtern   => TextnummernKonstanten.FrageWelcheXPosition);
      end case;

      case
        KoordinatenPunkt.ErfolgreichAbbruch
      is
         when False =>
            null;
         
         when True =>
            NeueKoordinate.Waagerechte := KartenDatentypen.WaagerechtePositiv (KoordinatenPunkt.EingegebeneZahl);
            SchreibeGrafiktask.GeheZu (KoordinatenExtern => NeueKoordinate);
      end case;
      
   end GeheZu;

end ZeigerbewegungLogik;
