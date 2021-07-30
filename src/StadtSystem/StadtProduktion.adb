pragma SPARK_Mode (On);

with GlobaleKonstanten;

with GebaeudeDatenbank;

with Wachstum, KartePositionPruefen, KartenAllgemein, StadtWerteTesten;

package body StadtProduktion is

   procedure StadtProduktionPrüfen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case StadtRasseNummerExtern.Rasse is
         -- Überprüfung für alle Rassen bei Runde beenden.
         when GlobaleDatentypen.Leer =>
            RassenSchleife:
            for RasseSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (1) loop
               
               case
                 GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
               is
                  when GlobaleDatentypen.Leer =>
                     null;
                     
                  when others =>
                     StadtSchleife:
                     for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                  
                        case
                          GlobaleVariablen.StadtGebaut (RasseSchleifenwert, StadtNummerSchleifenwert).ID
                        is
                           when GlobaleDatentypen.Leer =>
                              null;
                  
                           when others =>
                              StadtProduktionBerechnung (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert));
                        end case;
               
                     end loop StadtSchleife;
               end case;
               
            end loop RassenSchleife;
         
            -- Überprüfung beim Bauen einer Stadt
         when others =>
            StadtProduktionBerechnung (StadtRasseNummerExtern => StadtRasseNummerExtern);
            Wachstum.WachstumStadtExistiert (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                             StadtGegründetExtern  => True);
      end case;
      
   end StadtProduktionPrüfen;
   


   procedure StadtProduktionBerechnung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate := 0;

      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption
        := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) / 3;

      NutzbarerBereich := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße;
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            case
              KartenWert.XAchse
            is
               when GlobaleKonstanten.LeerYXKartenWert =>
                  null;
                  
               when others =>            
                  case
                    GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YÄnderungSchleifenwert, XÄnderungSchleifenwert)
                  is
                     when True =>
                        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion
                          := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion
                          + KartenAllgemein.GrundNahrung (PositionExtern => KartenWert) + KartenAllgemein.RessourceNahrung (PositionExtern => KartenWert) + KartenAllgemein.StraßeNahrung (PositionExtern => KartenWert)
                          + KartenAllgemein.VerbesserungNahrung (PositionExtern => KartenWert);

                        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate
                          := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate
                          + KartenAllgemein.GrundRessourcen (PositionExtern => KartenWert) + KartenAllgemein.RessourceRessourcen (PositionExtern => KartenWert)
                          + KartenAllgemein.StraßeRessourcen (PositionExtern => KartenWert) + KartenAllgemein.VerbesserungRessourcen (PositionExtern => KartenWert);

                        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung
                          := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung
                          + KartenAllgemein.GrundGeld (PositionExtern => KartenWert) + KartenAllgemein.RessourceGeld (PositionExtern => KartenWert) + KartenAllgemein.StraßeGeld (PositionExtern => KartenWert)
                          + KartenAllgemein.VerbesserungGeld (PositionExtern => KartenWert);

                        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate
                          := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate
                          + KartenAllgemein.GrundWissen (PositionExtern => KartenWert) + KartenAllgemein.RessourceWissen (PositionExtern => KartenWert) + KartenAllgemein.StraßeWissen (PositionExtern => KartenWert)
                          + KartenAllgemein.VerbesserungWissen (PositionExtern => KartenWert);

                     when others =>
                        null;
                  end case;
            end case;
                           
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      WeitereNahrungsproduktionÄnderungen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      WeitereProduktionrateÄnderungen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      WeitereGeldgewinnungÄnderungen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      WeitereForschungsrateÄnderungen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end StadtProduktionBerechnung;
   
   
   
   procedure WeitereNahrungsproduktionÄnderungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion :=
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion
        - StadtWerteTesten.PermanenteKosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                             WelcheRessourceExtern  => GlobaleDatentypen.Nahrung);

      case
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
      is
         when 0 .. 3 =>
            NahrungsverbrauchEinwohnerMultiplikator := 0;
            
         when 4 .. 9 =>
            NahrungsverbrauchEinwohnerMultiplikator := 0;
            
         when 10 .. 19 =>
            NahrungsverbrauchEinwohnerMultiplikator := 0;
            
         when others =>
            NahrungsverbrauchEinwohnerMultiplikator := 0;
      end case;
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion :=
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion
        - GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) * NahrungsverbrauchEinwohnerMultiplikator;
      
   end WeitereNahrungsproduktionÄnderungen;



   procedure WeitereProduktionrateÄnderungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate :=
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate
        - StadtWerteTesten.PermanenteKosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                             WelcheRessourceExtern  => GlobaleDatentypen.Ressourcen);
      
      if
        StadtRasseNummerExtern.Rasse = GlobaleDatentypen.Menschen
        and
          GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (4) = True
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate :=
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate + GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, 4).ProduktionBonus;

      else
         null;
      end if;
      
      case
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption
      is
         when 0 =>
            RessourcenverbrauchKorruptionMultiplikator := 0;
            
         when 1 .. 4 =>
            RessourcenverbrauchKorruptionMultiplikator := 0;
            
         when 5 .. 7 =>
            RessourcenverbrauchKorruptionMultiplikator := 0;
            
         when 8 .. 10 =>
            RessourcenverbrauchKorruptionMultiplikator := 0;
            
         when others =>
            RessourcenverbrauchKorruptionMultiplikator := 0;
      end case;
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate :=
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate
        - GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) * RessourcenverbrauchKorruptionMultiplikator;

      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate < 0
      -- Warum sollte die Produktionsrate nicht auch negativ sein können?
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate := 0;
         
      else
         null;
      end if;
      
   end WeitereProduktionrateÄnderungen;



   procedure WeitereGeldgewinnungÄnderungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung :=
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung
        - StadtWerteTesten.PermanenteKosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                             WelcheRessourceExtern  => GlobaleDatentypen.Geld);

      case
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption
      is
         when 0 =>
            GeldverbrauchKorruptionMultiplikator := 0;
            
         when 1 .. 4 =>
            GeldverbrauchKorruptionMultiplikator := 0;
            
         when 5 .. 7 =>
            GeldverbrauchKorruptionMultiplikator := 0;
            
         when 8 .. 10 =>
            GeldverbrauchKorruptionMultiplikator := 0;
            
         when others =>
            GeldverbrauchKorruptionMultiplikator := 0;
      end case;
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung :=
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung
        - GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) * GeldverbrauchKorruptionMultiplikator;
      
   end WeitereGeldgewinnungÄnderungen;



   procedure WeitereForschungsrateÄnderungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin

      case
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Korruption
      is
         when 0 =>
            ForschungsverbrauchKorruptionMultiplikator := 0;
            
         when 1 .. 4 =>
            ForschungsverbrauchKorruptionMultiplikator := 0;
            
         when 5 .. 7 =>
            ForschungsverbrauchKorruptionMultiplikator := 0;
            
         when 8 .. 10 =>
            ForschungsverbrauchKorruptionMultiplikator := 0;
            
         when others =>
            ForschungsverbrauchKorruptionMultiplikator := 0;
      end case;
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate :=
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate
        - GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) * ForschungsverbrauchKorruptionMultiplikator;

      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate < 0
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate := 0;
         
      else
         null;
      end if;
      
   end WeitereForschungsrateÄnderungen;

end StadtProduktion;
