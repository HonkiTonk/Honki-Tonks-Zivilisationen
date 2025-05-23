with EinheitenDatentypen;
with KartenKonstanten;
with ProduktionKonstanten;
with SystemDatentypen;
with KartenDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;

with KartenkoordinatenberechnungssystemLogik;
with GlobalesWachstumLogik;
with FeldproduktionLogik;

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
      
      FelderProduktionBerechnen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      KorruptionBerechnen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      ZufriedenheitBerechnen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
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
      
      SchreibeStadtGebaut.Korruption (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                      KorruptionExtern         => StadtKonstanten.LeerKorruption,
                                      ÄndernSetzenExtern       => False);
      
   end KorruptionBerechnen;
   
   
   
   procedure ZufriedenheitBerechnen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      SchreibeStadtGebaut.Zufriedenheit (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         ZufriedenheitExtern      => StadtKonstanten.LeerZufriedenheit,
                                         ÄndernSetzenExtern       => False);
      
   end ZufriedenheitBerechnen;
   
   
   
   procedure FelderProduktionBerechnen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
      use type ProduktionDatentypen.Produktion;
   begin
            
      NutzbarerBereich := LeseStadtGebaut.Gesamtumgebung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
      Nahrungsgewinnung := ProduktionKonstanten.LeerProduktion;
      Materialgewinnung := ProduktionKonstanten.LeerProduktion;
      Geldgewinnung := ProduktionKonstanten.LeerProduktion;
      Forschungsgewinnung := ProduktionKonstanten.LeerProduktion;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in -NutzbarerBereich.Senkrechte .. NutzbarerBereich.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in -NutzbarerBereich.Waagerechte .. NutzbarerBereich.Waagerechte loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              False = LeseStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                               YKoordinateExtern        => SenkrechteSchleifenwert,
                                                               XKoordinateExtern        => WaagerechteSchleifenwert)
            then
               null;
               
            else
               Nahrungsgewinnung := Nahrungsgewinnung + FeldproduktionLogik.Feldproduktion (KoordinatenExtern    => KartenWert,
                                                                                            SpeziesExtern        => StadtSpeziesNummerExtern.Spezies,
                                                                                            ProduktionsartExtern => ProduktionDatentypen.Nahrung_Enum);
               Materialgewinnung := Materialgewinnung + FeldproduktionLogik.Feldproduktion (KoordinatenExtern    => KartenWert,
                                                                                            SpeziesExtern        => StadtSpeziesNummerExtern.Spezies,
                                                                                            ProduktionsartExtern => ProduktionDatentypen.Material_Enum);
               Forschungsgewinnung := Forschungsgewinnung + FeldproduktionLogik.Feldproduktion (KoordinatenExtern    => KartenWert,
                                                                                                SpeziesExtern        => StadtSpeziesNummerExtern.Spezies,
                                                                                                ProduktionsartExtern => ProduktionDatentypen.Forschung_Enum);
               
               case
                 StadtSpeziesNummerExtern.Spezies
               is
                  when SpeziesDatentypen.Ekropa_Enum =>
                     null;
                     
                  when others =>
                     Geldgewinnung := Geldgewinnung + FeldproduktionLogik.Feldproduktion (KoordinatenExtern    => KartenWert,
                                                                                          SpeziesExtern        => StadtSpeziesNummerExtern.Spezies,
                                                                                          ProduktionsartExtern => ProduktionDatentypen.Geld_Enum);
               end case;
               
            end if;
                           
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
                           
      SchreibeStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                              NahrungsproduktionExtern => Nahrungsgewinnung,
                                              ÄndernSetzenExtern       => False);
      SchreibeStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                          ProduktionrateExtern     => Materialgewinnung,
                                          ÄndernSetzenExtern       => False);
      SchreibeStadtGebaut.Forschungsrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                          ForschungsrateExtern     => Forschungsgewinnung,
                                          ÄndernSetzenExtern       => False);
      SchreibeStadtGebaut.Geldgewinnung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         GeldgewinnungExtern      => Geldgewinnung,
                                         ÄndernSetzenExtern       => False);
      
   end FelderProduktionBerechnen;
   
   
   
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
            NahrungsverbrauchEinwohnerMultiplikator := -1;
            
         when 4 .. 9 =>
            NahrungsverbrauchEinwohnerMultiplikator := -1;
            
         when 10 .. 19 =>
            NahrungsverbrauchEinwohnerMultiplikator := -1;
            
         when others =>
            NahrungsverbrauchEinwohnerMultiplikator := -1;
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
                                                                                                               WelcherPostenExtern      => ProduktionDatentypen.Material_Enum),
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
      use type EinheitenDatentypen.EinheitenID;
      use type StadtDatentypen.GebäudeID;
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
