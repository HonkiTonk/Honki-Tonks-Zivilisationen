pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with StadtDatentypen; use StadtDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with KartenKonstanten;
with KartenverbesserungDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with KartenkoordinatenberechnungssystemLogik;
with KartenfelderwerteLogik;
with WachstumLogik;

package body StadtproduktionLogik is
   
   procedure Stadtproduktion
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      case
        StadtRasseNummerExtern.Rasse
      is
         when StadtKonstanten.LeerRasse =>
            StadtProduktionAlle;
            
         when others =>
            StadtProduktionBerechnung (StadtRasseNummerExtern => StadtRasseNummerExtern);
            WachstumLogik.WachstumWichtiges (RasseExtern => StadtRasseNummerExtern.Rasse);
      end case;
      
   end Stadtproduktion;
   
   
   
   procedure StadtProduktionAlle
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
               
         case
           SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
                     
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                  
                  case
                    LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert))
                  is
                     when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
                        null;
                  
                     when others =>
                        StadtProduktionBerechnung (StadtRasseNummerExtern => (RasseSchleifenwert, StadtNummerSchleifenwert));
                  end case;
               
               end loop StadtSchleife;
               
               WachstumLogik.WachstumWichtiges (RasseExtern => RasseSchleifenwert);
         end case;
               
      end loop RassenSchleife;
      
   end StadtProduktionAlle;
   


   procedure StadtProduktionBerechnung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      StadtProduktionNullSetzen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      KorruptionBerechnen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      ZufriedenheitBerechnen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      FelderProduktionBerechnen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      WeitereNahrungsproduktionÄnderungen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      WeitereProduktionrateÄnderungen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      -- Geldgewinnung muss immer nach der Produktionsrate ausgeführt werden, da bei keinem Bauprojekt sonst die Ressourcenumwandlung nach Geld nicht korrekt ist.
      case
        StadtRasseNummerExtern.Rasse
      is
         when RassenDatentypen.Ekropa_Enum =>
            null;
            
         when others =>
            WeitereGeldgewinnungÄnderungen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
      WeitereForschungsrateÄnderungen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end StadtProduktionBerechnung;
   
   
   
   procedure KorruptionBerechnen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      null;
      
   end KorruptionBerechnen;
   
   
   
   procedure ZufriedenheitBerechnen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      null;
      
   end ZufriedenheitBerechnen;
   
   
   
   procedure FelderProduktionBerechnen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
            
      NutzbarerBereich := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              False = LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               YKoordinateExtern      => YAchseSchleifenwert,
                                                               XKoordinateExtern      => XAchseSchleifenwert)
            then
               null;
               
            else
               SchreibeStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern   => StadtRasseNummerExtern,
                                                       NahrungsproduktionExtern => KartenfelderwerteLogik.FeldNahrung (KoordinatenExtern => KartenWert,
                                                                                                                       RasseExtern       => StadtRasseNummerExtern.Rasse),
                                                       ÄndernSetzenExtern       => True);
               SchreibeStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                   ProduktionrateExtern   => KartenfelderwerteLogik.FeldProduktion (KoordinatenExtern => KartenWert,
                                                                                                                    RasseExtern       => StadtRasseNummerExtern.Rasse),
                                                   ÄndernSetzenExtern     => True);
               
               case
                 StadtRasseNummerExtern.Rasse
               is
                  when RassenDatentypen.Ekropa_Enum =>
                     null;
                     
                  when others =>
                     SchreibeStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                        GeldgewinnungExtern    => KartenfelderwerteLogik.FeldGeld (KoordinatenExtern => KartenWert,
                                                                                                                   RasseExtern       => StadtRasseNummerExtern.Rasse),
                                                        ÄndernSetzenExtern     => True);
               end case;
               
               SchreibeStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                   ForschungsrateExtern   => KartenfelderwerteLogik.FeldWissen (KoordinatenExtern => KartenWert,
                                                                                                                RasseExtern       => StadtRasseNummerExtern.Rasse),
                                                   ÄndernSetzenExtern     => True);
            end if;
                           
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end FelderProduktionBerechnen;
   
   
   
   procedure StadtProduktionNullSetzen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      SchreibeStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern   => StadtRasseNummerExtern,
                                              NahrungsproduktionExtern => StadtKonstanten.LeerNahrungsproduktion,
                                              ÄndernSetzenExtern       => False);
      SchreibeStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          ProduktionrateExtern   => StadtKonstanten.LeerProduktionrate,
                                          ÄndernSetzenExtern     => False);
      
      case
        StadtRasseNummerExtern.Rasse
      is
         when RassenDatentypen.Ekropa_Enum =>
            null;
            
         when others =>
            SchreibeStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               GeldgewinnungExtern    => StadtKonstanten.LeerGeldgewinnung,
                                               ÄndernSetzenExtern     => False);
      end case;
      
      SchreibeStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          ForschungsrateExtern   => StadtKonstanten.LeerForschungsrate,
                                          ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.Korruption (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      KorruptionExtern       => StadtKonstanten.LeerKorruption,
                                      ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.Zufriedenheit (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         ZufriedenheitExtern    => StadtKonstanten.LeerZufriedenheit,
                                         ÄndernSetzenExtern    => False);
      
   end StadtProduktionNullSetzen;
   
   
   
   procedure WeitereNahrungsproduktionÄnderungen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      SchreibeStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern   => StadtRasseNummerExtern,
                                              NahrungsproduktionExtern => -LeseStadtGebaut.PermanenteKostenPosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                                                   WelcherPostenExtern    => ProduktionDatentypen.Nahrung_Enum),
                                              ÄndernSetzenExtern       => True);
      
      SchreibeStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern   => StadtRasseNummerExtern,
                                              NahrungsproduktionExtern => -ProduktionDatentypen.Stadtproduktion (LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                                                                    EinwohnerArbeiterExtern => True)),
                                              ÄndernSetzenExtern       => True);
      
      VorhandeneEinwohner := LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                EinwohnerArbeiterExtern => True);
      case
        VorhandeneEinwohner
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
                                              NahrungsproduktionExtern => ProduktionDatentypen.Stadtproduktion (VorhandeneEinwohner) * NahrungsverbrauchEinwohnerMultiplikator,
                                              ÄndernSetzenExtern       => True);
      
   end WeitereNahrungsproduktionÄnderungen;



   procedure WeitereProduktionrateÄnderungen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      SchreibeStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          ProduktionrateExtern   => -LeseStadtGebaut.PermanenteKostenPosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                                             WelcherPostenExtern    => ProduktionDatentypen.Produktion_Enum),
                                          ÄndernSetzenExtern     => True);
            
      case
        -- Diesen Wert an der Bevölkerung und nicht an der Korruption messen?
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
                                          ProduktionrateExtern   => ProduktionDatentypen.Stadtproduktion (LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                                                             EinwohnerArbeiterExtern => True))
                                          * RessourcenverbrauchKorruptionMultiplikator,
                                          ÄndernSetzenExtern     => True);
      
   end WeitereProduktionrateÄnderungen;



   procedure WeitereGeldgewinnungÄnderungen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      SchreibeStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         GeldgewinnungExtern    => -LeseStadtGebaut.PermanenteKostenPosten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                                            WelcherPostenExtern    => ProduktionDatentypen.Geld_Enum),
                                         ÄndernSetzenExtern     => True);
      
      Bauprojekt := LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      if
        Bauprojekt.Gebäude = 0
        and
          Bauprojekt.Einheit = 0
      then
         SchreibeStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                            GeldgewinnungExtern    => LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) / 5,
                                            ÄndernSetzenExtern     => True);
         
      else
         null;
      end if;

      case
        -- Diesen Wert an der Bevölkerung und nicht an der Korruption messen?
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
                                         GeldgewinnungExtern    => ProduktionDatentypen.Stadtproduktion (LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                                                            EinwohnerArbeiterExtern => True))
                                         * GeldverbrauchKorruptionMultiplikator,
                                         ÄndernSetzenExtern     => True);
      
   end WeitereGeldgewinnungÄnderungen;



   procedure WeitereForschungsrateÄnderungen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin

      case
        -- Diesen Wert an der Bevölkerung und nicht an der Korruption messen?
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
                                          ForschungsrateExtern   => ProduktionDatentypen.Stadtproduktion (LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                                                             EinwohnerArbeiterExtern => True))
                                          * ForschungsverbrauchKorruptionMultiplikator,
                                          ÄndernSetzenExtern     => True);
      
   end WeitereForschungsrateÄnderungen;

end StadtproduktionLogik;
