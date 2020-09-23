package body Kampfsystem is

   function KampfsystemNahkampf (GegnerStadtnummer, RasseAngriff, EinheitenPositionAngriff, RasseVerteidigung, EinheitenPositionVerteidigung : in Integer) return Boolean is
   begin

      VerteidigungBonusDurchStadt := 1.00;

      case GegnerStadtnummer is
         when -1_000_000 | 0 =>
            Ergebnis := Kampf (RasseAngriff                  => RasseAngriff,
                               EinheitenPositionAngriff      => EinheitenPositionAngriff,
                               RasseVerteidigung             => RasseVerteidigung,
                               EinheitenPositionVerteidigung => EinheitenPositionVerteidigung,
                               VerteidigungBonus             => VerteidigungBonusDurchStadt);
            return Ergebnis;
            
         when others =>
            if GlobaleVariablen.StadtGebaut (RasseVerteidigung, GegnerStadtnummer).GebäudeVorhanden (15) /= '0' then
               VerteidigungBonusDurchStadt := 2.00;
               
            elsif GlobaleVariablen.StadtGebaut (RasseVerteidigung, GegnerStadtnummer).GebäudeVorhanden (5) /= '0' then
               VerteidigungBonusDurchStadt := 1.50;

            else               
               VerteidigungBonusDurchStadt := 1.25;
            end if;

            Ergebnis := Kampf (RasseAngriff                  => RasseAngriff,
                               EinheitenPositionAngriff      => EinheitenPositionAngriff,
                               RasseVerteidigung             => RasseVerteidigung,
                               EinheitenPositionVerteidigung => EinheitenPositionVerteidigung,
                               VerteidigungBonus             => VerteidigungBonusDurchStadt);
            return Ergebnis;
      end case;      
      
   end KampfsystemNahkampf;



   function Kampf (RasseAngriff, EinheitenPositionAngriff, RasseVerteidigung, EinheitenPositionVerteidigung : in Integer; VerteidigungBonus : in Float) return Boolean is
   begin

      VerteidigungVerteidigungWert := Float (EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).ID).Verteidigung)
        + Float (KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).YAchse,
                                                             GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).XAchse).Grund).Verteidigungsbonus)
        + Float (VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).YAchse,
                                                           GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).XAchse).VerbesserungGebiet).Verteidigungsbonus);

      if Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).YAchse, GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).XAchse).Hügel = True
        and Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).YAchse, GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).XAchse).Grund /= 6 then
         VerteidigungVerteidigungWert := Float (KartenDatenbank.KartenObjektListe (6).Verteidigungsbonus);

      else
         null;
      end if;
      
      VerteidigungVerteidigungWert := VerteidigungVerteidigungWert * VerteidigungBonus * VerteidigerBonus;

      VerteidigungAngriffWert := Float (EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).ID).Verteidigung)
        + Float (KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).YAchse,
                 GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).XAchse).Grund).Verteidigungsbonus)
        + Float (VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).YAchse,
                 GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).XAchse).VerbesserungGebiet).Verteidigungsbonus);
      
      KampfSchleife:
      loop

         -- if 
         
         if GlobaleVariablen.EinheitenGebaut (RasseAngriff, EinheitenPositionAngriff).AktuelleLebenspunkte <= 0 then
            EinheitenDatenbank.EinheitEntfernen (Rasse         => RasseAngriff,
                                                 EinheitNummer => EinheitenPositionAngriff);
            return True;
            
         elsif GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).AktuelleLebenspunkte <= 0 then
            EinheitenDatenbank.EinheitEntfernen (Rasse         => RasseVerteidigung,
                                                 EinheitNummer => EinheitenPositionVerteidigung);
            return False;
            
         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampf;

end Kampfsystem;
