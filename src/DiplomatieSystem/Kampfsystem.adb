pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KartenDatenbank, VerbesserungenDatenbank, EinheitenDatenbank, Karten, ZufallGeneratorenKampf, StadtSuchen;

package body Kampfsystem is

   function KampfsystemNahkampf
     (AngreiferRasseNummerExtern, VerteidigerRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin

      StadtVorhanden := StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => VerteidigerRasseNummerExtern.Rasse,
                                                                    KoordinatenExtern => (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AchsenPosition));

      case
        StadtVorhanden
      is
         when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
            VerteidigungBonusDurchStadt := 1.00;
            
         when others =>
            if
              GlobaleVariablen.StadtGebaut (VerteidigerRasseNummerExtern.Rasse, StadtVorhanden).GebäudeVorhanden (15) = True
            then
               VerteidigungBonusDurchStadt := 2.00;
               
            elsif
              GlobaleVariablen.StadtGebaut (VerteidigerRasseNummerExtern.Rasse, StadtVorhanden).GebäudeVorhanden (5) = True
            then
               VerteidigungBonusDurchStadt := 1.50;

            else               
               VerteidigungBonusDurchStadt := 1.25;
            end if;
      end case;

      Ergebnis := Kampf (VerteidigerRasseNummerExtern => VerteidigerRasseNummerExtern,
                         AngreiferRasseNummerExtern   => AngreiferRasseNummerExtern,
                         VerteidigerBonusExtern       => VerteidigungBonusDurchStadt);
      
      return Ergebnis;
      
   end KampfsystemNahkampf;



   function Kampf
     (VerteidigerRasseNummerExtern, AngreiferRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      VerteidigerBonusExtern : in Float)
      return Boolean
   is begin

      AngreiferStärkeAngriff := Float (EinheitenDatenbank.EinheitenListe (AngreiferRasseNummerExtern.Rasse,
                                        GlobaleVariablen.EinheitenGebaut (AngreiferRasseNummerExtern.Rasse, AngreiferRasseNummerExtern.Platznummer).ID).Angriff);
      AngreiferStärkeVerteidigung := Float (EinheitenDatenbank.EinheitenListe (VerteidigerRasseNummerExtern.Rasse,
                                             GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).ID).Verteidigung);

      VerteidigerStärkeVerteidigung :=
        Float (EinheitenDatenbank.EinheitenListe (VerteidigerRasseNummerExtern.Rasse,
               GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).ID).Verteidigung)
        + 0.1 * Float (KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund).Verteidigungsbonus)
        + 0.1 * Float (VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                 GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AchsenPosition.XAchse).VerbesserungGebiet).Verteidigungsbonus);

      if
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Hügel = True
        and
          Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                            GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                            GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AchsenPosition.XAchse).Grund /= 6
      then
         VerteidigerStärkeVerteidigung := VerteidigerStärkeVerteidigung + 0.1 * Float (KartenDatenbank.KartenListe (6).Verteidigungsbonus);

      else
         null;
      end if;
      
      VerteidigerStärkeVerteidigung := VerteidigerStärkeVerteidigung * VerteidigerBonusExtern * VerteidigerBonus;

      VerteidigerStärkeAngriff := Float (EinheitenDatenbank.EinheitenListe (VerteidigerRasseNummerExtern.Rasse,
                                          GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).ID).Angriff);
      
      KampfSchleife:
      loop

         KampfBerechnung (VerteidigerRasseNummerExtern        => VerteidigerRasseNummerExtern,
                          AngreiferStärkeAngriffExtern        => AngreiferStärkeAngriff,
                          VerteidigerStärkeVerteidigungExtern => VerteidigerStärkeVerteidigung);

         if
           GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AktuelleLebenspunkte <= 0
         then
            EinheitenDatenbank.EinheitEntfernen (EinheitRasseNummerExtern => VerteidigerRasseNummerExtern);
            return True;
            
         else
            null;
         end if;
         
         KampfBerechnung (VerteidigerRasseNummerExtern        => AngreiferRasseNummerExtern,
                          AngreiferStärkeAngriffExtern        => VerteidigerStärkeAngriff,
                          VerteidigerStärkeVerteidigungExtern => AngreiferStärkeVerteidigung);
         
         if
           GlobaleVariablen.EinheitenGebaut (AngreiferRasseNummerExtern.Rasse, AngreiferRasseNummerExtern.Platznummer).AktuelleLebenspunkte <= 0
         then
            EinheitenDatenbank.EinheitEntfernen (EinheitRasseNummerExtern => AngreiferRasseNummerExtern);
            return False;

         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end Kampf;
   


   procedure KampfBerechnung
     (VerteidigerRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AngreiferStärkeAngriffExtern, VerteidigerStärkeVerteidigungExtern : in Float)
   is begin

      Kampfglück := ZufallGeneratorenKampf.KampfErfolg;
      
      if
        AngreiferStärkeAngriffExtern > 2.00 * VerteidigerStärkeVerteidigungExtern
        and
          Kampfglück > 0.15
      then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AktuelleLebenspunkte - 1;

      elsif
        AngreiferStärkeAngriffExtern > VerteidigerStärkeVerteidigungExtern
        and
          Kampfglück > 0.35
      then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AktuelleLebenspunkte - 1;

      elsif
        AngreiferStärkeAngriffExtern = VerteidigerStärkeVerteidigungExtern
        and
          Kampfglück > 0.50
      then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AktuelleLebenspunkte - 1;

      elsif
        AngreiferStärkeAngriffExtern < VerteidigerStärkeVerteidigungExtern
        and
          2.00 * AngreiferStärkeAngriffExtern > VerteidigerStärkeVerteidigungExtern
          and
            Kampfglück > 0.80
      then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AktuelleLebenspunkte - 1;

      elsif
        2.00 * AngreiferStärkeAngriffExtern < VerteidigerStärkeVerteidigungExtern
        and
          Kampfglück > 0.95
      then
         GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AktuelleLebenspunkte
           := GlobaleVariablen.EinheitenGebaut (VerteidigerRasseNummerExtern.Rasse, VerteidigerRasseNummerExtern.Platznummer).AktuelleLebenspunkte - 1;

      else
         null;
      end if;
      
   end KampfBerechnung;

end Kampfsystem;
