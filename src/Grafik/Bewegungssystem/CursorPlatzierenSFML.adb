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

package body CursorPlatzierenSFML is
   
   -- Das hier noch vollständig an das neue Viewsystem anpassen. äöü
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
      
      if
        Mausposition.y in 0.00 .. BerechnungenKarteSFML.FensterKarte.y
        and
          Mausposition.x in 0.00 .. BerechnungenKarteSFML.FensterKarte.x
      then
         SichtbereichAnfangEnde := BerechnungenKarteSFML.SichtbereichKarteBerechnen (RasseExtern => RasseExtern);
         YMultiplikator := 0.00;
         
      else
         return;
      end if;
            
      YAchseSchleife:
      for YAchseSchleifenwert in SichtbereichAnfangEnde (1) .. SichtbereichAnfangEnde (2) loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in SichtbereichAnfangEnde (3) .. SichtbereichAnfangEnde (4) loop
            
            if
              Mausposition.y in YMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.y .. YMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.y + BerechnungenKarteSFML.KartenfelderAbmessung.y
              and
                Mausposition.x in XMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.x .. XMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.x + BerechnungenKarteSFML.KartenfelderAbmessung.x
            then
               KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                                    ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                    LogikGrafikExtern => False);
               
               case
                 KartenWert.XAchse
               is
                  when KartenKonstanten.LeerXAchse =>
                     null;
                     
                  when others =>
                     SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.YAchse := KartenWert.YAchse;
                     SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell.XAchse := KartenWert.XAchse;
               end case;
               
               return;
               
            else
               XMultiplikator := XMultiplikator + 1.00;
            end if;
            
         end loop XAchseSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseSchleife;
            
   end CursorPlatzierenKarteSFML;
   
   
   
   procedure CursorPlatzierenStadtSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.KartenviewAccess);
      
      if
        Mausposition.y in 0.00 .. BerechnungenKarteSFML.StadtKarte.y
        and
          Mausposition.x in 0.00 .. BerechnungenKarteSFML.StadtKarte.x
      then
         BerechnungenKarteSFML.StadtfelderAbmessungBerechnen;
         YMultiplikator := 0.00;
         
      else
         return;
      end if;
      
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
