pragma SPARK_Mode (On);

with KIDatentypen;

with Karten, StadtWerteFestlegen, StadtBauen, KIBewegung, KIGefahr, KIEinheitVerbessernOderVernichten;

package body KISiedler is

   procedure KISiedler (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      case GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, 1).ID is
         when 0 =>
            StadtErfolgreichGebaut := StadtBauenPrüfung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

            case StadtErfolgreichGebaut is
               when True =>
                  return;

               when False =>
                  null;
            end case;
                                                                
         when others =>
            null;
      end case;

      Gefahr := KIGefahr.KIGefahr (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      case Gefahr is
         when True =>
            KIBewegung.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                   AufgabeExtern            => KIDatentypen.Flucht);
            return;
                  
         when False =>
            null;
      end case;

      UmgebungVerbessern := StadtUmgebungVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      case UmgebungVerbessern is
         when True =>
            return;
                  
         when False =>
            null;
      end case;

      GehStadtBauen := NeueStadtBauenGehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      case GehStadtBauen is
         when True =>
            return;
                  
         when False =>
            null;
      end case;

      Verbessern := KIEinheitVerbessernOderVernichten.KIEinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      case Verbessern is
         when True =>
            return;
                  
         when False =>
            null;
      end case;

      Vernichten := KIEinheitVerbessernOderVernichten.KIEinheitVernichten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      case Vernichten is
         when True =>
            return;
                  
         when False =>
            null;
      end case;
            
      KIBewegung.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             AufgabeExtern            => KIDatentypen.Stadt_Bauen);
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte := 0.00;
      
   end KISiedler;



   function StadtUmgebungVerbessern (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
   
      if Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).DurchStadtBelegterGrund
      in GlobaleDatentypen.BelegterGrund (EinheitRasseNummerExtern.Rasse) * StadtWerteFestlegen.RassenMulitplikationWert .. GlobaleDatentypen.BelegterGrund (EinheitRasseNummerExtern.Rasse)
        * StadtWerteFestlegen.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleVariablen.StadtGebaut'Last (2))
        and (Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungStraße = 0
             or Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet = 0) then
         return True;
            
      else
         return False;
      end if;      
            
   end StadtUmgebungVerbessern;
   


   function NeueStadtBauenGehen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      return False;
      
   end NeueStadtBauenGehen;



   function StadtBauenPrüfung (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      if Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Felderwertung >= 90 then
         return StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

      else
         return False;
      end if;
   
   end StadtBauenPrüfung;

end KISiedler;
