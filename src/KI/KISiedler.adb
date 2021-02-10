pragma SPARK_Mode (On);

with Karten, StadtWerteFestlegen, InDerStadt, KIBewegung, KIGefahr, KIEinheitVerbessernOderVernichten;

package body KISiedler is

   procedure KISiedler (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      case GlobaleVariablen.StadtGebaut (EinheitRasseUndNummer.Rasse, 1).ID is
         when 0 =>
            StadtErfolgreichGebaut := StadtBauenPrüfung (EinheitRasseUndNummer => EinheitRasseUndNummer);

            case StadtErfolgreichGebaut is
               when True =>
                  null;

               when False =>
                  KIBewegung.KIBewegung (EinheitRasseUndNummer => EinheitRasseUndNummer,
                                         Aufgabe               => 's');
            end case;
                                                                
         when others =>
            Gefahr := KIGefahr.KIGefahr (EinheitRasseUndNummer => EinheitRasseUndNummer);
            case Gefahr is
               when True =>
                  KIBewegung.KIBewegung (EinheitRasseUndNummer => EinheitRasseUndNummer,
                                         Aufgabe               => 'f');
                  return;
                  
               when False =>
                  null;
            end case;

            UmgebungVerbessern := StadtUmgebungVerbessern (EinheitRasseUndNummer => EinheitRasseUndNummer);
            case UmgebungVerbessern is
               when True =>
                  return;
                  
               when False =>
                  null;
            end case;

            GehStadtBauen := NeueStadtBauenGehen (EinheitRasseUndNummer => EinheitRasseUndNummer);
            case GehStadtBauen is
               when True =>
                  return;
                  
               when False =>
                  null;
            end case;

            Verbessern := KIEinheitVerbessernOderVernichten.KIEinheitVerbessern (EinheitRasseUndNummer => EinheitRasseUndNummer);
            case Verbessern is
               when True =>
                  return;
                  
               when False =>
                  null;
            end case;

            Vernichten := KIEinheitVerbessernOderVernichten.KIEinheitVernichten (EinheitRasseUndNummer => EinheitRasseUndNummer);
            case Vernichten is
               when True =>
                  return;
                  
               when False =>
                  null;
            end case;
            
            KIBewegung.KIBewegung (EinheitRasseUndNummer => EinheitRasseUndNummer,
                                   Aufgabe               => 's');
            GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AktuelleBewegungspunkte := 0.00;
      end case;
      
   end KISiedler;



   function StadtUmgebungVerbessern (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean is
   begin
   
      if Karten.Karten (GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.EAchse,
                        GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.YAchse,
                        GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.XAchse).DurchStadtBelegterGrund
        >= GlobaleDatentypen.BelegterGrund (EinheitRasseUndNummer.Rasse) * StadtWerteFestlegen.RassenMulitplikationWert 
        and Karten.Karten (GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.EAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.XAchse).DurchStadtBelegterGrund
          <= GlobaleDatentypen.BelegterGrund (EinheitRasseUndNummer.Rasse) * StadtWerteFestlegen.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleVariablen.StadtGebaut'Last (2))
        and (Karten.Karten (GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.EAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.YAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.XAchse).VerbesserungStraße = 0
             or Karten.Karten (GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 0) then
         return True;
            
      else
         return False;
      end if;      
            
   end StadtUmgebungVerbessern;



   function NeueStadtBauenGehen (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean is
   begin
      
      return False;
      
   end NeueStadtBauenGehen;



   function StadtBauenPrüfung (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean is
   begin
      
      if Karten.Karten (GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.EAchse,
                        GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.YAchse,
                        GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.XAchse).Felderwertung >= 90
        and Karten.Karten (GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.EAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.XAchse).DurchStadtBelegterGrund = 0 then
         return InDerStadt.StadtBauen (EinheitRasseUndNummer => EinheitRasseUndNummer);

      else
         return False;
      end if;
   
   end StadtBauenPrüfung;

end KISiedler;
