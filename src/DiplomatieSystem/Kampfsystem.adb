package body Kampfsystem is

   function KampfsystemNahkampf (RasseAngriff, RasseVerteidigung : in GlobaleDatentypen.Rassen; GegnerStadtNummer, EinheitenNummerAngriff, EinheitenNummerVerteidigung : in Integer) return Boolean is
   begin

      VerteidigungBonusDurchStadt := 1.00;

      case GegnerStadtNummer is
         when SchleifenPruefungen.RückgabeWert | 0 =>
            Ergebnis := Kampf (RasseAngriff                => RasseAngriff,
                               EinheitenNummerAngriff      => EinheitenNummerAngriff,
                               RasseVerteidigung           => RasseVerteidigung,
                               EinheitenNummerVerteidigung => EinheitenNummerVerteidigung,
                               VerteidigungBonus           => VerteidigungBonusDurchStadt);
            return Ergebnis;
            
         when others =>
            if GlobaleVariablen.StadtGebaut (RasseVerteidigung, GegnerStadtNummer).GebäudeVorhanden (15) /= '0' then
               VerteidigungBonusDurchStadt := 2.00;
               
            elsif GlobaleVariablen.StadtGebaut (RasseVerteidigung, GegnerStadtNummer).GebäudeVorhanden (5) /= '0' then
               VerteidigungBonusDurchStadt := 1.50;

            else               
               VerteidigungBonusDurchStadt := 1.25;
            end if;

            Ergebnis := Kampf (RasseAngriff                => RasseAngriff,
                               EinheitenNummerAngriff      => EinheitenNummerAngriff,
                               RasseVerteidigung           => RasseVerteidigung,
                               EinheitenNummerVerteidigung => EinheitenNummerVerteidigung,
                               VerteidigungBonus           => VerteidigungBonusDurchStadt);
            return Ergebnis;
      end case;      
      
   end KampfsystemNahkampf;



   function Kampf (RasseAngriff, RasseVerteidigung : in GlobaleDatentypen.Rassen; EinheitenNummerAngriff, EinheitenNummerVerteidigung : in Positive; VerteidigungBonus : in Float) return Boolean is
   begin

      AngriffAngriffWert := Float (EinheitenDatenbank.EinheitenListe (RasseAngriff, GlobaleVariablen.EinheitenGebaut (RasseAngriff, EinheitenNummerAngriff).ID).Angriff);
      AngriffVerteidigungWert := Float (EinheitenDatenbank.EinheitenListe (RasseVerteidigung, GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).ID).Angriff);

      VerteidigungVerteidigungWert := Float (EinheitenDatenbank.EinheitenListe (RasseVerteidigung, GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).ID).Verteidigung)
        + Float (KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.XAchse).Grund).Verteidigungsbonus)
        + Float (VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.XAchse).VerbesserungGebiet).Verteidigungsbonus);

      if Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.EAchse,
                        GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.YAchse,
                        GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.XAchse).Hügel = True
        and Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.EAchse,
                           GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.XAchse).Grund /= 6 then
         VerteidigungVerteidigungWert := Float (KartenDatenbank.KartenObjektListe (6).Verteidigungsbonus);

      else
         null;
      end if;
      
      VerteidigungVerteidigungWert := VerteidigungVerteidigungWert * VerteidigungBonus * VerteidigerBonus;

      VerteidigungAngriffWert := Float (EinheitenDatenbank.EinheitenListe (RasseVerteidigung, GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).ID).Verteidigung)
        + Float (KartenDatenbank.KartenObjektListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.XAchse).Grund).Verteidigungsbonus)
        + Float (VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AchsenPosition.XAchse).VerbesserungGebiet).Verteidigungsbonus);

      Reset (Gewählt);
      
      KampfSchleife:
      loop

         KampfBerechnung (RasseVerteidigung         => RasseVerteidigung,
                          EinheitNummerVerteidigung => EinheitenNummerVerteidigung,
                          AngriffWert               => AngriffAngriffWert,
                          VerteidigungWert          => VerteidigungVerteidigungWert);

         if GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenNummerVerteidigung).AktuelleLebenspunkte <= 0 then
            EinheitenDatenbank.EinheitEntfernenMitSortieren (RasseExtern   => RasseVerteidigung,
                                                             EinheitNummer => EinheitenNummerVerteidigung);
            return True;
            
         else
            null;
         end if;
         
         KampfBerechnung (RasseVerteidigung         => RasseAngriff,
                          EinheitNummerVerteidigung => EinheitenNummerAngriff,
                          AngriffWert               => AngriffVerteidigungWert,
                          VerteidigungWert          => VerteidigungAngriffWert);
            
         
         
         if GlobaleVariablen.EinheitenGebaut (RasseAngriff, EinheitenNummerAngriff).AktuelleLebenspunkte <= 0 then
            EinheitenDatenbank.EinheitEntfernenMitSortieren (RasseExtern   => RasseAngriff,
                                                             EinheitNummer => EinheitenNummerAngriff);
            return False;

         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampf;



   procedure KampfBerechnung  (RasseVerteidigung : in GlobaleDatentypen.Rassen; EinheitNummerVerteidigung : in Positive; AngriffWert, VerteidigungWert : in Float) is
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
