pragma SPARK_Mode (On);

with SchleifenPruefungen, Karten;

package body StadtWerteFestlegen is

   procedure StadtUmgebungGrößeFestlegen (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) is
   begin    
            
      if GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (2) /= 0 and GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Einwohner >= 10 then
         GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße := 2;

      elsif GlobaleVariablen.Wichtiges (RasseExtern).Erforscht (4) /= 0 and GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Einwohner >= 20 then
         GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße := 3;
                  
      else
         GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße := 1;
      end if;

      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);
            
            case KartenWert.YAchse is -- Der Wert ist nicht nur dazu da um unmögliche Positionen auszuschließen, sondern auch um die entsprechende XPosition zu haben!
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  if (YÄnderung < -GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße or YÄnderung > GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße
                      or XÄnderung < -GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße or XÄnderung > GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße)
                    and Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund 
                      = GlobaleDatentypen.BelegterGrund (RasseExtern) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtNummer) then
                     Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;

                  elsif YÄnderung < -GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße or YÄnderung > GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße
                    or XÄnderung < -GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße or XÄnderung > GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße then
                     null;
                     
                  elsif Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund = 0 then
                     Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                       := GlobaleDatentypen.BelegterGrund (RasseExtern) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtNummer);
                     
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end StadtUmgebungGrößeFestlegen;
   


   procedure BewirtschaftbareFelderBelegen (ZuwachsOderSchwund : Boolean; RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) is
   begin
      
      NutzbarerBereich := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße;

      YAchseSchleife:
      for YPosition in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XPosition in -NutzbarerBereich .. NutzbarerBereich loop
            
            case ZuwachsOderSchwund is
               when True =>
                  case GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).UmgebungBewirtschaftung (YPosition, XPosition) is
                     when True =>
                        null;
                  
                     when others =>
                        KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition,
                                                                          Änderung       => (0, YPosition, XPosition),
                                                                          ZusatzYAbstand => 0);
                        case KartenWert.YAchse is
                           when GlobaleDatentypen.Kartenfeld'First =>
                              exit XAchseSchleife;
                              
                           when others =>
                              if Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse, GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.YAchse + YPosition,
                                                GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.XAchse + XPosition).DurchStadtBelegterGrund
                                = GlobaleDatentypen.BelegterGrund (RasseExtern) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtNummer) then
                                 GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).UmgebungBewirtschaftung (YPosition, XPosition) := True;
                                 GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ArbeitendeEinwohner := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ArbeitendeEinwohner + 1;
                                 return;
                                 
                              else
                                 null;
                              end if;
                        end case;
                  end case;
                  
               when False => -- Hier erst prüfen ob mehr Bürger als Bewirtschaftungsfelder vorhanden sind und dann dementsprechend erst diese entfernen.
                  if YPosition = 0 and XPosition = 0 then
                     null;

                  elsif GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).UmgebungBewirtschaftung (YPosition, XPosition) = True then
                     GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).UmgebungBewirtschaftung (YPosition, XPosition) := False;
                     GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ArbeitendeEinwohner := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ArbeitendeEinwohner - 1;
                     return;

                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BewirtschaftbareFelderBelegen;

end StadtWerteFestlegen;
