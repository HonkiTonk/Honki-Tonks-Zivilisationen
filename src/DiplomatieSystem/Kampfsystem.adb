pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartenDatenbank, VerbesserungenDatenbank, EinheitenDatenbank, Karten;

package body Kampfsystem is

   function KampfsystemNahkampf (RasseAngriff, RasseVerteidigung : in GlobaleDatentypen.Rassen; GegnerStadtNummer, EinheitenNummerAngriff, EinheitenNummerVerteidigung : in Integer) return Boolean is
   begin

      VerteidigungBonusDurchStadt := 1.00;

      case GegnerStadtNummer is
         when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
            Ergebnis := Kampf (VerteidigerRasseEinheitNummer => (RasseVerteidigung, EinheitenNummerVerteidigung),
                               AngreiferRasseEinheitNummer   => (RasseAngriff, EinheitenNummerAngriff),
                               VerteidigungBonus             => VerteidigungBonusDurchStadt);
            return Ergebnis;
            
         when others =>
            if GlobaleVariablen.StadtGebaut (RasseVerteidigung, GegnerStadtNummer).GebäudeVorhanden (15) = True then
               VerteidigungBonusDurchStadt := 2.00;
               
            elsif GlobaleVariablen.StadtGebaut (RasseVerteidigung, GegnerStadtNummer).GebäudeVorhanden (5) = True then
               VerteidigungBonusDurchStadt := 1.50;

            else               
               VerteidigungBonusDurchStadt := 1.25;
            end if;

            Ergebnis := Kampf (VerteidigerRasseEinheitNummer => (RasseVerteidigung, EinheitenNummerVerteidigung),
                               AngreiferRasseEinheitNummer   => (RasseAngriff, EinheitenNummerAngriff),
                               VerteidigungBonus             => VerteidigungBonusDurchStadt);
            return Ergebnis;
      end case;      
      
   end KampfsystemNahkampf;



   function Kampf (VerteidigerRasseEinheitNummer, AngreiferRasseEinheitNummer : in GlobaleRecords.RassePlatznummerRecord; VerteidigungBonus : in Float) return Boolean is
   begin

      AngriffAngriffWert := Float (EinheitenDatenbank.EinheitenListe (AngreiferRasseEinheitNummer.Rasse,
                                   GlobaleVariablen.EinheitenGebaut (AngreiferRasseEinheitNummer.Rasse, AngreiferRasseEinheitNummer.Platznummer).ID).Angriff);
      AngriffVerteidigungWert := Float (EinheitenDatenbank.EinheitenListe (VerteidigerRasseEinheitNummer.Rasse,
                                        GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).ID).Angriff);

      VerteidigungVerteidigungWert := Float (EinheitenDatenbank.EinheitenListe (VerteidigerRasseEinheitNummer.Rasse,
                                             GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).ID).Verteidigung)
        + Float (KartenDatenbank.KartenListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.XAchse).Grund).Verteidigungsbonus)
        + Float (VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet).Verteidigungsbonus);

      if Karten.Karten (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.EAchse,
                        GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.YAchse,
                        GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.XAchse).Hügel = True
        and Karten.Karten (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.EAchse,
                           GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.XAchse).Grund /= 6 then
         VerteidigungVerteidigungWert := Float (KartenDatenbank.KartenListe (6).Verteidigungsbonus);

      else
         null;
      end if;
      
      VerteidigungVerteidigungWert := VerteidigungVerteidigungWert * VerteidigungBonus * VerteidigerBonus;

      VerteidigungAngriffWert := Float (EinheitenDatenbank.EinheitenListe (VerteidigerRasseEinheitNummer.Rasse,
                                        GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).ID).Verteidigung)
        + Float (KartenDatenbank.KartenListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.XAchse).Grund).Verteidigungsbonus)
        + Float (VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet).Verteidigungsbonus);

      Reset (Gewählt);
      
      KampfSchleife:
      loop

         KampfBerechnung (VerteidigerRasseEinheitNummer => VerteidigerRasseEinheitNummer,
                          AngriffWert                   => AngriffAngriffWert,
                          VerteidigungWert              => VerteidigungVerteidigungWert);

         if GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AktuelleLebenspunkte <= 0 then
            EinheitenDatenbank.EinheitEntfernenMitSortieren (EinheitRasseNummer => VerteidigerRasseEinheitNummer);
            return True;
            
         else
            null;
         end if;
         
         KampfBerechnung (VerteidigerRasseEinheitNummer => VerteidigerRasseEinheitNummer,
                          AngriffWert                   => AngriffVerteidigungWert,
                          VerteidigungWert              => VerteidigungAngriffWert);
            
         
         
         if GlobaleVariablen.EinheitenGebaut (AngreiferRasseEinheitNummer.Rasse, AngreiferRasseEinheitNummer.Platznummer).AktuelleLebenspunkte <= 0 then
            EinheitenDatenbank.EinheitEntfernenMitSortieren (EinheitRasseNummer => AngreiferRasseEinheitNummer);
            return False;

         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampf;



   procedure KampfBerechnung (VerteidigerRasseEinheitNummer : in GlobaleRecords.RassePlatznummerRecord; AngriffWert, VerteidigungWert : in Float) is
   begin

      Wert := Random (Gewählt);
      
      if AngriffWert > 2.00 * VerteidigungWert and Wert > 0.15 then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AktuelleLebenspunkte - 1;

      elsif AngriffWert > VerteidigungWert and Wert > 0.35 then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AktuelleLebenspunkte - 1;

      elsif AngriffWert = VerteidigungWert and Wert > 0.50 then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AktuelleLebenspunkte - 1;

      elsif AngriffWert < VerteidigungWert and 2.00 * AngriffWert > VerteidigungWert and Wert > 0.80 then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AktuelleLebenspunkte - 1;

      elsif 2.00 * AngriffWert < VerteidigungWert and Wert > 0.95 then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummer.Rasse, VerteidigerRasseEinheitNummer.Platznummer).AktuelleLebenspunkte - 1;

      else
         null;
      end if;
      
   end KampfBerechnung;



   function Prüfen return Boolean is
   begin
      
      return True;
      
   end Prüfen;

end Kampfsystem;
