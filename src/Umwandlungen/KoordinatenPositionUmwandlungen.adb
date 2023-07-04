with KartenKonstanten;
with KartenRecordKonstanten;
with GrafikRecordKonstanten;
with SystemDatentypen;

with LeseCursor;

with SichtweitenGrafik;
with KartenkoordinatenberechnungssystemLogik;
with Vergleiche;

package body KoordinatenPositionUmwandlungen is

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
            
            Feldposition.x := Feldposition.x + SichtweitenGrafik.Kartenfeldfläche.x;
                          
         end loop XAchseSchleife;
         
         Feldposition := (GrafikRecordKonstanten.Nullposition.x, Feldposition.y + SichtweitenGrafik.Kartenfeldfläche.y);
         
      end loop YAchseSchleife;
      
      return GrafikRecordKonstanten.FalschePosition;
      
   end KoordinatenKartenposition;
   
   
   
   -- Noch ungetestet, könnte eventuell nicht richtig funktionieren.
   function KartenpositionKoordinaten
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      Sichtbereich := SichtweitenGrafik.SichtbereichLesen;
      CursorKoordinatenAlt := LeseCursor.KoordinatenAlt (SpeziesExtern => SpeziesExtern);
      Feldposition := GrafikRecordKonstanten.Nullposition;
            
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
              True = Vergleiche.Auswahlposition (MauspositionExtern => PositionExtern,
                                                 RechteckExtern     => (Feldposition.x, Feldposition.y,
                                                                        Feldposition.x + SichtweitenGrafik.Kartenfeldfläche.x, Feldposition.y + SichtweitenGrafik.Kartenfeldfläche.y))
            then
               return KartenWert;
               
            else
               null;
            end if;
            
            Feldposition.x := Feldposition.x + SichtweitenGrafik.Kartenfeldfläche.x;
                          
         end loop XAchseSchleife;
         
         Feldposition := (GrafikRecordKonstanten.Nullposition.x, Feldposition.y + SichtweitenGrafik.Kartenfeldfläche.y);
         
      end loop YAchseSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end KartenpositionKoordinaten;

end KoordinatenPositionUmwandlungen;
