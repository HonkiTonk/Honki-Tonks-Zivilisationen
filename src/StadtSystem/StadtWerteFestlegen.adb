package body StadtWerteFestlegen is

   procedure StadtUmgebungGrößeFestlegen (Rasse, StadtNummer : in Integer) is
   begin    
            
      if GlobaleVariablen.Wichtiges (Rasse).Erforscht (2) /= 0 and GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Einwohner >= 10 then
         GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).StadtUmgebungGröße := 2;

      elsif GlobaleVariablen.Wichtiges (Rasse).Erforscht (4) /= 0 and GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Einwohner >= 20 then
         GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).StadtUmgebungGröße := 3;
                  
      else
         GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).StadtUmgebungGröße := 1;
      end if;

      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.YAchse,
                                                              XKoordinate    => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.XAchse,
                                                              YÄnderung      => YÄnderung,
                                                              XÄnderung      => XÄnderung,
                                                              ZusatzYAbstand => 0);
            
            case KartenWert.YAchse is -- Der Wert ist nicht nur dazu da um unmögliche Positionen auszuschließen, sondern auch um die entsprechende XPosition zu haben!
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  if (YÄnderung < -GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).StadtUmgebungGröße or YÄnderung > GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).StadtUmgebungGröße
                      or XÄnderung < -GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).StadtUmgebungGröße or XÄnderung > GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).StadtUmgebungGröße)
                    and Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund 
                      = GlobaleDatentypen.BelegterGrund (Rasse) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtNummer) then
                     Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;

                  elsif YÄnderung < -GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).StadtUmgebungGröße or YÄnderung > GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).StadtUmgebungGröße
                    or XÄnderung < -GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).StadtUmgebungGröße or XÄnderung > GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).StadtUmgebungGröße then
                     null;
                     
                  elsif Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund = 0 then
                     Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                       := GlobaleDatentypen.BelegterGrund (Rasse) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtNummer);
                     
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end StadtUmgebungGrößeFestlegen;
   


   procedure BewirtschaftbareFelderBelegen (ZuwachsOderSchwund : Boolean; Rasse, StadtNummer : in Integer) is
   begin
      
      NutzbarerBereich := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).StadtUmgebungGröße;

      YAchseSchleife:
      for YPosition in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XPosition in -NutzbarerBereich .. NutzbarerBereich loop
            
            case ZuwachsOderSchwund is
               when True =>
                  case GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).UmgebungBewirtschaftung (YPosition, XPosition) is
                     when True =>
                        null;
                  
                     when others =>
                        KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.YAchse,
                                                                          XKoordinate    => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.XAchse,
                                                                          YÄnderung      => YPosition,
                                                                          XÄnderung      => XPosition,
                                                                          ZusatzYAbstand => 0);
                        case KartenWert.YAchse is
                           when GlobaleDatentypen.Kartenfeld'First =>
                              exit XAchseSchleife;
                              
                           when others =>
                              if Karten.Karten (GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.EAchse, GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.YAchse + YPosition,
                                                GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).AchsenPosition.XAchse + XPosition).DurchStadtBelegterGrund
                                = GlobaleDatentypen.BelegterGrund (Rasse) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtNummer) then
                                 GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).UmgebungBewirtschaftung (YPosition, XPosition) := True;
                                 GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ArbeitendeEinwohner := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ArbeitendeEinwohner + 1;
                                 return;
                                 
                              else
                                 null;
                              end if;
                        end case;
                  end case;
                  
               when False => -- Hier erst prüfen ob mehr Bürger als Bewirtschaftungsfelder vorhanden sind und dann dementsprechend erst diese entfernen.
                  if YPosition = 0 and XPosition = 0 then
                     null;

                  elsif GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).UmgebungBewirtschaftung (YPosition, XPosition) = True then
                     GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).UmgebungBewirtschaftung (YPosition, XPosition) := False;
                     GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ArbeitendeEinwohner := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ArbeitendeEinwohner - 1;
                     return;

                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BewirtschaftbareFelderBelegen;

end StadtWerteFestlegen;
