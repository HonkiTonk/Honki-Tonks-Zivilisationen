pragma SPARK_Mode (On);

with KIDatentypen;

with Karten, StadtWerteFestlegen, StadtBauen, KIBewegung, KIGefahr, KIEinheitVerbessernOderVernichten;

package body KISiedler is

   procedure KISiedler (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      case GlobaleVariablen.StadtGebaut (EinheitRasseNummer.Rasse, 1).ID is
         when 0 =>
            StadtErfolgreichGebaut := StadtBauenPrüfung (EinheitRasseNummer => EinheitRasseNummer);

            case StadtErfolgreichGebaut is
               when True =>
                  return;

               when False =>
                  null;
            end case;
                                                                
         when others =>
            null;
      end case;

      Gefahr := KIGefahr.KIGefahr (EinheitRasseNummer => EinheitRasseNummer);
      case Gefahr is
         when True =>
            KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                                   Aufgabe            => KIDatentypen.Flucht);
            return;
                  
         when False =>
            null;
      end case;

      UmgebungVerbessern := StadtUmgebungVerbessern (EinheitRasseNummer => EinheitRasseNummer);
      case UmgebungVerbessern is
         when True =>
            return;
                  
         when False =>
            null;
      end case;

      GehStadtBauen := NeueStadtBauenGehen (EinheitRasseNummer => EinheitRasseNummer);
      case GehStadtBauen is
         when True =>
            return;
                  
         when False =>
            null;
      end case;

      Verbessern := KIEinheitVerbessernOderVernichten.KIEinheitVerbessern (EinheitRasseNummer => EinheitRasseNummer);
      case Verbessern is
         when True =>
            return;
                  
         when False =>
            null;
      end case;

      Vernichten := KIEinheitVerbessernOderVernichten.KIEinheitVernichten (EinheitRasseNummer => EinheitRasseNummer);
      case Vernichten is
         when True =>
            return;
                  
         when False =>
            null;
      end case;
            
      KIBewegung.KIBewegung (EinheitRasseNummer => EinheitRasseNummer,
                             Aufgabe            => KIDatentypen.Stadt_Bauen);
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AktuelleBewegungspunkte := 0.00;
      
   end KISiedler;



   function StadtUmgebungVerbessern (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
   
      if Karten.Karten (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.EAchse,
                        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.YAchse,
                        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.XAchse).DurchStadtBelegterGrund
      in GlobaleDatentypen.BelegterGrund (EinheitRasseNummer.Rasse) * StadtWerteFestlegen.RassenMulitplikationWert .. GlobaleDatentypen.BelegterGrund (EinheitRasseNummer.Rasse)
        * StadtWerteFestlegen.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleVariablen.StadtGebaut'Last (2))
        and (Karten.Karten (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.EAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.YAchse,
                            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.XAchse).VerbesserungStraße = 0
             or Karten.Karten (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 0) then
         return True;
            
      else
         return False;
      end if;      
            
   end StadtUmgebungVerbessern;
   


   function NeueStadtBauenGehen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      return False;
      
   end NeueStadtBauenGehen;



   function StadtBauenPrüfung (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      if Karten.Karten (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.EAchse,
                        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.YAchse,
                        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.XAchse).Felderwertung >= 90 then
         return StadtBauen.StadtBauen (EinheitRasseNummer => EinheitRasseNummer);

      else
         return False;
      end if;
   
   end StadtBauenPrüfung;

end KISiedler;
