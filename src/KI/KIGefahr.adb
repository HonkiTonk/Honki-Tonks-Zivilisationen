pragma SPARK_Mode (On);

with KIVariablen;

with EinheitenDatenbank, KIPruefungen, KartenPruefungen, EinheitSuchen;

package body KIGefahr is

   -- Aufteilen nach Unbewaffnet, Fernkämpfer und Nahkämpfer?
   function KIGefahr (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      KIVariablen.FeindlicheEinheiten := (others => (others => (others => (others => 0))));
      BestehtGefahr := False;
      EinheitTyp := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).EinheitTyp;

      case
        EinheitTyp
      is
         when 1 .. 2 =>
            return Unbewaffnet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 3 | 5 | 7 | 9 | 11 =>
            return Nahkämpfer (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when 4 | 6 | 8 | 10 | 12 =>
            return Fernkämpfer (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end KIGefahr;



   function Unbewaffnet (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
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
              YÄnderungSchleifenwert = 0
              and
                XÄnderungSchleifenwert = 0
            then
               null;
                     
            else
               EinheitRassePlatznummer := EinheitSuchen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                                    KoordinatenExtern => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));

               case
                 EinheitRassePlatznummer.Rasse
               is
                  when GlobaleDatentypen.RassenMitNullwert'First =>
                     null;
                           
                  when others =>
                     if
                       GlobaleVariablen.Diplomatie (EinheitRasseNummerExtern.Rasse, EinheitRassePlatznummer.Rasse) = GlobaleVariablen.Krieg
                     then
                        KIVariablen.FeindlicheEinheiten (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer, YÄnderungSchleifenwert, XÄnderungSchleifenwert)
                          := GlobaleVariablen.EinheitenGebaut (EinheitRassePlatznummer.Rasse, EinheitRassePlatznummer.Platznummer).ID;
                        BestehtGefahr := True;

                     elsif
                       GlobaleVariablen.Diplomatie (EinheitRasseNummerExtern.Rasse, EinheitRassePlatznummer.Rasse) = GlobaleVariablen.Neutral
                       and
                         KIPruefungen.EinheitenAbstandBerechnen (EinheitEinsRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 EinheitZweiRasseNummerExtern => EinheitRassePlatznummer) <= 1
                     then
                        KIVariablen.FeindlicheEinheiten (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer, YÄnderungSchleifenwert, XÄnderungSchleifenwert)
                          := GlobaleVariablen.EinheitenGebaut (EinheitRassePlatznummer.Rasse, EinheitRassePlatznummer.Platznummer).ID;
                        BestehtGefahr := True;
                              
                     else
                        null;
                     end if;
               end case;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      case
        BestehtGefahr
      is
         when True =>
            KIPruefungen.ZielBerechnenGefahr (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return True;
            
         when False =>
            return False;
      end case;
      
   end Unbewaffnet;
   
   
   
   function Nahkämpfer (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
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
              YÄnderungSchleifenwert = 0
              and
                XÄnderungSchleifenwert = 0
            then
               null;
                     
            else
               EinheitRassePlatznummer := EinheitSuchen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                                    KoordinatenExtern => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));

               case
                 EinheitRassePlatznummer.Rasse
               is
                  when GlobaleDatentypen.RassenMitNullwert'First =>
                     null;
                           
                  when others =>
                     if
                       GlobaleVariablen.Diplomatie (EinheitRasseNummerExtern.Rasse, EinheitRassePlatznummer.Rasse) = GlobaleVariablen.Krieg
                     then
                        return True;

                     elsif
                       GlobaleVariablen.Diplomatie (EinheitRasseNummerExtern.Rasse, EinheitRassePlatznummer.Rasse) = GlobaleVariablen.Neutral
                       and
                         KIPruefungen.EinheitenAbstandBerechnen (EinheitEinsRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 EinheitZweiRasseNummerExtern => EinheitRassePlatznummer) <= 1
                     then
                        return True;
                              
                     else
                        null;
                     end if;
               end case;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      return False;
      
   end Nahkämpfer;
   
   
   
   function Fernkämpfer (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
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
              YÄnderungSchleifenwert = 0
              and
                XÄnderungSchleifenwert = 0
            then
               null;
                     
            else
               EinheitRassePlatznummer := EinheitSuchen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                                    KoordinatenExtern => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));

               case
                 EinheitRassePlatznummer.Rasse
               is
                  when GlobaleDatentypen.RassenMitNullwert'First =>
                     null;
                           
                  when others =>
                     if
                       GlobaleVariablen.Diplomatie (EinheitRasseNummerExtern.Rasse, EinheitRassePlatznummer.Rasse) = GlobaleVariablen.Krieg
                     then
                        return True;

                     elsif
                       GlobaleVariablen.Diplomatie (EinheitRasseNummerExtern.Rasse, EinheitRassePlatznummer.Rasse) = GlobaleVariablen.Neutral
                       and
                         KIPruefungen.EinheitenAbstandBerechnen (EinheitEinsRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 EinheitZweiRasseNummerExtern => EinheitRassePlatznummer) <= 1
                     then
                        return True;
                              
                     else
                        null;
                     end if;
               end case;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      return False;
      
   end Fernkämpfer;

end KIGefahr;
