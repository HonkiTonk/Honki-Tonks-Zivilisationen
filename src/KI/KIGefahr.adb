pragma SPARK_Mode (On);

with EinheitenDatenbank, SchleifenPruefungen, Umwandlung, KIPruefungen, KIVariablen;

package body KIGefahr is

   -- Aufteilen nach Unbewaffnet, Fernkämpfer und Nahkämpfer?
   function KIGefahr (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      KIVariablen.FeindlicheEinheiten := (others => (others => (others => (others => 0))));
      BestehtGefahr := False;
      EinheitTyp := EinheitenDatenbank.EinheitenListe (EinheitRasseNummer.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).ID).EinheitTyp;

      case EinheitTyp is
         when 1 .. 2 =>
            return Unbewaffnet (EinheitRasseNummer => EinheitRasseNummer);
            
         when 3 | 5 | 7 | 9 | 11 =>
            return Nahkämpfer (EinheitRasseNummer => EinheitRasseNummer);
            
         when 4 | 6 | 8 | 10 | 12 =>
            return Fernkämpfer (EinheitRasseNummer => EinheitRasseNummer);
      end case;
      
   end KIGefahr;



   function Unbewaffnet (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);

            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  if YÄnderung = 0 and XÄnderung = 0 then
                     null;
                     
                  else
                     EinheitRassePlatznummer := SchleifenPruefungen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                                Koordinaten => Umwandlung.KartenfeldNachKartenfeldPositiv (Koordinaten => KartenWert));

                     case EinheitRassePlatznummer.Rasse is
                        when GlobaleDatentypen.RassenMitNullwert'First =>
                           null;
                           
                        when others =>
                           if GlobaleVariablen.Diplomatie (EinheitRasseNummer.Rasse, EinheitRassePlatznummer.Rasse) = GlobaleVariablen.Krieg then
                              KIVariablen.FeindlicheEinheiten (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer, YÄnderung, XÄnderung)
                                := GlobaleVariablen.EinheitenGebaut (EinheitRassePlatznummer.Rasse, EinheitRassePlatznummer.Platznummer).ID;
                              BestehtGefahr := True;

                           elsif GlobaleVariablen.Diplomatie (EinheitRasseNummer.Rasse, EinheitRassePlatznummer.Rasse) = GlobaleVariablen.Neutral
                             and KIPruefungen.EinheitenAbstandBerechnen (EinheitEinsRasseNummer => EinheitRasseNummer,
                                                                         EinheitZweiRasseNummer => EinheitRassePlatznummer) <= 1 then
                              KIVariablen.FeindlicheEinheiten (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer, YÄnderung, XÄnderung)
                                := GlobaleVariablen.EinheitenGebaut (EinheitRassePlatznummer.Rasse, EinheitRassePlatznummer.Platznummer).ID;
                              BestehtGefahr := True;
                              
                           else
                              null;
                           end if;
                     end case;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      case BestehtGefahr is
         when True =>
            KIPruefungen.ZielBerechnenGefahr (EinheitRasseNummer => EinheitRasseNummer);
            return True;
            
         when False =>
            return False;
      end case;
      
   end Unbewaffnet;
   
   
   
   function Nahkämpfer (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);

            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  if YÄnderung = 0 and XÄnderung = 0 then
                     null;
                     
                  else
                     EinheitRassePlatznummer := SchleifenPruefungen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                                Koordinaten => Umwandlung.KartenfeldNachKartenfeldPositiv (Koordinaten => KartenWert));

                     case EinheitRassePlatznummer.Rasse is
                        when GlobaleDatentypen.RassenMitNullwert'First =>
                           null;
                           
                        when others =>
                           if GlobaleVariablen.Diplomatie (EinheitRasseNummer.Rasse, EinheitRassePlatznummer.Rasse) = GlobaleVariablen.Krieg then
                              return True;

                           elsif GlobaleVariablen.Diplomatie (EinheitRasseNummer.Rasse, EinheitRassePlatznummer.Rasse) = GlobaleVariablen.Neutral
                             and KIPruefungen.EinheitenAbstandBerechnen (EinheitEinsRasseNummer => EinheitRasseNummer,
                                                                         EinheitZweiRasseNummer => EinheitRassePlatznummer) <= 1 then
                             return True;
                              
                           else
                              null;
                           end if;
                     end case;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      return False;
      
   end Nahkämpfer;
   
   
   
   function Fernkämpfer (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);

            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  if YÄnderung = 0 and XÄnderung = 0 then
                     null;
                     
                  else
                     EinheitRassePlatznummer := SchleifenPruefungen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern => EinheitRasseNummer.Rasse,
                                                                                                                Koordinaten => Umwandlung.KartenfeldNachKartenfeldPositiv (Koordinaten => KartenWert));

                     case EinheitRassePlatznummer.Rasse is
                        when GlobaleDatentypen.RassenMitNullwert'First =>
                           null;
                           
                        when others =>
                           if GlobaleVariablen.Diplomatie (EinheitRasseNummer.Rasse, EinheitRassePlatznummer.Rasse) = GlobaleVariablen.Krieg then
                              return True;

                           elsif GlobaleVariablen.Diplomatie (EinheitRasseNummer.Rasse, EinheitRassePlatznummer.Rasse) = GlobaleVariablen.Neutral
                             and KIPruefungen.EinheitenAbstandBerechnen (EinheitEinsRasseNummer => EinheitRasseNummer,
                                                                         EinheitZweiRasseNummer => EinheitRassePlatznummer) <= 1 then
                             return True;
                              
                           else
                              null;
                           end if;
                     end case;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      return False;
      
   end Fernkämpfer;

end KIGefahr;
