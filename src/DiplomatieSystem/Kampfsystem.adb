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

      AngriffAngriffWert := Float (EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (RasseAngriff, EinheitenPositionAngriff).ID).Angriff);
      AngriffVerteidigungWert := Float (EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).ID).Angriff);

      VerteidigungVerteidigungWert := Float (EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).ID).Verteidigung)
        + Float (KartenDatenbank.KartenObjektListe (Karten.Karten (0, GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).YAchse,
                                                             GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).XAchse).Grund).Verteidigungsbonus)
        + Float (VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (0, GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).YAchse,
                                                           GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).XAchse).VerbesserungGebiet).Verteidigungsbonus);

      if Karten.Karten (0, GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).YAchse, GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).XAchse).Hügel = True
        and Karten.Karten (0, GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).YAchse, GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).XAchse).Grund /= 6 then
         VerteidigungVerteidigungWert := Float (KartenDatenbank.KartenObjektListe (6).Verteidigungsbonus);

      else
         null;
      end if;
      
      VerteidigungVerteidigungWert := VerteidigungVerteidigungWert * VerteidigungBonus * VerteidigerBonus;

      VerteidigungAngriffWert := Float (EinheitenDatenbank.EinheitenListe (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).ID).Verteidigung)
        + Float (KartenDatenbank.KartenObjektListe (Karten.Karten (0, GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).YAchse,
                 GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).XAchse).Grund).Verteidigungsbonus)
        + Float (VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (0, GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).YAchse,
                 GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).XAchse).VerbesserungGebiet).Verteidigungsbonus);

      Reset (Gewählt);
      
      KampfSchleife:
      loop

         KampfBerechnung (RasseVerteidigung         => RasseVerteidigung,
                          EinheitNummerVerteidigung => EinheitenPositionVerteidigung,
                          AngriffWert               => AngriffAngriffWert,
                          VerteidigungWert          => VerteidigungVerteidigungWert);

         if GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).AktuelleLebenspunkte <= 0 then
            EinheitenDatenbank.EinheitEntfernen (Rasse         => RasseVerteidigung,
                                                 EinheitNummer => EinheitenPositionVerteidigung);
            return True;
            
         else
            null;
         end if;
         
         KampfBerechnung (RasseVerteidigung         => RasseAngriff,
                          EinheitNummerVerteidigung => EinheitenPositionAngriff,
                          AngriffWert               => AngriffVerteidigungWert,
                          VerteidigungWert          => VerteidigungAngriffWert);
            
         
         
         if GlobaleVariablen.EinheitenGebaut (RasseAngriff, EinheitenPositionAngriff).AktuelleLebenspunkte <= 0 then
            EinheitenDatenbank.EinheitEntfernen (Rasse         => RasseAngriff,
                                                 EinheitNummer => EinheitenPositionAngriff);
            return False;

         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampf;



   procedure KampfBerechnung  (RasseVerteidigung, EinheitNummerVerteidigung : in Integer; AngriffWert, VerteidigungWert : in Float) is
   begin

      Wert := Random (Gewählt);
      
      if AngriffWert > 2.00 * VerteidigungWert and Wert > 0.15 then
         GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitNummerVerteidigung).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitNummerVerteidigung).AktuelleLebenspunkte - 1;

      elsif AngriffWert > VerteidigungWert and Wert > 0.35 then
         GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitNummerVerteidigung).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitNummerVerteidigung).AktuelleLebenspunkte - 1;

      elsif AngriffWert = VerteidigungWert and Wert > 0.50 then
         GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitNummerVerteidigung).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitNummerVerteidigung).AktuelleLebenspunkte - 1;

      elsif AngriffWert < VerteidigungWert and 2.00 * AngriffWert > VerteidigungWert and Wert > 0.80 then
         GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitNummerVerteidigung).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitNummerVerteidigung).AktuelleLebenspunkte - 1;

      elsif 2.00 * AngriffWert < VerteidigungWert and Wert > 0.95 then
         GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitNummerVerteidigung).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitNummerVerteidigung).AktuelleLebenspunkte - 1;

      else
         null;
      end if;
      
   end KampfBerechnung;



   function Prüfen return Boolean is
   begin
      
      return True;
      
   end Prüfen;

end Kampfsystem;
