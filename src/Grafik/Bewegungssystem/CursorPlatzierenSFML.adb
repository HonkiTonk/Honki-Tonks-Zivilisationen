pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;
with Views;

with NachLogiktask;
with BerechnungenKarteSFML;
with Kartenkoordinatenberechnungssystem;
with Karten;
with GrafikEinstellungenSFML;
with NachGrafiktask;
with Vergleiche;

package body CursorPlatzierenSFML is
   
   procedure CursorPlatzierenKarteSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        NachGrafiktask.GeheZu.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                                       point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                       view         => Views.KartenviewAccess);
            
         when others =>
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell := NachGrafiktask.GeheZu;
            return;
      end case;
            
      SichtbereichAnfangEnde := BerechnungenKarteSFML.SichtbereichKarteBerechnen;
      Kartenänderung.YAchse := SichtbereichAnfangEnde (1) + KartenDatentypen.Kartenfeld (Float'Floor (Mausposition.y / BerechnungenKarteSFML.KartenfelderAbmessung.y));
      Kartenänderung.XAchse := SichtbereichAnfangEnde (3) + KartenDatentypen.Kartenfeld (Float'Floor (Mausposition.x / BerechnungenKarteSFML.KartenfelderAbmessung.x));
      
      KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                           ÄnderungExtern    => (0, Kartenänderung.YAchse, Kartenänderung.XAchse),
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
                           
   end CursorPlatzierenKarteSFML;
   
   
   
   -- Kann theoretisch komplett entfernt werden, nach einer völligen Überarbeitung des Stadtsystems. äöü
   -- Danach brauche ich wahrscheinlich auch die Stadtcursorkoordinaten Sachen alle nicht mehr? äöü
   procedure CursorPlatzierenStadtSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.KartenviewAccess);
      
      case
        Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                    TextboxExtern      => BerechnungenKarteSFML.StadtKarte)
      is
         when True =>
            -- Sollte das hier nicht genau wie weiter oben eine Funktion sein? äöü
            BerechnungenKarteSFML.StadtfelderAbmessungBerechnen;
            YMultiplikator := 0.00;
         
         when False =>
            return;
      end case;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.StadtkarteArray'Range (1) loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.StadtkarteArray'Range (2) loop
            
            if
              Mausposition.y in YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y .. YMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.y + BerechnungenKarteSFML.StadtfelderAbmessung.y
              and
                Mausposition.x in XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x .. XMultiplikator * BerechnungenKarteSFML.StadtfelderAbmessung.x + BerechnungenKarteSFML.StadtfelderAbmessung.x
            then
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.YAchse := YAchseSchleifenwert;
               SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenStadt.XAchse := XAchseSchleifenwert;
               return;
             
            else
               XMultiplikator := XMultiplikator + 1.00;
            end if;
            
         end loop XAchseSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseSchleife;
      
   end CursorPlatzierenStadtSFML;

end CursorPlatzierenSFML;
