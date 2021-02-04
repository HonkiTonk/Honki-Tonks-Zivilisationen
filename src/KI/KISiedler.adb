with Karten, StadtWerteFestlegen, InDerStadt, KIBewegung, KIGefahr, KIEinheitVerbessernOderVernichten;

package body KISiedler is

   procedure KISiedler (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) is
   begin
      
      case GlobaleVariablen.StadtGebaut (RasseExtern, 1).ID is
         when 0 =>
            if Karten.Karten (0, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                              GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Felderwertung >= 90
              and Karten.Karten (0, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                 GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).DurchStadtBelegterGrund = 0 then
               StadtErfolgreichGebaut := InDerStadt.StadtBauen (RasseExtern   => RasseExtern,
                                                                EinheitNummer => EinheitNummer);

               case StadtErfolgreichGebaut is
                  when True =>
                     null;

                  when False =>
                     KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                                            EinheitNummer => EinheitNummer,
                                            Aufgabe       => 's');
               end case;

            else
               KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                                      EinheitNummer => EinheitNummer,
                                      Aufgabe       => 's');
            end if;
                                                                
         when others =>
            Gefahr := KIGefahr.KIGefahr (RasseExtern   => RasseExtern,
                                         EinheitNummer => EinheitNummer);
            case Gefahr is
               when True =>
                  KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                                         EinheitNummer => EinheitNummer,
                                         Aufgabe       => 'f');
                  return;
                  
               when False =>
                  null;
            end case;

            UmgebungVerbessern := StadtUmgebungVerbessern (RasseExtern   => RasseExtern,
                                                           EinheitNummer => EinheitNummer);
            case UmgebungVerbessern is
               when True =>
                  return;
                  
               when False =>
                  null;
            end case;

            GehStadtBauen := NeueStadtBauenGehen (RasseExtern   => RasseExtern,
                                                  EinheitNummer => EinheitNummer);
            case GehStadtBauen is
               when True =>
                  return;
                  
               when False =>
                  null;
            end case;

            Verbessern := KIEinheitVerbessernOderVernichten.KIEinheitVerbessern (RasseExtern   => RasseExtern,
                                                                                 EinheitNummer => EinheitNummer);
            case Verbessern is
               when True =>
                  return;
                  
               when False =>
                  null;
            end case;

            Vernichten := KIEinheitVerbessernOderVernichten.KIEinheitVernichten (RasseExtern   => RasseExtern,
                                                                                 EinheitNummer => EinheitNummer);
            case Vernichten is
               when True =>
                  return;
                  
               when False =>
                  null;
            end case;
            
            GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte := 0.00;
      end case;
      
   end KISiedler;



   function StadtUmgebungVerbessern (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) return Boolean is
   begin
      
      if Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                        GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).DurchStadtBelegterGrund
        > GlobaleDatentypen.BelegterGrund (RasseExtern) * StadtWerteFestlegen.RassenMulitplikationWert 
        and Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).DurchStadtBelegterGrund
          <= GlobaleDatentypen.BelegterGrund (RasseExtern) * StadtWerteFestlegen.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleVariablen.StadtGebaut'Last (2))
        and (Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                            GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungStraße = 0
             or Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                               GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).VerbesserungGebiet = 0) then
         return True;
            
      else
         return False;
      end if;      
            
   end StadtUmgebungVerbessern;



   function NeueStadtBauenGehen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) return Boolean is
   begin
      
      return False;
      
   end NeueStadtBauenGehen;

end KISiedler;
