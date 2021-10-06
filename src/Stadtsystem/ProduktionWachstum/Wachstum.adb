pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with SonstigesKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with KartenDatentypen;
with SystemDatentypen;

with SchreibeStadtGebaut;
with SchreibeWichtiges;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;

with StadtWerteFestlegen;
with StadtEinheitenBauen;
with StadtGebaeudeBauen;
with StadtEntfernen;
with Sichtbarkeit;
with StadtMeldungenSetzen;

package body Wachstum is
   
   procedure StadtWachstum
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in SonstigeDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when SonstigeDatentypen.Leer =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                  
                  case
                    LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseSchleifenwert, StadtSchleifenwert))
                  is
                     when KartenDatentypen.Leer =>
                        null;
               
                     when others =>
                        WachstumEinwohner (StadtRasseNummerExtern => (RasseSchleifenwert, StadtSchleifenwert));
                        WachstumProduktion (StadtRasseNummerExtern => (RasseSchleifenwert, StadtSchleifenwert));
                  end case;
            
               end loop StadtSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end StadtWachstum;



   procedure WachstumEinwohner
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          NahrungsmittelExtern   => LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                          ÄndernSetzenExtern     => True);

      if
        LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern)
        > EinheitStadtDatentypen.KostenLager (10 + LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                      EinwohnerArbeiterExtern => True)
                                              * 5)
      then
         NeuerEinwohner (StadtRasseNummerExtern => StadtRasseNummerExtern);

      elsif
        LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern) < StadtKonstanten.LeerStadt.Nahrungsmittel
      then
         SchreibeStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                             NahrungsmittelExtern   => StadtKonstanten.LeerStadt.Nahrungsmittel,
                                             ÄndernSetzenExtern     => False);
         
         case
           LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                              EinwohnerArbeiterExtern => True)
         is
            when 1 =>
               StadtEntfernen.StadtEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               return;
               
            when others =>
               StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => False,
                                                                  StadtRasseNummerExtern   => StadtRasseNummerExtern);
               WachstumSchrumpfung := False;
         end case;
                  
      else
         return;
      end if;

      EinwohnerÄnderung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end WachstumEinwohner;
   
   
   
   procedure NeuerEinwohner
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          NahrungsmittelExtern   => StadtKonstanten.LeerStadt.Nahrungsmittel,
                                          ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => True,
                                             ÄnderungExtern          => 1);
      StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                                         StadtRasseNummerExtern   => StadtRasseNummerExtern);
      WachstumSchrumpfung := True;
      
   end NeuerEinwohner;
   
   
   
   procedure EinwohnerÄnderung
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        WachstumSchrumpfung
      is
         when True =>
            StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             EreignisExtern         => EinheitStadtDatentypen.Einwohner_Wachstum);
            if
              LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                 EinwohnerArbeiterExtern => True)
              = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert, StadtRasseNummerExtern.Rasse)
              or
                LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => True)
              = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert, StadtRasseNummerExtern.Rasse)
            then
               StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               Sichtbarkeit.SichtbarkeitsprüfungFürStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
            else
               null;
            end if;
            
         when False =>
            StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             EreignisExtern         => EinheitStadtDatentypen.Einwohner_Reduktion);
            if
              LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                 EinwohnerArbeiterExtern => True)
              = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert, StadtRasseNummerExtern.Rasse) - 1
              or
                LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => True)
              = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert, StadtRasseNummerExtern.Rasse) - 1
            then
               StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
            else
               null;
            end if;
      end case;
      
   end EinwohnerÄnderung;
   
   
   
   procedure WachstumProduktion
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      RessourcenExtern       => LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                      ÄndernSetzenExtern     => True);
      
      case
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when StadtKonstanten.BauprojekteGebäudeAnfang .. StadtKonstanten.BauprojekteGebäudeEnde =>
            if
              LeseStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern)
              >= LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                        IDExtern    => EinheitStadtDatentypen.GebäudeID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) - StadtKonstanten.GebäudeAufschlag))
            then
               StadtGebaeudeBauen.GebäudeFertiggestellt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
            else
               null;
            end if;
          
         when StadtKonstanten.BauprojekteEinheitenAnfang .. StadtKonstanten.BauprojekteEinheitenEnde =>
            if
              LeseStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern)
              >= LeseEinheitenDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                         IDExtern    =>
                                                           EinheitStadtDatentypen.EinheitenID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) - EinheitenKonstanten.EinheitAufschlag))
            then
               StadtEinheitenBauen.EinheitFertiggestellt (StadtRasseNummerExtern => StadtRasseNummerExtern);

            else
               null;
            end if;

         when others =>
            SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                            RessourcenExtern       => StadtKonstanten.LeerStadt.Ressourcen,
                                            ÄndernSetzenExtern     => False);
      end case;
      
   end WachstumProduktion;
   
   
   
   procedure WachstumWichtiges
     (RasseExtern : in SonstigeDatentypen.Rassen_Enum)
   is begin
      
      case
        RasseExtern
      is
         when SonstigeDatentypen.Leer =>
            RassenSchleife:
            for RasseSchleifenwert in SonstigeDatentypen.Rassen_Verwendet_Enum'Range loop
               
               case
                 GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
               is
                  when SonstigeDatentypen.Leer =>
                     null;
                     
                  when others =>
                     WachstumsratenBerechnen (RasseExtern => RasseSchleifenwert);
               end case;
               
            end loop RassenSchleife;
            
         when others =>
            WachstumsratenBerechnen (RasseExtern => RasseExtern);
      end case;
      
   end WachstumWichtiges;
   
   
   
   procedure WachstumsratenBerechnen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SchreibeWichtiges.GeldZugewinnProRunde (RasseExtern         => RasseExtern,
                                              GeldZugewinnExtern  => SonstigesKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde,
                                              RechnenSetzenExtern => False);
      SchreibeWichtiges.GesamteForschungsrate (RasseExtern                  => RasseExtern,
                                               ForschungsrateZugewinnExtern => SonstigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate,
                                               RechnenSetzenExtern          => False);
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when KartenDatentypen.Leer =>
               null;
               
            when others =>
               SchreibeWichtiges.GeldZugewinnProRunde (RasseExtern         => RasseExtern,
                                                       GeldZugewinnExtern  => LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)),
                                                       RechnenSetzenExtern => True);
               SchreibeWichtiges.GesamteForschungsrate (RasseExtern                  => RasseExtern,
                                                        ForschungsrateZugewinnExtern => LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)),
                                                        RechnenSetzenExtern          => True);
         end case;
         
      end loop StadtSchleife;
      
   end WachstumsratenBerechnen;

end Wachstum;
