pragma SPARK_Mode (On);

with Karten, KartenPruefungen;

package body StadtWerteFestlegen is

   procedure StadtUmgebungGrößeFestlegen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin    
            
      if GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).Erforscht (2) /= 0 and GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner >= 10 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße := 2;

      elsif GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).Erforscht (4) /= 0 and GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner >= 20 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße := 3;
                  
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße := 1;
      end if;

      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop -- StadtUmgebungGröße darf hier nicht genutzt werden, damit bei einer Verkleinerung auch alle Felder zurückgenommen werden können.
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AchsenPosition,
                                                                    Änderung       => (0, YÄnderung, XÄnderung),
                                                                    ZusatzYAbstand => 0);
            
            case KartenWert.Erfolgreich is -- Der Wert ist nicht nur dazu da um unmögliche Positionen auszuschließen, sondern auch um die entsprechende XPosition zu haben!
               when False =>
                  exit XAchseSchleife;
                  
               when True =>
                  if (YÄnderung < -GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße or YÄnderung > GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße
                      or XÄnderung < -GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße or XÄnderung > GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße)
                    and Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund 
                    = GlobaleDatentypen.BelegterGrund (StadtRasseNummer.Rasse) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummer.Platznummer) then
                     Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;

                  elsif YÄnderung < -GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße or YÄnderung > GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße
                    or XÄnderung < -GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße or XÄnderung > GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße then
                     null;
                     
                  elsif Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund = 0 then
                     Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                       := GlobaleDatentypen.BelegterGrund (StadtRasseNummer.Rasse) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummer.Platznummer);
                     
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end StadtUmgebungGrößeFestlegen;
   


   procedure BewirtschaftbareFelderBelegen (ZuwachsOderSchwund : in Boolean; StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      NutzbarerBereich := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße;

      YAchseSchleife:
      for YPosition in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XPosition in -NutzbarerBereich .. NutzbarerBereich loop
            
            case ZuwachsOderSchwund is
               when True =>
                  case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).UmgebungBewirtschaftung (YPosition, XPosition) is
                     when True =>
                        null;
                  
                     when others =>
                        KartenWert := KartenPruefungen.KartenPositionBestimmen (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AchsenPosition,
                                                                                Änderung       => (0, YPosition, XPosition),
                                                                                ZusatzYAbstand => 0);
                        case KartenWert.Erfolgreich is
                           when False =>
                              exit XAchseSchleife;
                              
                           when True =>
                              if Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                                = GlobaleDatentypen.BelegterGrund (StadtRasseNummer.Rasse) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummer.Platznummer) then
                                 GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).UmgebungBewirtschaftung (YPosition, XPosition) := True;
                                 GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).ArbeitendeEinwohner
                                   := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).ArbeitendeEinwohner + 1;
                                 return;
                                 
                              else
                                 null;
                              end if;
                        end case;
                  end case;
                  
               when False => -- Hier erst prüfen ob mehr Bürger als Bewirtschaftungsfelder vorhanden sind und dann dementsprechend erst diese entfernen.
                  if YPosition = 0 and XPosition = 0 then
                     null;

                  elsif GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).UmgebungBewirtschaftung (YPosition, XPosition) = True then
                     GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).UmgebungBewirtschaftung (YPosition, XPosition) := False;
                     GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).ArbeitendeEinwohner
                       := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).ArbeitendeEinwohner - 1;
                     return;

                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BewirtschaftbareFelderBelegen;



   procedure BelegteStadtfelderFreigeben (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AchsenPosition,
                                                                    Änderung       => (0, YÄnderung, XÄnderung),
                                                                    ZusatzYAbstand => 0);
            
            case KartenWert.Erfolgreich is
               when False =>
                  exit XAchseSchleife;
                  
               when True =>
                  if Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                    = GlobaleDatentypen.BelegterGrund (StadtRasseNummer.Rasse) * StadtWerteFestlegen.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummer.Platznummer) then
                     Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;
                        
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BelegteStadtfelderFreigeben;

end StadtWerteFestlegen;
