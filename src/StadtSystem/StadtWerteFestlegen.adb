pragma SPARK_Mode (On);

with Karten, KartenPruefungen;

package body StadtWerteFestlegen is

   procedure StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin    
            
      if GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (2) = True and GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner >= 10 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße := 2;

      elsif GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (4) = True and GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner >= 20 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße := 3;

      elsif GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner = 0 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße := 0;
                  
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße := 1;
      end if;

      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop -- StadtUmgebungGröße darf hier nicht genutzt werden, damit bei einer Verkleinerung auch alle Felder zurückgenommen werden können.
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition,
                                                                    ÄnderungExtern       => (0, YÄnderung, XÄnderung),
                                                                    ZusatzYAbstandExtern => 0);
            
            case KartenWert.Erfolgreich is
               when False =>
                  exit XAchseSchleife;
                  
               when True =>
                  if (YÄnderung < -GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße
                      or YÄnderung > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße
                      or XÄnderung < -GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße
                      or XÄnderung > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße)
                    and Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund 
                    = GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Rasse) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer) then
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;

                  elsif YÄnderung < -GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße
                    or YÄnderung > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße
                    or XÄnderung < -GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße
                    or XÄnderung > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße then
                     null;
                     
                  elsif Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund = 0 then
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                       := GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Rasse) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer);
                     
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end StadtUmgebungGrößeFestlegen;
   


   procedure BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern : in Boolean; StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      NutzbarerBereich := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße;

      YAchseSchleife:
      for YPosition in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XPosition in -NutzbarerBereich .. NutzbarerBereich loop
            
            case ZuwachsOderSchwundExtern is
               when True =>
                  case GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPosition, XPosition) is
                     when True =>
                        null;
                  
                     when others =>
                        KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition,
                                                                                ÄnderungExtern       => (0, YPosition, XPosition),
                                                                                ZusatzYAbstandExtern => 0);
                        case KartenWert.Erfolgreich is
                           when False =>
                              exit XAchseSchleife;
                              
                           when True =>
                              if Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                                = GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Rasse) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer) then
                                 GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPosition, XPosition) := True;
                                 GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ArbeitendeEinwohner
                                   := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ArbeitendeEinwohner + 1;
                                 return;
                                 
                              else
                                 null;
                              end if;
                        end case;
                  end case;
                  
               when False => -- Hier erst prüfen ob mehr Bürger als Bewirtschaftungsfelder vorhanden sind und dann dementsprechend erst diese entfernen.
                  if YPosition = 0 and XPosition = 0 then
                     null;

                  elsif GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPosition, XPosition) = True then
                     GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPosition, XPosition) := False;
                     GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ArbeitendeEinwohner
                       := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ArbeitendeEinwohner - 1;
                     return;

                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BewirtschaftbareFelderBelegen;



   procedure BelegteStadtfelderFreigeben (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition,
                                                                    ÄnderungExtern       => (0, YÄnderung, XÄnderung),
                                                                    ZusatzYAbstandExtern => 0);
            
            case KartenWert.Erfolgreich is
               when False =>
                  exit XAchseSchleife;
                  
               when True =>
                  if Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                    = GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Rasse) * StadtWerteFestlegen.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer) then
                     Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;
                        
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BelegteStadtfelderFreigeben;

end StadtWerteFestlegen;
