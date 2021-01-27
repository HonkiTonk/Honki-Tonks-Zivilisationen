package body KIBewegung is

   procedure KIBewegung (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive; Aufgabe : Wide_Wide_Character) is
   begin

      -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft
      -- f = Flucht, s = Stadt bauen, e = Erkunden, a = Angreifen
      case Aufgabe is
         when 'f' =>
            null;

         when 's' =>
            null;

         when 'e' =>
            null;
            
         when 'a' =>
            null;
            
         when others =>
            null;
      end case;
      
      BewegungSiedler (RasseExtern   => RasseExtern,
                       EinheitNummer => EinheitNummer);
      
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
                              ImWeg := ZeugImWeg (EAchse => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse,
                                                  YAchse => Kartenwert.YAchse,
                                                  XAchse => Kartenwert.XAchse);
                                                            
                              case ImWeg is
                                 when False =>
                                    AltePosition := IstDasEineAltePosition (RasseExtern   => RasseExtern,
                                                                            EinheitNummer => EinheitNummer,
                                                                            EAchse        => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse,
                                                                            YAchse        => Kartenwert.YAchse,
                                                                            XAchse        => Kartenwert.XAchse);
                                    
                                    case AltePosition is
                                       when True =>
                                          null;
                                          
                                       when False =>
                                          BewegungDurchführen (RasseExtern   => RasseExtern,
                                                               EinheitNummer => EinheitNummer,
                                                               EAchse        => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse,
                                                               YAchse        => Kartenwert.YAchse,
                                                               XAchse        => Kartenwert.XAchse);                                          
                                          exit Schleife;
                                    end case;
                                    
                                 when True =>
                                    null;
                              end case;
                           
                           else
                              null;
                           end if;
                           
                        when others =>
                           if Karten.Karten (0, Kartenwert.YAchse, Kartenwert.XAchse).Grund = 2 or Karten.Karten (0, Kartenwert.YAchse, Kartenwert.XAchse).Grund = 31 or YAchse = 0 or XAchse = 0 then
                              null;
                                 
                           else
                              ImWeg := ZeugImWeg (EAchse => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse,
                                                  YAchse => Kartenwert.YAchse,
                                                  XAchse => Kartenwert.XAchse);
                              case ImWeg is
                                 when False =>
                                    AltePosition := IstDasEineAltePosition (RasseExtern   => RasseExtern,
                                                                            EinheitNummer => EinheitNummer,
                                                                            EAchse        => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse,
                                                                            YAchse        => Kartenwert.YAchse,
                                                                            XAchse        => Kartenwert.XAchse);
                                    
                                    case AltePosition is
                                       when True =>
                                          null;
                                          
                                       when False =>
                                          BewegungDurchführen (RasseExtern   => RasseExtern,
                                                                EinheitNummer => EinheitNummer,
                                                                EAchse        => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse,
                                                                YAchse        => Kartenwert.YAchse,
                                                                XAchse        => Kartenwert.XAchse);                                          
                                          exit Schleife;
                                    end case;
                                    
                                 when True =>
                                    null;
                              end case;
                           end if;
                     end case;
               end case;           
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop Schleife;
      
   end BewegungSiedler;



   function ZeugImWeg (EAchse : in GlobaleDatentypen.Ebene; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean is
   begin
      
      EinheitImWeg := SchleifenPruefungen.KoordinatenEinheitOhneRasseSuchen (YAchse => YAchse,
                                                                             XAchse => XAchse);
      case EinheitImWeg.Rasse is
         when GlobaleDatentypen.RassenMitNullwert'First =>
            null;
                                    
         when others =>
            return True;
      end case;

      StadtImWeg := SchleifenPruefungen.KoordinatenStadtOhneRasseSuchen (YAchse => YAchse,
                                                                         XAchse => XAchse);
      case StadtImWeg.Rasse is
         when GlobaleDatentypen.RassenMitNullwert'First =>
            null;
                                    
         when others =>
            return True;
      end case;
      
      return False;
      
   end ZeugImWeg;



   function IstDasEineAltePosition (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; EAchse : in GlobaleDatentypen.Ebene; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean is
   begin
      
      for AltePositionen in KIVariablen.LetzteBewegungen'Range (3) loop
         
         if KIVariablen.LetzteBewegungen (RasseExtern, EinheitNummer, AltePositionen) = (EAchse, YAchse, XAchse) then
            return True;
            
         else
            null;
         end if;
         
      end loop;
      
      return False;
      
   end IstDasEineAltePosition;



   procedure BewegungDurchführen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; EAchse : in GlobaleDatentypen.Ebene; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      KIVariablen.LetzteBewegungen (RasseExtern, EinheitNummer, 3) := KIVariablen.LetzteBewegungen (RasseExtern, EinheitNummer, 2);
      KIVariablen.LetzteBewegungen (RasseExtern, EinheitNummer, 2) := KIVariablen.LetzteBewegungen (RasseExtern, EinheitNummer, 1);
      KIVariablen.LetzteBewegungen (RasseExtern, EinheitNummer, 1) := (EAchse, YAchse, XAchse);
      
      BewegungZiel := (EAchse, YAchse, XAchse);

      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse := BewegungZiel.EAchse;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse := BewegungZiel.YAchse;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse := BewegungZiel.XAchse;

      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := 0.00;
      
      
   end BewegungDurchführen;



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
