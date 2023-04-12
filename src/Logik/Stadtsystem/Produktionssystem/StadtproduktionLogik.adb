with StadtDatentypen;
with EinheitenDatentypen;
with KartenKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with KartenkoordinatenberechnungssystemLogik;
with KartenfelderwerteLogik;
with GlobalesWachstumLogik;

package body StadtproduktionLogik is
   
   procedure Stadtproduktion
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      StadtProduktionBerechnung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      GlobalesWachstumLogik.WachstumsratenBerechnen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies);
      
   end Stadtproduktion;
   


   procedure StadtProduktionBerechnung
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      StadtProduktionNullSetzen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      KorruptionBerechnen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      ZufriedenheitBerechnen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      FelderProduktionBerechnen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      WeitereNahrungsproduktionÄnderungen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      WeitereProduktionrateÄnderungen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      -- Geldgewinnung muss immer nach der Produktionsrate ausgeführt werden, da bei keinem Bauprojekt sonst die Ressourcenumwandlung nach Geld nicht korrekt ist.
      case
        StadtSpeziesNummerExtern.Spezies
      is
         when SpeziesDatentypen.Ekropa_Enum =>
            null;
            
         when others =>
            WeitereGeldgewinnungÄnderungen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      end case;
      
      WeitereForschungsrateÄnderungen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
   end StadtProduktionBerechnung;
   
   
   
   procedure KorruptionBerechnen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      null;
      
   end KorruptionBerechnen;
   
   
   
   procedure ZufriedenheitBerechnen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      null;
      
   end ZufriedenheitBerechnen;
   
   
   
   procedure FelderProduktionBerechnen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
            
      NutzbarerBereich := LeseStadtGebaut.UmgebungGröße (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
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
              False = LeseStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                               YKoordinateExtern        => YAchseSchleifenwert,
                                                               XKoordinateExtern        => XAchseSchleifenwert)
            then
               null;
               
            else
               SchreibeStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                       NahrungsproduktionExtern => KartenfelderwerteLogik.FeldNahrung (KoordinatenExtern => KartenWert,
                                                                                                                       SpeziesExtern     => StadtSpeziesNummerExtern.Spezies),
                                                       ÄndernSetzenExtern       => True);
               SchreibeStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                   ProduktionrateExtern     => KartenfelderwerteLogik.FeldProduktion (KoordinatenExtern => KartenWert,
                                                                                                                      SpeziesExtern     => StadtSpeziesNummerExtern.Spezies),
                                                   ÄndernSetzenExtern       => True);
               
               case
                 StadtSpeziesNummerExtern.Spezies
               is
                  when SpeziesDatentypen.Ekropa_Enum =>
                     null;
                     
                  when others =>
                     SchreibeStadtGebaut.Geldgewinnung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                        GeldgewinnungExtern      => KartenfelderwerteLogik.FeldGeld (KoordinatenExtern => KartenWert,
                                                                                                                     SpeziesExtern     => StadtSpeziesNummerExtern.Spezies),
                                                        ÄndernSetzenExtern       => True);
               end case;
               
               SchreibeStadtGebaut.Forschungsrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                   ForschungsrateExtern     => KartenfelderwerteLogik.FeldWissen (KoordinatenExtern => KartenWert,
                                                                                                                  SpeziesExtern     => StadtSpeziesNummerExtern.Spezies),
                                                   ÄndernSetzenExtern       => True);
            end if;
                           
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end FelderProduktionBerechnen;
   
   
   
   procedure StadtProduktionNullSetzen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      SchreibeStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                              NahrungsproduktionExtern => StadtKonstanten.LeerNahrungsproduktion,
                                              ÄndernSetzenExtern       => False);
      SchreibeStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                          ProduktionrateExtern     => StadtKonstanten.LeerProduktionrate,
                                          ÄndernSetzenExtern       => False);
      
      case
        StadtSpeziesNummerExtern.Spezies
      is
         when SpeziesDatentypen.Ekropa_Enum =>
            null;
            
         when others =>
            SchreibeStadtGebaut.Geldgewinnung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                               GeldgewinnungExtern      => StadtKonstanten.LeerGeldgewinnung,
                                               ÄndernSetzenExtern       => False);
      end case;
      
      SchreibeStadtGebaut.Forschungsrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                          ForschungsrateExtern     => StadtKonstanten.LeerForschungsrate,
                                          ÄndernSetzenExtern       => False);
      SchreibeStadtGebaut.Korruption (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                      KorruptionExtern         => StadtKonstanten.LeerKorruption,
                                      ÄndernSetzenExtern       => False);
      SchreibeStadtGebaut.Zufriedenheit (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         ZufriedenheitExtern      => StadtKonstanten.LeerZufriedenheit,
                                         ÄndernSetzenExtern       => False);
      
   end StadtProduktionNullSetzen;
   
   
   
   procedure WeitereNahrungsproduktionÄnderungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      SchreibeStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                              NahrungsproduktionExtern => -LeseStadtGebaut.PermanenteKostenPosten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                                                   WelcherPostenExtern      => ProduktionDatentypen.Nahrung_Enum),
                                              ÄndernSetzenExtern       => True);
      
      SchreibeStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                              NahrungsproduktionExtern => -ProduktionDatentypen.Stadtproduktion (LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                                                                                    EinwohnerArbeiterExtern  => True)),
                                              ÄndernSetzenExtern       => True);
      
      VorhandeneEinwohner := LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                EinwohnerArbeiterExtern  => True);
      
      -- Vorhandene Einwohner und die Korruption könnten auch in ein konstantes Array gepackt werden. äöü
      -- Warum ist das nicht auch einfach Korruption? äöü
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
      
      SchreibeStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                              NahrungsproduktionExtern => ProduktionDatentypen.Stadtproduktion (VorhandeneEinwohner) * NahrungsverbrauchEinwohnerMultiplikator,
                                              ÄndernSetzenExtern       => True);
      
   end WeitereNahrungsproduktionÄnderungen;



   procedure WeitereProduktionrateÄnderungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      SchreibeStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                          ProduktionrateExtern     => -LeseStadtGebaut.PermanenteKostenPosten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                                               WelcherPostenExtern      => ProduktionDatentypen.Produktion_Enum),
                                          ÄndernSetzenExtern       => True);
            
      case
        -- Diesen Wert an der Bevölkerung und nicht an der Korruption messen?
        LeseStadtGebaut.Korruption (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
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
      
      SchreibeStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                          ProduktionrateExtern     => ProduktionDatentypen.Stadtproduktion (LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                                                                               EinwohnerArbeiterExtern  => True))
                                          * RessourcenverbrauchKorruptionMultiplikator,
                                          ÄndernSetzenExtern       => True);
      
   end WeitereProduktionrateÄnderungen;



   procedure WeitereGeldgewinnungÄnderungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type ProduktionDatentypen.Produktion;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
      use type StadtDatentypen.GebäudeIDMitNullwert;
   begin
      
      SchreibeStadtGebaut.Geldgewinnung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         GeldgewinnungExtern      => -LeseStadtGebaut.PermanenteKostenPosten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                                              WelcherPostenExtern      => ProduktionDatentypen.Geld_Enum),
                                         ÄndernSetzenExtern       => True);
      
      Bauprojekt := LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      if
        Bauprojekt.Gebäude = 0
        and
          Bauprojekt.Einheit = 0
      then
         SchreibeStadtGebaut.Geldgewinnung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                            GeldgewinnungExtern      => LeseStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) / 5,
                                            ÄndernSetzenExtern       => True);
         
      else
         null;
      end if;

      case
        -- Diesen Wert an der Bevölkerung und nicht an der Korruption messen?
        LeseStadtGebaut.Korruption (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
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
      
      SchreibeStadtGebaut.Geldgewinnung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         GeldgewinnungExtern      => ProduktionDatentypen.Stadtproduktion (LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                                                                              EinwohnerArbeiterExtern  => True))
                                         * GeldverbrauchKorruptionMultiplikator,
                                         ÄndernSetzenExtern       => True);
      
   end WeitereGeldgewinnungÄnderungen;



   procedure WeitereForschungsrateÄnderungen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type ProduktionDatentypen.Produktion;
   begin

      case
        -- Diesen Wert an der Bevölkerung und nicht an der Korruption messen?
        LeseStadtGebaut.Korruption (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
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
      
      SchreibeStadtGebaut.Forschungsrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                          ForschungsrateExtern     => ProduktionDatentypen.Stadtproduktion (LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                                                                               EinwohnerArbeiterExtern  => True))
                                          * ForschungsverbrauchKorruptionMultiplikator,
                                          ÄndernSetzenExtern       => True);
      
   end WeitereForschungsrateÄnderungen;

end StadtproduktionLogik;
