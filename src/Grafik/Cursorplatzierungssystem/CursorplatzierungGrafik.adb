with Sf.Graphics.RenderWindow;
with Sf.Graphics.View;

with KartenKonstanten;
with Views;
with ViewKonstanten;
with KartenDatentypen;
with GrafikKonstanten;
with SystemDatentypen;
with InteraktionAuswahl;
with KartenRecordKonstanten;

with LeseCursor;
with SchreibeCursor;
with LeseGrafiktask;

with KartenkoordinatenberechnungssystemLogik;
with FensterGrafik;
with SichtweitenGrafik;
with Vergleiche;

package body CursorplatzierungGrafik is
   
   procedure Weltkarte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      case
        LeseGrafiktask.GeheZu.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                       point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                       view         => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte));
            Sichtbereich := SichtweitenGrafik.SichtbereichLesen;
            
         when others =>
            SchreibeCursor.KoordinatenAktuell (SpeziesExtern     => SpeziesExtern,
                                               KoordinatenExtern => LeseGrafiktask.GeheZu);
            return;
      end case;
      
      case
        Vergleiche.AuswahlpositionVereinfacht (MauspositionExtern => Mausposition,
                                               VektorExtern       => Sf.Graphics.View.getSize (view => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte)))
      is
         when False =>
            SchreibeCursor.KoordinatenAktuell (SpeziesExtern     => SpeziesExtern,
                                               KoordinatenExtern => KartenRecordKonstanten.LeerKoordinate);
            return;
            
         when True =>
            null;
      end case;
      
      if
        SichtweitenGrafik.Kartenfeldfläche.y = GrafikKonstanten.Nullwert
        or else
          (Float'Floor (Mausposition.y / SichtweitenGrafik.Kartenfeldfläche.y) > Float (KartenDatentypen.Kartenfeld'Last)
           or
             Float'Floor (Mausposition.y / SichtweitenGrafik.Kartenfeldfläche.y) < Float (KartenDatentypen.Kartenfeld'First))
      then
         Kartenänderung.YAchse := -Sichtbereich.YAchse;
         
      else
         Kartenänderung.YAchse := -Sichtbereich.YAchse + KartenDatentypen.Kartenfeld (Float'Floor (Mausposition.y / SichtweitenGrafik.Kartenfeldfläche.y));
      end if;
      
      if
        SichtweitenGrafik.Kartenfeldfläche.x = GrafikKonstanten.Nullwert
        or else
          (Float'Floor (Mausposition.x / SichtweitenGrafik.Kartenfeldfläche.x) > Float (KartenDatentypen.Kartenfeld'Last)
           or
             Float'Floor (Mausposition.x / SichtweitenGrafik.Kartenfeldfläche.x) < Float (KartenDatentypen.Kartenfeld'First))
      then
         Kartenänderung.XAchse := -Sichtbereich.XAchse;
         
      else
         Kartenänderung.XAchse := -Sichtbereich.XAchse + KartenDatentypen.Kartenfeld (Float'Floor (Mausposition.x / SichtweitenGrafik.Kartenfeldfläche.x));
      end if;
      
      KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseCursor.KoordinatenAlt (SpeziesExtern => SpeziesExtern),
                                                                                                ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, Kartenänderung.YAchse, Kartenänderung.XAchse),
                                                                                                TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
      
      case
        KartenWert.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            null;
                     
         when others =>
            SchreibeCursor.KoordinatenAktuell (SpeziesExtern     => SpeziesExtern,
                                               KoordinatenExtern => KartenWert);
      end case;
                           
   end Weltkarte;
   
end CursorplatzierungGrafik;
