pragma SPARK_Mode (On);

with KartenDatenbank, VerbesserungenDatenbank, EinheitenDatenbank, Karten, EinheitSuchen;

package body Kampfsystem is

   function KampfsystemNahkampf (RasseAngriff, RasseVerteidigung : in GlobaleDatentypen.Rassen; GegnerStadtNummer, EinheitenNummerAngriff, EinheitenNummerVerteidigung : in Integer) return Boolean is
   begin

      VerteidigungBonusDurchStadt := 1.00;

      case GegnerStadtNummer is
         when EinheitSuchen.RückgabeWert | 0 =>
            Ergebnis := Kampf (VerteidigerRasseUndEinheitNummer => (RasseVerteidigung, EinheitenNummerVerteidigung),
                               AngreiferRasseUndEinheitNummer   => (RasseAngriff, EinheitenNummerAngriff),
                               VerteidigungBonus                => VerteidigungBonusDurchStadt);
            return Ergebnis;
            
         when others =>
            if GlobaleVariablen.StadtGebaut (RasseVerteidigung, GegnerStadtNummer).GebäudeVorhanden (15) = True then
               VerteidigungBonusDurchStadt := 2.00;
               
            elsif GlobaleVariablen.StadtGebaut (RasseVerteidigung, GegnerStadtNummer).GebäudeVorhanden (5) = True then
               VerteidigungBonusDurchStadt := 1.50;

            else               
               VerteidigungBonusDurchStadt := 1.25;
            end if;

            Ergebnis := Kampf (VerteidigerRasseUndEinheitNummer => (RasseVerteidigung, EinheitenNummerVerteidigung),
                               AngreiferRasseUndEinheitNummer   => (RasseAngriff, EinheitenNummerAngriff),
                               VerteidigungBonus                => VerteidigungBonusDurchStadt);
            return Ergebnis;
      end case;      
      
   end KampfsystemNahkampf;



   function Kampf (VerteidigerRasseUndEinheitNummer, AngreiferRasseUndEinheitNummer : in GlobaleRecords.RassePlatznummerRecord; VerteidigungBonus : in Float) return Boolean is
   begin

      AngriffAngriffWert := Float (EinheitenDatenbank.EinheitenListe (AngreiferRasseUndEinheitNummer.Rasse,
                                   GlobaleVariablen.EinheitenGebaut (AngreiferRasseUndEinheitNummer.Rasse, AngreiferRasseUndEinheitNummer.Platznummer).ID).Angriff);
      AngriffVerteidigungWert := Float (EinheitenDatenbank.EinheitenListe (VerteidigerRasseUndEinheitNummer.Rasse,
                                        GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).ID).Angriff);

      VerteidigungVerteidigungWert := Float (EinheitenDatenbank.EinheitenListe (VerteidigerRasseUndEinheitNummer.Rasse,
                                             GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).ID).Verteidigung)
        + Float (KartenDatenbank.KartenListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.XAchse).Grund).Verteidigungsbonus)
        + Float (VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet).Verteidigungsbonus);

      if Karten.Karten (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.EAchse,
                        GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.YAchse,
                        GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.XAchse).Hügel = True
        and Karten.Karten (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.EAchse,
                           GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.XAchse).Grund /= 6 then
         VerteidigungVerteidigungWert := Float (KartenDatenbank.KartenListe (6).Verteidigungsbonus);

      else
         null;
      end if;
      
      VerteidigungVerteidigungWert := VerteidigungVerteidigungWert * VerteidigungBonus * VerteidigerBonus;

      VerteidigungAngriffWert := Float (EinheitenDatenbank.EinheitenListe (VerteidigerRasseUndEinheitNummer.Rasse,
                                        GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).ID).Verteidigung)
        + Float (KartenDatenbank.KartenListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.XAchse).Grund).Verteidigungsbonus)
        + Float (VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet).Verteidigungsbonus);

      Reset (Gewählt);
      
      KampfSchleife:
      loop

         KampfBerechnung (VerteidigerRasseUndEinheitNummer => VerteidigerRasseUndEinheitNummer,
                          AngriffWert                      => AngriffAngriffWert,
                          VerteidigungWert                 => VerteidigungVerteidigungWert);

         if GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AktuelleLebenspunkte <= 0 then
            EinheitenDatenbank.EinheitEntfernenMitSortieren (EinheitRasseNummer => VerteidigerRasseUndEinheitNummer);
            return True;
            
         else
            null;
         end if;
         
         KampfBerechnung (VerteidigerRasseUndEinheitNummer => VerteidigerRasseUndEinheitNummer,
                          AngriffWert                      => AngriffVerteidigungWert,
                          VerteidigungWert                 => VerteidigungAngriffWert);
            
         
         
         if GlobaleVariablen.EinheitenGebaut (AngreiferRasseUndEinheitNummer.Rasse, AngreiferRasseUndEinheitNummer.Platznummer).AktuelleLebenspunkte <= 0 then
            EinheitenDatenbank.EinheitEntfernenMitSortieren (EinheitRasseNummer => AngreiferRasseUndEinheitNummer);
            return False;

         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampf;



   procedure KampfBerechnung (VerteidigerRasseUndEinheitNummer : in GlobaleRecords.RassePlatznummerRecord; AngriffWert, VerteidigungWert : in Float) is
   begin

      Wert := Random (Gewählt);
      
      if AngriffWert > 2.00 * VerteidigungWert and Wert > 0.15 then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AktuelleLebenspunkte - 1;

      elsif AngriffWert > VerteidigungWert and Wert > 0.35 then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AktuelleLebenspunkte - 1;

      elsif AngriffWert = VerteidigungWert and Wert > 0.50 then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AktuelleLebenspunkte - 1;

      elsif AngriffWert < VerteidigungWert and 2.00 * AngriffWert > VerteidigungWert and Wert > 0.80 then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AktuelleLebenspunkte - 1;

      elsif 2.00 * AngriffWert < VerteidigungWert and Wert > 0.95 then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseUndEinheitNummer.Rasse, VerteidigerRasseUndEinheitNummer.Platznummer).AktuelleLebenspunkte - 1;

      else
         null;
      end if;
      
   end KampfBerechnung;



   function Prüfen return Boolean is
   begin
      
      return True;
      
   end Prüfen;

end Kampfsystem;
