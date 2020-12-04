package body StadtWerteFestlegen is

   function StadtumgebungsgrößeFestlegen (Rasse, StadtNummer : in Integer) return Integer is
   begin
      
      if GlobaleVariablen.Wichtiges (Rasse).Erforscht (2) /= 0 and GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Einwohner >= 10 then
         return 2;

      elsif GlobaleVariablen.Wichtiges (Rasse).Erforscht (4) /= 0 and GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).Einwohner >= 20 then
         return 3;
                  
      else
         return 1;
      end if;
      
   end StadtumgebungsgrößeFestlegen;



   procedure BewirtschaftbareFelderBelegen (ZuwachsOderSchwund : Boolean; Rasse, StadtNummer : in Integer) is
   begin
      
      NutzbarerBereich := StadtumgebungsgrößeFestlegen (Rasse       => Rasse,
                                                        StadtNummer => StadtNummer);

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
                        KartenWert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).YAchse,
                                                                          XKoordinate    => GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).XAchse,
                                                                          YÄnderung      => YPosition,
                                                                          XÄnderung      => XPosition,
                                                                          ZusatzYAbstand => 0);
                        case KartenWert.YWert is
                           when GlobaleDatentypen.Kartenfeld'First =>
                              null;
                              
                              when others =>
                              GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).UmgebungBewirtschaftung (YPosition, XPosition) := True;
                              GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ArbeitendeEinwohner := GlobaleVariablen.StadtGebaut (Rasse, StadtNummer).ArbeitendeEinwohner + 1;
                              return;
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
