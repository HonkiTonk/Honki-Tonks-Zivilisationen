pragma SPARK_Mode (On);

with GlobaleKonstanten;

with SchreibeStadtGebaut, SchreibeWichtiges;
with LeseEinheitenDatenbank, LeseStadtGebaut, LeseGebaeudeDatenbank, LeseWichtiges;

with StadtWerteFestlegen, StadtEinheitenBauen, StadtGebaeudeBauen, StadtEntfernen, Sichtbarkeit, StadtMeldungenSetzen;

package body Wachstum is

   procedure Wachstum
   is begin
      
      RassenEinsSchleife:
      for RasseEinsSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (1) loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseEinsSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseEinsSchleifenwert).Städtegrenze loop
            
                  case
                    StadtNummerSchleifenwert
                  is
                     when GlobaleVariablen.StadtGebautArray'First (2) =>
                        SchreibeWichtiges.GesamteForschungsrate (RasseExtern                  => RasseEinsSchleifenwert,
                                                                 ForschungsrateZugewinnExtern => 0,
                                                                 RechnenSetzenExtern          => False);
                        SchreibeWichtiges.GeldZugewinnProRunde (RasseExtern         => RasseEinsSchleifenwert,
                                                                GeldZugewinnExtern  => 0,
                                                                RechnenSetzenExtern => False);
                  
                     when others =>
                        null;
                  end case;
            
                  case
                    LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseEinsSchleifenwert, StadtNummerSchleifenwert))
                  is
                     when GlobaleDatentypen.Leer =>
                        null;
               
                     when others =>
                        WachstumEinwohner (StadtRasseNummerExtern => (RasseEinsSchleifenwert, StadtNummerSchleifenwert));
                        WachstumStadtExistiert (StadtRasseNummerExtern => (RasseEinsSchleifenwert, StadtNummerSchleifenwert),
                                                StadtGegründetExtern   => False);
                  end case;               
            
               end loop StadtSchleife;
         end case;
         
      end loop RassenEinsSchleife;

      RassenZweiSchleife:
      for RasseZweiSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           GlobaleVariablen.RassenImSpiel (RasseZweiSchleifenwert) = GlobaleDatentypen.Leer
         then
            null;
            
         else
            SchreibeWichtiges.Geldmenge (RasseExtern         => RasseZweiSchleifenwert,
                                         GeldZugewinnExtern  => Integer (LeseWichtiges.GeldZugewinnProRunde (RasseExtern => RasseZweiSchleifenwert)),
                                         RechnenSetzenExtern => True);
         
            SchreibeWichtiges.Forschungsmenge (RasseExtern             => RasseZweiSchleifenwert,
                                               ForschungZugewinnExtern => LeseWichtiges.GesamteForschungsrate (RasseExtern => RasseZweiSchleifenwert),
                                               RechnenSetzenExtern     => True);
         end if;
         
      end loop RassenZweiSchleife;
      
   end Wachstum;
   
   
   
   procedure WachstumStadtExistiert
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      StadtGegründetExtern : in Boolean)
   is begin
      
      SchreibeWichtiges.GesamteForschungsrate (RasseExtern                  => StadtRasseNummerExtern.Rasse,
                                               ForschungsrateZugewinnExtern => LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                               RechnenSetzenExtern          => True);
      
      SchreibeWichtiges.GeldZugewinnProRunde (RasseExtern         => StadtRasseNummerExtern.Rasse,
                                              GeldZugewinnExtern  => LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                              RechnenSetzenExtern => True);
                  
      if
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) > GlobaleKonstanten.LeerStadt.Produktionrate
        and
          StadtGegründetExtern = False
      then
         WachstumProduktion (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
      else
         null;
      end if;        
   
   end WachstumStadtExistiert;



   procedure WachstumEinwohner
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          NahrungsmittelExtern   => LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                          ÄndernSetzenExtern    => True);

      if
        LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern)
        > GlobaleDatentypen.KostenLager (10 + LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                 EinwohnerArbeiterExtern => True)
                                         * 5)
      then
         SchreibeStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                             NahrungsmittelExtern   => GlobaleKonstanten.LeerStadt.Nahrungsmittel,
                                             ÄndernSetzenExtern    => False);
         SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                EinwohnerArbeiterExtern => True,
                                                ÄnderungExtern         => 1);
         StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                                            StadtRasseNummerExtern   => StadtRasseNummerExtern);
         WachstumSchrumpfung := True;

      elsif
        LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern) < GlobaleKonstanten.LeerStadt.Nahrungsmittel
      then
         SchreibeStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                             NahrungsmittelExtern   => GlobaleKonstanten.LeerStadt.Nahrungsmittel,
                                             ÄndernSetzenExtern    => False);
         
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

      case
        WachstumSchrumpfung
      is
         when True =>
            StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             EreignisExtern         => GlobaleDatentypen.Einwohner_Wachstum);
            if
              LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                 EinwohnerArbeiterExtern => True)
              = GlobaleKonstanten.StadtUmgebungWachstum (GlobaleDatentypen.Anfangswert, StadtRasseNummerExtern.Rasse)
              or
                LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => True)
              = GlobaleKonstanten.StadtUmgebungWachstum (GlobaleDatentypen.Endwert, StadtRasseNummerExtern.Rasse)
            then
               StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               Sichtbarkeit.SichtbarkeitsprüfungFürStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
            else
               null;
            end if;
            
         when False =>
            StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             EreignisExtern         => GlobaleDatentypen.Einwohner_Reduktion);
            if
              LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                 EinwohnerArbeiterExtern => True)
              = GlobaleKonstanten.StadtUmgebungWachstum (GlobaleDatentypen.Anfangswert, StadtRasseNummerExtern.Rasse) - 1
              or
                LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => True)
              = GlobaleKonstanten.StadtUmgebungWachstum (GlobaleDatentypen.Endwert, StadtRasseNummerExtern.Rasse) - 1
            then
               StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
            else
               null;
            end if;
      end case;
      
   end WachstumEinwohner;
   
   
   
   procedure WachstumProduktion
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      RessourcenExtern       => LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                      ÄndernSetzenExtern    => True);
      
      case
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when GlobaleKonstanten.LeerBauprojekt =>
            SchreibeWichtiges.Geldmenge (RasseExtern         => StadtRasseNummerExtern.Rasse,
                                         GeldZugewinnExtern  => Integer (LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern)) / 5,
                                         RechnenSetzenExtern => True);
            SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                            RessourcenExtern       => GlobaleKonstanten.LeerStadt.Ressourcen,
                                            ÄndernSetzenExtern     => False);
            
         when GlobaleKonstanten.BauprojekteGebäudeAnfang .. GlobaleKonstanten.BauprojekteGebäudeEnde =>
            if
              LeseStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern)
              >= LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                        IDExtern    => GlobaleDatentypen.GebäudeID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) - GlobaleKonstanten.GebäudeAufschlag))
            then
               StadtGebaeudeBauen.GebäudeFertiggestellt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
            else
               null;
            end if;
          
         when GlobaleKonstanten.BauprojekteEinheitenAnfang .. GlobaleKonstanten.BauprojekteEinheitenEnde =>
            if
              LeseStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern)
              >= LeseEinheitenDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                         IDExtern    => GlobaleDatentypen.EinheitenID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern) - GlobaleKonstanten.EinheitAufschlag))
            then
               StadtEinheitenBauen.EinheitFertiggestellt (StadtRasseNummerExtern => StadtRasseNummerExtern);            

            else
               null;
            end if;

         when others =>
            null;
      end case;
      
   end WachstumProduktion;

end Wachstum;
