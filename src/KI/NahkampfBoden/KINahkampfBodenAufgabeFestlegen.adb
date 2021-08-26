pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIDatentypen, KIKonstanten;

with EinheitSuchen, KartePositionPruefen, BewegungPassierbarkeitPruefen, EinheitenAllgemein, KIAufgabenVerteilt, KIAufgabenFestlegenAllgemein, LeseKarten, LeseEinheitenGebaut, SchreibeEinheitenGebaut, LeseStadtGebaut;

package body KINahkampfBodenAufgabeFestlegen is

   procedure NahkampfBodenAufgabeFestlegen
     (GewählteAufgabeExtern : in Natural;
      EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GewählteAufgabeExtern
      is
         -- Stadt bewachen
         when 1 =>
            StadtBewachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Stadtumgebung zerstören
         when 2 =>
            StadtUmgebungZerstören (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Einheit auflösen
         when 3 =>
            EinheitenAllgemein.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Fliehen
         when 4 =>
            Fliehen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Sich heilen
         when 5 =>
            KIAufgabenFestlegenAllgemein.Heilen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Sich befestigen
         when 6 =>
            Befestigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Einheit verbessern
         when 7 =>
            KIAufgabenFestlegenAllgemein.EinheitVerbessern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Angreifen
         when 8 =>
            Angreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
              
            -- Erkunden
         when 9 =>
            Erkunden (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            -- Nichts tun
         when others =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Keine_Aufgabe);
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Leer);
      end case;
      
   end NahkampfBodenAufgabeFestlegen;
   
   
   
   procedure StadtBewachen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      EinheitNummer := 1;
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert))
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               EinheitNummer := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                                KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert)));
         end case;
         
         case
           EinheitNummer
         is
            when GlobaleKonstanten.LeerEinheitStadtNummer =>
               SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                          KoordinatenExtern        => LeseStadtGebaut.Position (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert)));
               SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       AufgabeExtern            => KIDatentypen.Stadt_Bewachen);
               return;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
   end StadtBewachen;
   
   
   
   procedure StadtUmgebungZerstören     
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end StadtUmgebungZerstören;
   
   
   
   procedure Fliehen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Flucht);
      
   end Fliehen;
        
   
   
   procedure Befestigen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Einheit_Festsetzen);
      
   end Befestigen;
   
   
   
   procedure Angreifen     
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      null;
      
   end Angreifen;
   
   
   
   procedure Erkunden     
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin      
            
      KartenYReichweite := 1;
      KartenXReichweite := 1;
      KartenYGeprüft := KartenYReichweite - 1;
      KartenXGeprüft := KartenXReichweite - 1;
      
      UnbekanntesFeldSuchenSchleife:
      loop
         YAchseSchleife:
         for YÄnderungSchleifenwert in -KartenYReichweite .. KartenYReichweite loop
            XAchseSchleife:
            for XÄnderungSchleifenwert in -KartenXReichweite .. KartenXReichweite loop
            
               if
                 KartenYGeprüft >= abs (YÄnderungSchleifenwert)
                 or
                   KartenXGeprüft >= abs (XÄnderungSchleifenwert)
               then
                  null;
                  
               else
                  KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                              ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
                  
                  if
                    KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
                  then
                     null;
                        
                  elsif
                    LeseKarten.Sichtbar (PositionExtern => KartenWert,
                                         RasseExtern    => EinheitRasseNummerExtern.Rasse) = False
                    and
                      BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                 NeuePositionExtern       => KartenWert)
                    = True
                    and
                      KIAufgabenVerteilt.EinheitZiel (RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                      ZielKoordinatenExtern => KartenWert) = False
                  then
                     SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                KoordinatenExtern        => KartenWert);
                     SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             AufgabeExtern            => KIDatentypen.Erkunden);
                     return;
                     
                  else
                     null;
                  end if;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         exit UnbekanntesFeldSuchenSchleife when KartenYReichweite > 15;
         
         KartenYGeprüft := KartenYReichweite;
         KartenXGeprüft := KartenXReichweite;         
         KartenYReichweite := KartenYReichweite + 1;
         KartenXReichweite := KartenXReichweite + 1;
         
      end loop UnbekanntesFeldSuchenSchleife;
      
      SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 KoordinatenExtern        => KIKonstanten.NullKoordinate);
      SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              AufgabeExtern            => KIDatentypen.Keine_Aufgabe);
      
   end Erkunden;

end KINahkampfBodenAufgabeFestlegen;
