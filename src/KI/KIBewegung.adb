package body KIBewegung is

   procedure KIBewegung (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive; Aufgabe : Wide_Wide_Character) is
   begin

      -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft
      case Aufgabe is
         when 'f' =>
            null;
            
         when others =>
            null;
      end case;
      
      BewegungSiedler (RasseExtern   => RasseExtern,
                       EinheitNummer => EinheitNummer);
      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := 0.00;
      
   end KIBewegung;



   procedure BewegungSiedler (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) is
   begin

      Schleife:
      for Durchgang in 1 .. 2 loop
         YAchseSchleife:
         for YAchse in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            XAchseSchleife:
            for XAchse in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
               Kartenwert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                                                 XKoordinate    => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse,
                                                                 YÄnderung      => YAchse,
                                                                 XÄnderung      => XAchse,
                                                                 ZusatzYAbstand => 0);
            
               case Kartenwert.YAchse is
                  when GlobaleDatentypen.Kartenfeld'First =>
                     exit XAchseSchleife;
                  
                  when others =>
                     case Durchgang is
                        when 1 =>
                           if Karten.Karten (0, Kartenwert.YAchse, Kartenwert.XAchse).Grund = 2 or Karten.Karten (0, Kartenwert.YAchse, Kartenwert.XAchse).Grund = 31 or YAchse = 0 or XAchse = 0 then
                              null;
                              
                           elsif Karten.Karten (0, Kartenwert.YAchse, Kartenwert.XAchse).Felderwertung
                             > Karten.Karten (0, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                              GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Felderwertung then
                              EinheitImWeg := SchleifenPruefungen.KoordinatenEinheitOhneRasseSuchen (YAchse => Kartenwert.YAchse,
                                                                                                     XAchse => Kartenwert.XAchse);
                              case EinheitImWeg.Rasse is
                                 when GlobaleDatentypen.RassenMitNullwert'First =>
                                    null;
                                    
                                 when others =>
                                    exit XAchseSchleife;
                              end case;
                              
                              StadtImWeg := SchleifenPruefungen.KoordinatenStadtOhneRasseSuchen (YAchse => Kartenwert.YAchse,
                                                                                                 XAchse => Kartenwert.XAchse);
                              
                              case StadtImWeg.Rasse is
                                 when GlobaleDatentypen.RassenMitNullwert'First =>
                                    null;
                                    
                                 when others =>
                                    exit XAchseSchleife;
                              end case;

                              BewegungZiel := (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse);
                              exit Schleife;

                           else
                              null;
                           end if;
                           
                        when others =>
                           if Karten.Karten (0, Kartenwert.YAchse, Kartenwert.XAchse).Grund = 2 or Karten.Karten (0, Kartenwert.YAchse, Kartenwert.XAchse).Grund = 31 or YAchse = 0 or XAchse = 0 then
                              null;
                                 
                           else
                              EinheitImWeg := SchleifenPruefungen.KoordinatenEinheitOhneRasseSuchen (YAchse => Kartenwert.YAchse,
                                                                                                     XAchse => Kartenwert.XAchse);
                              case EinheitImWeg.Rasse is
                                 when GlobaleDatentypen.RassenMitNullwert'First =>
                                    null;
                                    
                                 when others =>
                                    exit XAchseSchleife;
                              end case;
                              
                              StadtImWeg := SchleifenPruefungen.KoordinatenStadtOhneRasseSuchen (YAchse => Kartenwert.YAchse,
                                                                                                 XAchse => Kartenwert.XAchse);
                              
                              case StadtImWeg.Rasse is
                                 when GlobaleDatentypen.RassenMitNullwert'First =>
                                    null;
                                    
                                 when others =>
                                    exit XAchseSchleife;
                              end case;
                              BewegungZiel := (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse);
                              exit Schleife;
                           end if;
                     end case;
               end case;           
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop Schleife;

      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse := BewegungZiel.YAchse;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse := BewegungZiel.XAchse;

      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := 0.00;
      
   end BewegungSiedler;



   procedure BewegungBauarbeiter (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) is
   begin
      
      null;
      
   end BewegungBauarbeiter;
   
   
   
   procedure BewegungBodenEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) is
   begin
      
      null;
      
   end BewegungBodenEinheit;
   
   
   
   procedure BewegungLuftEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) is
   begin
      
      null;
      
   end BewegungLuftEinheit;
   
   
   
   procedure BewegungWasserEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) is
   begin
      
      null;
      
   end BewegungWasserEinheit;
   
   
   
   procedure BewegungUnterwasserEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) is
   begin
      
      null;
      
   end BewegungUnterwasserEinheit;

end KIBewegung;
