with KartenKonstanten;
with GrafikRecordKonstanten;
with SystemDatentypen;

with LeseCursor;

with SichtweitenGrafik;
with KartenkoordinatenberechnungssystemLogik;

package body UmwandlungenGrafik is

   function KoordinatenKartenposition
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Sf.System.Vector2.sfVector2f
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      Sichtbereich := SichtweitenGrafik.SichtbereichLesen;
      CursorKoordinatenAlt := LeseCursor.KoordinatenAlt (SpeziesExtern => SpeziesExtern);
      Feldposition := GrafikRecordKonstanten.Nullposition;
      Kartenfeldfläche := SichtweitenGrafik.Kartenfeldfläche;
            
      YAchseSchleife:
      for YAchseSchleifenwert in -Sichtbereich.YAchse .. Sichtbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Sichtbereich.XAchse .. Sichtbereich.XAchse loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => CursorKoordinatenAlt,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              KartenWert = KoordinatenExtern
            then
               return Feldposition;
               
            else
               null;
            end if;
            
            Feldposition.x := Feldposition.x + Kartenfeldfläche.x;
                          
         end loop XAchseSchleife;
         
         Feldposition := (GrafikRecordKonstanten.Nullposition.x, Feldposition.y + Kartenfeldfläche.y);
         
      end loop YAchseSchleife;
      
      return GrafikRecordKonstanten.FalschePosition;
      
   end KoordinatenKartenposition;

end UmwandlungenGrafik;
