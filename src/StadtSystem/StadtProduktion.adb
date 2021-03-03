pragma SPARK_Mode (On);

with Wachstum, KartenPruefungen, Karten, VerbesserungenDatenbank, KartenDatenbank;

package body StadtProduktion is

   procedure StadtProduktionPrüfen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      case StadtRasseNummer.Rasse is
         when 0 => -- Überprüfung für alle Rassen bei Runde beenden.
            RassenSchleife:
            for RasseIntern in GlobaleVariablen.StadtGebautArray'Range (1) loop
               StadtSchleife:
               for StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2) loop
               
                  case GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).ID is
                     when 0 =>
                        exit StadtSchleife;
                  
                     when others =>
                        StadtProduktionPrüfenBerechnung (StadtRasseNummer => (RasseIntern, StadtNummer));
                  end case;
               
               end loop StadtSchleife;
            end loop RassenSchleife;
         
         when others => -- Überprüfung beim Bauen einer Stadt
            StadtProduktionPrüfenBerechnung (StadtRasseNummer => StadtRasseNummer);
            Wachstum.WachstumBeiStadtGründung (RasseExtern => StadtRasseNummer.Rasse);
      end case;
      
   end StadtProduktionPrüfen;
   


   procedure StadtProduktionPrüfenBerechnung (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleNahrungsproduktion := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleGeldgewinnung := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleForschungsrate := 0;

      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Korruption := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner / 3;

      NutzbarerBereich := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße;
      
      YAchseSchleife:
      for YÄnderung in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XÄnderung in -NutzbarerBereich .. NutzbarerBereich loop

            KartenWert := KartenPruefungen.KartenPositionBestimmen (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AchsenPosition,
                                                                    Änderung       => (0, YÄnderung, XÄnderung),
                                                                    ZusatzYAbstand => 0);

            case KartenWert.Erfolgreich is
               when False =>
                  exit XAchseSchleife;                                 
                                 
               when True =>
                  case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).UmgebungBewirtschaftung (YÄnderung, XÄnderung) is
                     when True =>
                        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleNahrungsproduktion
                          := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleNahrungsproduktion
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Nahrungsgewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Nahrungsgewinnung
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Nahrungsbonus
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Nahrungsbonus;

                        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate
                          := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Ressourcengewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Ressourcengewinnung
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Ressourcenbonus
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Ressourcenbonus;

                        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleGeldgewinnung
                          := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleGeldgewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Geldgewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Geldgewinnung
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Geldbonus
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Geldbonus;

                        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleForschungsrate
                          := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleForschungsrate
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Wissensgewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Wissensgewinnung
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Wissensbonus
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Wissensbonus;

                     when others =>
                        null;
                  end case;
            end case;
                           
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      WeitereNahrungsproduktionÄnderungen (StadtRasseNummer => StadtRasseNummer);
      WeitereProduktionrateÄnderungen (StadtRasseNummer => StadtRasseNummer);
      WeitereGeldgewinnungÄnderungen (StadtRasseNummer => StadtRasseNummer);
      WeitereForschungsrateÄnderungen (StadtRasseNummer => StadtRasseNummer);
      
   end StadtProduktionPrüfenBerechnung;
   
   
   
   procedure WeitereNahrungsproduktionÄnderungen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin

      case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner is
         when 0 .. 1 =>
            NahrungsverbrauchEinwohnerMultiplikator := 0;
            
         when 2 .. 9 =>
            NahrungsverbrauchEinwohnerMultiplikator := 1;
            
         when 10 .. 19 =>
            NahrungsverbrauchEinwohnerMultiplikator := 2;
            
         when others =>
            NahrungsverbrauchEinwohnerMultiplikator := 3;
      end case;
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleNahrungsproduktion :=
        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleNahrungsproduktion
        - GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner * NahrungsverbrauchEinwohnerMultiplikator;
      
   end WeitereNahrungsproduktionÄnderungen;



   procedure WeitereProduktionrateÄnderungen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Korruption is
         when 0 =>
            RessourcenverbrauchKorruptionMultiplikator := 0;
            
         when 1 .. 3 =>
            RessourcenverbrauchKorruptionMultiplikator := 1;
            
         when 4 .. 6 =>
            RessourcenverbrauchKorruptionMultiplikator := 2;
            
         when 7 .. 9 =>
            RessourcenverbrauchKorruptionMultiplikator := 5;
            
         when others =>
            RessourcenverbrauchKorruptionMultiplikator := 10;
      end case;
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate :=
        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate
        - GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner * RessourcenverbrauchKorruptionMultiplikator;

      if GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate < 0 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate := 0;
         
      else
         null;
      end if;
      
   end WeitereProduktionrateÄnderungen;



   procedure WeitereGeldgewinnungÄnderungen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin

      case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Korruption is
         when 0 =>
            GeldverbrauchKorruptionMultiplikator := 0;
            
         when 1 .. 3 =>
            GeldverbrauchKorruptionMultiplikator := 1;
            
         when 4 .. 6 =>
            GeldverbrauchKorruptionMultiplikator := 2;
            
         when 7 .. 9 =>
            GeldverbrauchKorruptionMultiplikator := 5;
            
         when others =>
            GeldverbrauchKorruptionMultiplikator := 10;
      end case;
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleGeldgewinnung :=
        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleGeldgewinnung
        - GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner * GeldverbrauchKorruptionMultiplikator;
      
   end WeitereGeldgewinnungÄnderungen;



   procedure WeitereForschungsrateÄnderungen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin

      case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Korruption is
         when 0 =>
            ForschungsverbrauchKorruptionMultiplikator := 0;
            
         when 1 .. 3 =>
            ForschungsverbrauchKorruptionMultiplikator := 1;
            
         when 4 .. 6 =>
            ForschungsverbrauchKorruptionMultiplikator := 2;
            
         when 7 .. 9 =>
            ForschungsverbrauchKorruptionMultiplikator := 5;
            
         when others =>
            ForschungsverbrauchKorruptionMultiplikator := 10;
      end case;
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleForschungsrate :=
        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleForschungsrate
        - GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner * ForschungsverbrauchKorruptionMultiplikator;

      if GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleForschungsrate < 0 then
         GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleForschungsrate := 0;
         
      else
         null;
      end if;
      
   end WeitereForschungsrateÄnderungen;

end StadtProduktion;
