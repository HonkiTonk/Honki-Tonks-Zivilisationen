pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartenDatenbank, VerbesserungenDatenbank, EinheitenDatenbank, Karten;

package body Kampfsystem is

   function KampfsystemNahkampf (RasseAngriffExtern, RasseVerteidigungExtern : in GlobaleDatentypen.Rassen; GegnerStadtNummerExtern : in GlobaleDatentypen.MaximaleStädteMitNullWert;
                                 EinheitenNummerAngriffExtern, EinheitenNummerVerteidigungExtern : in GlobaleDatentypen.MaximaleEinheiten) return Boolean is
   begin

      VerteidigungBonusDurchStadt := 1.00;

      case
        GegnerStadtNummerExtern
      is
         when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
            Ergebnis := Kampf (VerteidigerRasseEinheitNummerExtern => (RasseVerteidigungExtern, EinheitenNummerVerteidigungExtern),
                               AngreiferRasseEinheitNummerExtern   => (RasseAngriffExtern, EinheitenNummerAngriffExtern),
                               VerteidigungBonusExtern             => VerteidigungBonusDurchStadt);
            return Ergebnis;
            
         when others =>
            if
              GlobaleVariablen.StadtGebaut (RasseVerteidigungExtern, GegnerStadtNummerExtern).GebäudeVorhanden (15) = True
            then
               VerteidigungBonusDurchStadt := 2.00;
               
            elsif
              GlobaleVariablen.StadtGebaut (RasseVerteidigungExtern, GegnerStadtNummerExtern).GebäudeVorhanden (5) = True
            then
               VerteidigungBonusDurchStadt := 1.50;

            else               
               VerteidigungBonusDurchStadt := 1.25;
            end if;

            Ergebnis := Kampf (VerteidigerRasseEinheitNummerExtern => (RasseVerteidigungExtern, EinheitenNummerVerteidigungExtern),
                               AngreiferRasseEinheitNummerExtern   => (RasseAngriffExtern, EinheitenNummerAngriffExtern),
                               VerteidigungBonusExtern             => VerteidigungBonusDurchStadt);
            return Ergebnis;
      end case;      
      
   end KampfsystemNahkampf;



   function Kampf (VerteidigerRasseEinheitNummerExtern, AngreiferRasseEinheitNummerExtern : in GlobaleRecords.RassePlatznummerRecord; VerteidigungBonusExtern : in Float) return Boolean is
   begin

      AngriffAngriffWert := Float (EinheitenDatenbank.EinheitenListe (AngreiferRasseEinheitNummerExtern.Rasse,
                                   GlobaleVariablen.EinheitenGebaut (AngreiferRasseEinheitNummerExtern.Rasse, AngreiferRasseEinheitNummerExtern.Platznummer).ID).Angriff);
      AngriffVerteidigungWert := Float (EinheitenDatenbank.EinheitenListe (VerteidigerRasseEinheitNummerExtern.Rasse,
                                        GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).ID).Angriff);

      VerteidigungVerteidigungWert := Float (EinheitenDatenbank.EinheitenListe (VerteidigerRasseEinheitNummerExtern.Rasse,
                                             GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).ID).Verteidigung)
        + Float (KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.XAchse).Grund).Verteidigungsbonus)
        + Float (VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet).Verteidigungsbonus);

      if
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.EAchse,
                           GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.XAchse).Hügel = True
        and
          Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.EAchse,
                              GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.YAchse,
                            GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.XAchse).Grund /= 6
      then
         VerteidigungVerteidigungWert := Float (KartenDatenbank.KartenListe (6).Verteidigungsbonus);

      else
         null;
      end if;
      
      VerteidigungVerteidigungWert := VerteidigungVerteidigungWert * VerteidigungBonusExtern * VerteidigerBonus;

      VerteidigungAngriffWert := Float (EinheitenDatenbank.EinheitenListe (VerteidigerRasseEinheitNummerExtern.Rasse,
                                        GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).ID).Verteidigung)
        + Float (KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.XAchse).Grund).Verteidigungsbonus)
        + Float (VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet).Verteidigungsbonus);

      Reset (Gewählt);
      
      KampfSchleife:
      loop

         KampfBerechnung (VerteidigerRasseEinheitNummerExtern => VerteidigerRasseEinheitNummerExtern,
                          AngriffWertExtern                   => AngriffAngriffWert,
                          VerteidigungWertExtern              => VerteidigungVerteidigungWert);

         if
           GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AktuelleLebenspunkte <= 0
         then
            EinheitenDatenbank.EinheitEntfernen (EinheitRasseNummerExtern => VerteidigerRasseEinheitNummerExtern);
            return True;
            
         else
            null;
         end if;
         
         KampfBerechnung (VerteidigerRasseEinheitNummerExtern => VerteidigerRasseEinheitNummerExtern,
                          AngriffWertExtern                   => AngriffVerteidigungWert,
                          VerteidigungWertExtern              => VerteidigungAngriffWert);
            
         
         
         if
           GlobaleVariablen.EinheitenGebaut (AngreiferRasseEinheitNummerExtern.Rasse, AngreiferRasseEinheitNummerExtern.Platznummer).AktuelleLebenspunkte <= 0
         then
            EinheitenDatenbank.EinheitEntfernen (EinheitRasseNummerExtern => AngreiferRasseEinheitNummerExtern);
            return False;

         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampf;



   procedure KampfBerechnung (VerteidigerRasseEinheitNummerExtern : in GlobaleRecords.RassePlatznummerRecord; AngriffWertExtern, VerteidigungWertExtern : in Float) is
   begin

      Wert := Random (Gewählt);
      
      if
        AngriffWertExtern > 2.00 * VerteidigungWertExtern
        and
          Wert > 0.15
      then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AktuelleLebenspunkte - 1;

      elsif
        AngriffWertExtern > VerteidigungWertExtern
        and
          Wert > 0.35
      then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AktuelleLebenspunkte - 1;

      elsif
        AngriffWertExtern = VerteidigungWertExtern
        and
          Wert > 0.50
      then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AktuelleLebenspunkte - 1;

      elsif
        AngriffWertExtern < VerteidigungWertExtern
        and
          2.00 * AngriffWertExtern > VerteidigungWertExtern
          and
            Wert > 0.80
      then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AktuelleLebenspunkte - 1;

      elsif
        2.00 * AngriffWertExtern < VerteidigungWertExtern
        and
          Wert > 0.95
      then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseEinheitNummerExtern.Rasse, VerteidigerRasseEinheitNummerExtern.Platznummer).AktuelleLebenspunkte - 1;

      else
         null;
      end if;
      
   end KampfBerechnung;



   function Prüfen return Boolean is
   begin
      
      return True;
      
   end Prüfen;

end Kampfsystem;
