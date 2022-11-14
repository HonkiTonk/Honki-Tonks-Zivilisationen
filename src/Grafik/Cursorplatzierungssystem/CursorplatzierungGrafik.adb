with Sf.Graphics.RenderWindow;

with KartenKonstanten;
with Views;

with NachLogiktask;
with KartenberechnungenGrafik;
with KartenkoordinatenberechnungssystemLogik;
with EinstellungenGrafik;
with NachGrafiktask;
with SichtweitenGrafik;

package body CursorplatzierungGrafik is
   
   procedure Weltkarte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      case
        NachGrafiktask.GeheZu.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => EinstellungenGrafik.FensterAccess,
                                                                       point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                       view         => Views.KartenviewAccess);
            Sichtbereich := SichtweitenGrafik.SichtweiteLesen;
            
         when others =>
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell := NachGrafiktask.GeheZu;
            return;
      end case;
      
      if
        KartenberechnungenGrafik.KartenfelderAbmessung.y = 0.00
        or
          Float'Floor (Mausposition.y / KartenberechnungenGrafik.KartenfelderAbmessung.y) > Float (KartenDatentypen.Kartenfeld'Last)
        or
          Float'Floor (Mausposition.y / KartenberechnungenGrafik.KartenfelderAbmessung.y) < Float (KartenDatentypen.Kartenfeld'First)
      then
         Kartenänderung.YAchse := -Sichtbereich;
         
      else
         Kartenänderung.YAchse := -Sichtbereich + KartenDatentypen.Kartenfeld (Float'Floor (Mausposition.y / KartenberechnungenGrafik.KartenfelderAbmessung.y));
      end if;
      
      if
        KartenberechnungenGrafik.KartenfelderAbmessung.x = 0.00
        or
          Float'Floor (Mausposition.x / KartenberechnungenGrafik.KartenfelderAbmessung.x) > Float (KartenDatentypen.Kartenfeld'Last)
        or
          Float'Floor (Mausposition.x / KartenberechnungenGrafik.KartenfelderAbmessung.x) < Float (KartenDatentypen.Kartenfeld'First)
      then
         Kartenänderung.XAchse := -Sichtbereich;
         
      else
         Kartenänderung.XAchse := -Sichtbereich + KartenDatentypen.Kartenfeld (Float'Floor (Mausposition.x / KartenberechnungenGrafik.KartenfelderAbmessung.x));
      end if;
      
      KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                                ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, Kartenänderung.YAchse, Kartenänderung.XAchse),
                                                                                                LogikGrafikExtern => False);
      
      case
        KartenWert.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            null;
                     
         when others =>
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse := KartenWert.YAchse;
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse := KartenWert.XAchse;
      end case;
                           
   end Weltkarte;
   
end CursorplatzierungGrafik;
