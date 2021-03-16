pragma SPARK_Mode (On);

with EinheitenDatenbank, EinheitSuchen, StadtSuchen, KartenDatenbank, GlobaleKonstanten;

package body BewegungEinheitenMoeglichPruefen is

   function FeldFürDieseEinheitPassierbar (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Boolean is
   begin

      PassierbarkeitNummer := KartenDatenbank.KartenListe (Karten.Weltkarte (NeuePositionExtern.EAchse, NeuePositionExtern.YAchse, NeuePositionExtern.XAchse).Grund).Passierbarkeit;
      
      if EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (PassierbarkeitNummer) = True then
         return True;
         
      else
         null;
      end if;
      
      case EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (2) is
         when True =>
            StadtNummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                       KoordinatenExtern => NeuePositionExtern);
         
            case StadtNummer is
               when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
                  return False;
               
               when others =>
                  return True;
            end case;
                     
         when False =>
            null;
      end case;

      case EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (1) is
         when True =>
            EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                             KoordinatenExtern => NeuePositionExtern);

            case EinheitNummer is
               when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
                  return False;
               
               when others =>
                  if EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).KannTransportiertWerden > 0
                    and EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).KannTransportiertWerden 
                      <= EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummer).ID).KannTransportieren then
                     Transportplatz := 0;
                     FreierPlatzSchleife:
                     for FreierPlatz in GlobaleRecords.TransporterArray'Range loop
                        
                        case GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitNummer).Transportiert (FreierPlatz) is
                           when 0 =>
                              Transportplatz := FreierPlatz;
                              exit FreierPlatzSchleife;
                              
                           when others =>
                              null;
                        end case;
                        
                     end loop FreierPlatzSchleife;

                     case Transportplatz is
                        when 0 =>
                           return False;
                           
                        when others =>
                           return True;
                     end case;

                  else
                     return False;
                  end if;
            end case;

         when False =>
            null;
      end case;
      
      return False;
      
   end FeldFürDieseEinheitPassierbar;
   
   
   
   function BefindetSichDortEineEinheit (RasseExtern : GlobaleDatentypen.RassenMitNullwert; NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord is
   begin

      GegnerEinheitWert := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeuePositionExtern);

      if GegnerEinheitWert.Rasse = RasseExtern then
         return (GegnerEinheitWert.Rasse, 1);

      elsif GegnerEinheitWert.Rasse = GlobaleDatentypen.RassenMitNullwert'First then
         null;
                  
      else
         return GegnerEinheitWert;
      end if;

      GegnerStadtWert := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => NeuePositionExtern);

      if GegnerStadtWert.Rasse = RasseExtern then
         return (GegnerStadtWert.Rasse, 0);
         
      else
         return GegnerStadtWert;
      end if;
      
   end BefindetSichDortEineEinheit;

end BewegungEinheitenMoeglichPruefen;
