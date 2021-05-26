pragma SPARK_Mode (On);

with Karten, KartenPruefungen;

package body StadtWerteFestlegen is

   procedure StadtUmgebungGrößeFestlegen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin    
            
      if
        GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (2) = True
        and
          GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner >= 10
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße := 2;

      elsif
        GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (4) = True
        and
          GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner >= 20
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße := 3;

      elsif
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Einwohner = 0
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße := 0;
                  
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße := 1;
      end if;

      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop -- StadtUmgebungGröße darf hier nicht genutzt werden, damit bei einer Verkleinerung auch alle Felder zurückgenommen werden können.
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition,
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                    ZusatzYAbstandExtern => 0);
            
            case KartenWert.Erfolgreich is
               when False =>
                  exit XAchseSchleife;
                  
               when True =>
                  null;
            end case;
            
            if
              (YÄnderungSchleifenwert < -GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße
               or
                 YÄnderungSchleifenwert > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße
               or
                 XÄnderungSchleifenwert < -GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße
               or
                 XÄnderungSchleifenwert > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße)
              and
                Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund 
              = GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Rasse) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer)
            then
               Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;

            elsif
              YÄnderungSchleifenwert < -GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße
              or
                YÄnderungSchleifenwert > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße
              or
                XÄnderungSchleifenwert < -GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße
              or
                XÄnderungSchleifenwert > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße
            then
               null;
                     
            elsif
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund = 0
            then
               Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                 := GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Rasse) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer);
                     
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end StadtUmgebungGrößeFestlegen;
   


   procedure BewirtschaftbareFelderBelegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      NutzbarerBereich := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße;

      YAchseSchleife:
      for YPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            case
              ZuwachsOderSchwundExtern
            is
               when True =>
                  if
                    GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPositionSchleifenwert, XPositionSchleifenwert) = True
                  then
                     null;
                  
                  else
                     KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition,
                                                                             ÄnderungExtern       => (0, YPositionSchleifenwert, XPositionSchleifenwert),
                                                                             ZusatzYAbstandExtern => 0);
                     case
                       KartenWert.Erfolgreich
                     is
                        when False =>
                           exit XAchseSchleife;
                              
                        when True =>
                           null;
                     end case;

                     if
                       Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                       = GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Rasse) * RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer)
                     then
                        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPositionSchleifenwert, XPositionSchleifenwert) := True;
                        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ArbeitendeEinwohner
                          := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).ArbeitendeEinwohner + 1;
                        return;
                                 
                     else
                        null;
                     end if;
                  end if;
                  
               when False => -- Hier erst prüfen ob mehr Bürger als Bewirtschaftungsfelder vorhanden sind und dann dementsprechend erst diese entfernen.
                  if
                    YPositionSchleifenwert = 0
                    and
                      XPositionSchleifenwert = 0
                  then
                     null;

                  elsif
                    GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPositionSchleifenwert, XPositionSchleifenwert) = True
                  then
                     GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPositionSchleifenwert, XPositionSchleifenwert) := False;
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



   procedure BelegteStadtfelderFreigeben
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition,
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                    ZusatzYAbstandExtern => 0);
            
            case KartenWert.Erfolgreich is
               when False =>
                  exit XAchseSchleife;
                  
               when True =>
                  null;
            end case;
            
            if
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
              = GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Rasse) * StadtWerteFestlegen.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer)
            then
               Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;
                        
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BelegteStadtfelderFreigeben;

end StadtWerteFestlegen;
