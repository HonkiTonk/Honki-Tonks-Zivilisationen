pragma SPARK_Mode (On);

with SchleifenPruefungen, Karten;

package body StadtWerteFestlegen is

   procedure StadtUmgebungGrößeFestlegen (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord) is
   begin    
            
      if GlobaleVariablen.Wichtiges (StadtRasseUndNummer.Rasse).Erforscht (2) /= 0 and GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).Einwohner >= 10 then
         GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).StadtUmgebungGröße := 2;

      elsif GlobaleVariablen.Wichtiges (StadtRasseUndNummer.Rasse).Erforscht (4) /= 0 and GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).Einwohner >= 20 then
         GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).StadtUmgebungGröße := 3;
                  
      else
         GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).StadtUmgebungGröße := 1;
      end if;

      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AchsenPosition,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);
            
            case KartenWert.YAchse is -- Der Wert ist nicht nur dazu da um unmögliche Positionen auszuschließen, sondern auch um die entsprechende XPosition zu haben!
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  if (YÄnderung < -GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).StadtUmgebungGröße or YÄnderung > GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).StadtUmgebungGröße
                      or XÄnderung < -GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).StadtUmgebungGröße or XÄnderung > GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).StadtUmgebungGröße)
                    and Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund 
                      = GlobaleDatentypen.BelegterGrund (StadtRasseUndNummer.Rasse) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseUndNummer.Platznummer) then
                     Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;

                  elsif YÄnderung < -GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).StadtUmgebungGröße or YÄnderung > GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).StadtUmgebungGröße
                    or XÄnderung < -GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).StadtUmgebungGröße or XÄnderung > GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).StadtUmgebungGröße then
                     null;
                     
                  elsif Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund = 0 then
                     Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                       := GlobaleDatentypen.BelegterGrund (StadtRasseUndNummer.Rasse) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseUndNummer.Platznummer);
                     
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end StadtUmgebungGrößeFestlegen;
   


   procedure BewirtschaftbareFelderBelegen (ZuwachsOderSchwund : Boolean; StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      NutzbarerBereich := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).StadtUmgebungGröße;

      YAchseSchleife:
      for YPosition in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XPosition in -NutzbarerBereich .. NutzbarerBereich loop
            
            case ZuwachsOderSchwund is
               when True =>
                  case GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).UmgebungBewirtschaftung (YPosition, XPosition) is
                     when True =>
                        null;
                  
                     when others =>
                        KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AchsenPosition,
                                                                          Änderung       => (0, YPosition, XPosition),
                                                                          ZusatzYAbstand => 0);
                        case KartenWert.YAchse is
                           when GlobaleDatentypen.Kartenfeld'First =>
                              exit XAchseSchleife;
                              
                           when others =>
                              if Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                                = GlobaleDatentypen.BelegterGrund (StadtRasseUndNummer.Rasse) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseUndNummer.Platznummer) then
                                 GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).UmgebungBewirtschaftung (YPosition, XPosition) := True;
                                 GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).ArbeitendeEinwohner
                                   := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).ArbeitendeEinwohner + 1;
                                 return;
                                 
                              else
                                 null;
                              end if;
                        end case;
                  end case;
                  
               when False => -- Hier erst prüfen ob mehr Bürger als Bewirtschaftungsfelder vorhanden sind und dann dementsprechend erst diese entfernen.
                  if YPosition = 0 and XPosition = 0 then
                     null;

                  elsif GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).UmgebungBewirtschaftung (YPosition, XPosition) = True then
                     GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).UmgebungBewirtschaftung (YPosition, XPosition) := False;
                     GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).ArbeitendeEinwohner
                       := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).ArbeitendeEinwohner - 1;
                     return;

                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BewirtschaftbareFelderBelegen;

end StadtWerteFestlegen;
