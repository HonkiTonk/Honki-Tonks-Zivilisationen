pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Wachstum, KartePositionPruefen, GesamtwerteFeld, LeseStadtGebaut, SchreibeStadtGebaut;

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
                          LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert))
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
      
      SchreibeStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern   => StadtRasseNummerExtern,
                                              NahrungsproduktionExtern => GlobaleKonstanten.LeerStadt.Nahrungsproduktion,
                                              ÄndernSetzenExtern       => False);
      SchreibeStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          ProduktionrateExtern   => GlobaleKonstanten.LeerStadt.Produktionrate,
                                          ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         GeldgewinnungExtern    => GlobaleKonstanten.LeerStadt.Geldgewinnung,
                                         ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          ForschungsrateExtern   => GlobaleKonstanten.LeerStadt.Forschungsrate,
                                          ÄndernSetzenExtern     => False);

      SchreibeStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      KorruptionExtern       => LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                   EinwohnerArbeiterExtern => True) / 3,
                                      ÄndernSetzenExtern    => False);

      NutzbarerBereich := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            case
              KartenWert.XAchse
            is
               when GlobaleKonstanten.LeerYXKartenWert =>
                  null;
                  
               when others =>            
                  case
                    LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             YPositionExtern        => YÄnderungSchleifenwert,
                                                             XPositionExtern        => XÄnderungSchleifenwert)
                  is
                     when True =>
                        SchreibeStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern   => StadtRasseNummerExtern,
                                                                NahrungsproduktionExtern => GesamtwerteFeld.FeldNahrung (KoordinatenExtern => KartenWert,
                                                                                                                         RasseExtern       => StadtRasseNummerExtern.Rasse),
                                                                ÄndernSetzenExtern       => True);
                        SchreibeStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                            ProduktionrateExtern   => GesamtwerteFeld.FeldProduktion (KoordinatenExtern => KartenWert,
                                                                                                                      RasseExtern       => StadtRasseNummerExtern.Rasse),
                                                            ÄndernSetzenExtern     => True);
                        SchreibeStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                           GeldgewinnungExtern    => GesamtwerteFeld.FeldGeld (KoordinatenExtern => KartenWert,
                                                                                                               RasseExtern       => StadtRasseNummerExtern.Rasse),
                                                           ÄndernSetzenExtern     => True);
                        SchreibeStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                            ForschungsrateExtern   => GesamtwerteFeld.FeldWissen (KoordinatenExtern => KartenWert,
                                                                                                                  RasseExtern       => StadtRasseNummerExtern.Rasse),
                                                            ÄndernSetzenExtern     => True);

                     when False =>
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
      
      SchreibeStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern   => StadtRasseNummerExtern,
                                              NahrungsproduktionExtern => -LeseStadtGebaut.PermanenteKostenPosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                                                   WelcherPostenExtern    => GlobaleDatentypen.Nahrung),
                                              ÄndernSetzenExtern       => True);

      case
        -- Diesen Wert an der Bevölkerung und nicht an der Korruption messen?
        LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                           EinwohnerArbeiterExtern => True)
      is
         -- Den Multiplikator immer Minus setzen, damit er später direkt einen negativen Wert übergibt, eventuelle für mehr nutzen, wenn Gebäude bestimmte Werte entsprechend beeinflussen.
         when 0 .. 3 =>
            NahrungsverbrauchEinwohnerMultiplikator := -0;
            
         when 4 .. 9 =>
            NahrungsverbrauchEinwohnerMultiplikator := -0;
            
         when 10 .. 19 =>
            NahrungsverbrauchEinwohnerMultiplikator := -0;
            
         when others =>
            NahrungsverbrauchEinwohnerMultiplikator := -0;
      end case;
      
      SchreibeStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern   => StadtRasseNummerExtern,
                                              NahrungsproduktionExtern => LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                             EinwohnerArbeiterExtern => True) * NahrungsverbrauchEinwohnerMultiplikator,
                                              ÄndernSetzenExtern      => True);
      
   end WeitereNahrungsproduktionÄnderungen;



   procedure WeitereProduktionrateÄnderungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          ProduktionrateExtern   => - LeseStadtGebaut.PermanenteKostenPosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                                              WelcherPostenExtern    => GlobaleDatentypen.Ressourcen),
                                          ÄndernSetzenExtern    => True);
            
      case
        LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         -- Den Multiplikator immer Minus setzen, damit er später direkt einen negativen Wert übergibt, eventuelle für mehr nutzen, wenn Gebäude bestimmte Werte entsprechend beeinflussen.
         when 0 =>
            RessourcenverbrauchKorruptionMultiplikator := -0;
            
         when 1 .. 4 =>
            RessourcenverbrauchKorruptionMultiplikator := -0;
            
         when 5 .. 7 =>
            RessourcenverbrauchKorruptionMultiplikator := -0;
            
         when 8 .. 10 =>
            RessourcenverbrauchKorruptionMultiplikator := -0;
            
         when others =>
            RessourcenverbrauchKorruptionMultiplikator := -0;
      end case;
      
      SchreibeStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          ProduktionrateExtern   => LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                     EinwohnerArbeiterExtern => True) * RessourcenverbrauchKorruptionMultiplikator,
                                          ÄndernSetzenExtern     => True);
      
   end WeitereProduktionrateÄnderungen;



   procedure WeitereGeldgewinnungÄnderungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         GeldgewinnungExtern    => -LeseStadtGebaut.PermanenteKostenPosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                                            WelcherPostenExtern    => GlobaleDatentypen.Geld),
                                         ÄndernSetzenExtern     => True);

      case
        LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         -- Den Multiplikator immer Minus setzen, damit er später direkt einen negativen Wert übergibt, eventuelle für mehr nutzen, wenn Gebäude bestimmte Werte entsprechend beeinflussen.
         when 0 =>
            GeldverbrauchKorruptionMultiplikator := -0;
            
         when 1 .. 4 =>
            GeldverbrauchKorruptionMultiplikator := -0;
            
         when 5 .. 7 =>
            GeldverbrauchKorruptionMultiplikator := -0;
            
         when 8 .. 10 =>
            GeldverbrauchKorruptionMultiplikator := -0;
            
         when others =>
            GeldverbrauchKorruptionMultiplikator := -0;
      end case;
      
      SchreibeStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         GeldgewinnungExtern    => LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                     EinwohnerArbeiterExtern => True) * GeldverbrauchKorruptionMultiplikator,
                                         ÄndernSetzenExtern     => True);
      
   end WeitereGeldgewinnungÄnderungen;



   procedure WeitereForschungsrateÄnderungen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin

      case
        LeseStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         -- Den Multiplikator immer Minus setzen, damit er später direkt einen negativen Wert übergibt, eventuelle für mehr nutzen, wenn Gebäude bestimmte Werte entsprechend beeinflussen.
         when 0 =>
            ForschungsverbrauchKorruptionMultiplikator := -0;
            
         when 1 .. 4 =>
            ForschungsverbrauchKorruptionMultiplikator := -0;
            
         when 5 .. 7 =>
            ForschungsverbrauchKorruptionMultiplikator := -0;
            
         when 8 .. 10 =>
            ForschungsverbrauchKorruptionMultiplikator := -0;
            
         when others =>
            ForschungsverbrauchKorruptionMultiplikator := -0;
      end case;
      
      SchreibeStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          ForschungsrateExtern   => LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                       EinwohnerArbeiterExtern => True) * ForschungsverbrauchKorruptionMultiplikator,
                                          ÄndernSetzenExtern     => True);
      
   end WeitereForschungsrateÄnderungen;

end StadtProduktion;
