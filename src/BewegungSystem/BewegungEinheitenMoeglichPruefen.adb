pragma SPARK_Mode (On);

with EinheitenDatenbank, EinheitSuchen, StadtSuchen, KartenDatenbank;

package body BewegungEinheitenMoeglichPruefen is

   function FeldFürDieseEinheitPassierbar (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord; NeuePosition : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Boolean is
   begin

      PassierbarkeitNummer := KartenDatenbank.KartenListe (Karten.Karten (NeuePosition.EAchse, NeuePosition.YAchse, NeuePosition.XAchse).Grund).Passierbarkeit;
      
      if EinheitenDatenbank.EinheitenListe (EinheitRasseNummer.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).ID).Passierbarkeit (PassierbarkeitNummer) = True then
         return True;
         
      else
         null;
      end if;
               
      -- if EinheitenDatenbank.EinheitenListe (EinheitRasseNummer.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).ID).Passierbarkeit
        -- /= KartenDatenbank.KartenListe (Karten.Karten (NeuePosition.EAchse, NeuePosition.YAchse, NeuePosition.XAchse).Grund).Passierbarkeit then
         case EinheitenDatenbank.EinheitenListe (EinheitRasseNummer.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).ID).Passierbarkeit (2) is
            when True =>
               Stadtnummer := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern  => EinheitRasseNummer.Rasse,
                                                                          Koordinaten  => NeuePosition);
         
               case Stadtnummer is
                  when 0 =>
                     return False;
               
                  when others =>
                     null;
               end case;
                     
            when False =>
               return False;
         end case;

      return True;
      
   end FeldFürDieseEinheitPassierbar;
   
   
   
   function BefindetSichDortEineEinheit (RasseExtern : GlobaleDatentypen.RassenMitNullwert; NeuePosition : in GlobaleRecords.AchsenKartenfeldPositivRecord) return GlobaleRecords.RassePlatznummerRecord is
   begin

      GegnerEinheitWert := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (Koordinaten => NeuePosition);

      if GegnerEinheitWert.Rasse = RasseExtern then
         return (GegnerEinheitWert.Rasse, 1);

      elsif GegnerEinheitWert.Rasse = GlobaleDatentypen.RassenMitNullwert'First then
         null;
                  
      else
         return GegnerEinheitWert;
      end if;

      GegnerStadtWert := StadtSuchen.KoordinatenStadtOhneRasseSuchen (Koordinaten => NeuePosition);

      if GegnerStadtWert.Rasse = RasseExtern then
         return (GegnerStadtWert.Rasse, 0);
         
      else
         return GegnerStadtWert;
      end if;
      
   end BefindetSichDortEineEinheit;

end BewegungEinheitenMoeglichPruefen;
