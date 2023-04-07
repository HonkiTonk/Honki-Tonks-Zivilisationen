with Sf.Graphics.RenderWindow;

with KartenKonstanten;
with Views;
with ViewKonstanten;

with LeseCursor;
with SchreibeCursor;

with InteraktionAllgemein;
with KartenkoordinatenberechnungssystemLogik;
with FensterGrafik;
with NachGrafiktask;
with SichtweitenGrafik;

package body CursorplatzierungGrafik is
   
   procedure Weltkarte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      case
        NachGrafiktask.GeheZu.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => FensterGrafik.FensterLesen,
                                                                       point        => (Sf.sfInt32 (InteraktionAllgemein.Mausposition.x), Sf.sfInt32 (InteraktionAllgemein.Mausposition.y)),
                                                                       view         => Views.WeltkarteAccess (ViewKonstanten.WeltKarte));
            Sichtbereich := SichtweitenGrafik.SichtweiteLesen;
            
         when others =>
            SchreibeCursor.KoordinatenAktuell (SpeziesExtern     => SpeziesExtern,
                                               KoordinatenExtern => NachGrafiktask.GeheZu);
            return;
      end case;
      
      if
        SichtweitenGrafik.Kartenfeldfläche.y = 0.00
        or else
          (Float'Floor (Mausposition.y / SichtweitenGrafik.Kartenfeldfläche.y) > Float (KartenDatentypen.Kartenfeld'Last)
           or
             Float'Floor (Mausposition.y / SichtweitenGrafik.Kartenfeldfläche.y) < Float (KartenDatentypen.Kartenfeld'First))
      then
         Kartenänderung.YAchse := -Sichtbereich;
         
      else
         Kartenänderung.YAchse := -Sichtbereich + KartenDatentypen.Kartenfeld (Float'Floor (Mausposition.y / SichtweitenGrafik.Kartenfeldfläche.y));
      end if;
      
      if
        SichtweitenGrafik.Kartenfeldfläche.x = 0.00
        or else
          (Float'Floor (Mausposition.x / SichtweitenGrafik.Kartenfeldfläche.x) > Float (KartenDatentypen.Kartenfeld'Last)
           or
             Float'Floor (Mausposition.x / SichtweitenGrafik.Kartenfeldfläche.x) < Float (KartenDatentypen.Kartenfeld'First))
      then
         Kartenänderung.XAchse := -Sichtbereich;
         
      else
         Kartenänderung.XAchse := -Sichtbereich + KartenDatentypen.Kartenfeld (Float'Floor (Mausposition.x / SichtweitenGrafik.Kartenfeldfläche.x));
      end if;
      
      KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseCursor.KoordinatenAlt (SpeziesExtern => SpeziesExtern),
                                                                                                ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, Kartenänderung.YAchse, Kartenänderung.XAchse),
                                                                                                LogikGrafikExtern => False);
      
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
