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

with LeseZeiger;
with SchreibeZeiger;
with LeseGrafiktask;

with KartenkoordinatenberechnungssystemLogik;
with FensterGrafik;
with SichtweitenGrafik;
with Vergleiche;

package body ZeigerplatzierungGrafik is
   
   procedure Weltkarte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      case
        LeseGrafiktask.GeheZu.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                       point        => InteraktionAuswahl.LeseGesamteMauspositionInteger,
                                                                       view         => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte));
            Sichtbereich := SichtweitenGrafik.SichtbereichLesen;
            
         when others =>
            SchreibeZeiger.KoordinatenAktuell (SpeziesExtern     => SpeziesExtern,
                                               KoordinatenExtern => LeseGrafiktask.GeheZu);
            return;
      end case;
      
      case
        Vergleiche.AuswahlpositionVereinfacht (MauspositionExtern => Mausposition,
                                               VektorExtern       => Sf.Graphics.View.getSize (view => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte)))
      is
         when False =>
            SchreibeZeiger.KoordinatenAktuell (SpeziesExtern     => SpeziesExtern,
                                               KoordinatenExtern => KartenRecordKonstanten.LeerKoordinate);
            return;
            
         when True =>
            null;
      end case;
      
      if
        SichtweitenGrafik.Kartenfeldfläche.y = GrafikKonstanten.Nullwert
        or else
          (Float'Floor (Mausposition.y / SichtweitenGrafik.Kartenfeldfläche.y) > Float (KartenDatentypen.Senkrechte'Last)
           or
             Float'Floor (Mausposition.y / SichtweitenGrafik.Kartenfeldfläche.y) < Float (KartenDatentypen.Senkrechte'First))
      then
         Kartenänderung.Senkrechte := -Sichtbereich.Senkrechte;
         
      else
         Kartenänderung.Senkrechte := -Sichtbereich.Senkrechte + KartenDatentypen.Senkrechte (Float'Floor (Mausposition.y / SichtweitenGrafik.Kartenfeldfläche.y));
      end if;
      
      if
        SichtweitenGrafik.Kartenfeldfläche.x = GrafikKonstanten.Nullwert
        or else
          (Float'Floor (Mausposition.x / SichtweitenGrafik.Kartenfeldfläche.x) > Float (KartenDatentypen.Senkrechte'Last)
           or
             Float'Floor (Mausposition.x / SichtweitenGrafik.Kartenfeldfläche.x) < Float (KartenDatentypen.Senkrechte'First))
      then
         Kartenänderung.Waagerechte := -Sichtbereich.Waagerechte;
         
      else
         Kartenänderung.Waagerechte := -Sichtbereich.Waagerechte + KartenDatentypen.Waagerechte (Float'Floor (Mausposition.x / SichtweitenGrafik.Kartenfeldfläche.x));
      end if;
      
      KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseZeiger.KoordinatenAlt (SpeziesExtern => SpeziesExtern),
                                                                                                ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, Kartenänderung.Senkrechte, Kartenänderung.Waagerechte),
                                                                                                TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
      
      case
        KartenWert.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            null;
                     
         when others =>
            SchreibeZeiger.KoordinatenAktuell (SpeziesExtern     => SpeziesExtern,
                                               KoordinatenExtern => KartenWert);
      end case;
                           
   end Weltkarte;
   
end ZeigerplatzierungGrafik;
