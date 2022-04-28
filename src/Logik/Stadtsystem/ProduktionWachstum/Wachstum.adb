pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with WichtigesKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with KartenVerbesserungDatentypen;
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
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SonstigeVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                  
                  case
                    LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseSchleifenwert, StadtSchleifenwert))
                  is
                     when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
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
                                                             EreignisExtern         => EinheitStadtDatentypen.Einwohner_Wachstum_Enum);
            if
              LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                 EinwohnerArbeiterExtern => True)
              = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, StadtRasseNummerExtern.Rasse)
              or
                LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => True)
              = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, StadtRasseNummerExtern.Rasse)
            then
               StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               Sichtbarkeit.SichtbarkeitsprüfungFürStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
            else
               null;
            end if;
            
         when False =>
            StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             EreignisExtern         => EinheitStadtDatentypen.Einwohner_Reduktion_Enum);
            if
              LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                 EinwohnerArbeiterExtern => True)
              = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, StadtRasseNummerExtern.Rasse) - 1
              or
                LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => True)
              = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, StadtRasseNummerExtern.Rasse) - 1
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
      
      if
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer = 0
      then
         
         SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         RessourcenExtern       => StadtKonstanten.LeerStadt.Ressourcen,
                                         ÄndernSetzenExtern     => False);
         
      elsif
        LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).GebäudeEinheit = True
      then
         if
           LeseStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern)
           >= LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                     IDExtern    => EinheitStadtDatentypen.GebäudeID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer))
         then
            StadtGebaeudeBauen.GebäudeFertiggestellt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         else
            null;
         end if;
         
      else
         if
           LeseStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern)
           >= LeseEinheitenDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                      IDExtern    => EinheitStadtDatentypen.EinheitenID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Nummer))
         then
            StadtEinheitenBauen.EinheitFertiggestellt (StadtRasseNummerExtern => StadtRasseNummerExtern);

         else
            null;
         end if;
      end if;
      
   end WachstumProduktion;
   
   
   
   procedure WachstumWichtiges
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
      
      case
        RasseExtern
      is
         when EinheitenKonstanten.LeerRasse =>
            RassenSchleife:
            for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
               
               case
                 SonstigeVariablen.RassenImSpiel (RasseSchleifenwert)
               is
                  when RassenDatentypen.Leer_Spieler_Enum =>
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
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SchreibeWichtiges.GeldZugewinnProRunde (RasseExtern         => RasseExtern,
                                              GeldZugewinnExtern  => WichtigesKonstanten.LeerWichtigesZeug.GeldZugewinnProRunde,
                                              RechnenSetzenExtern => False);
      SchreibeWichtiges.GesamteForschungsrate (RasseExtern                  => RasseExtern,
                                               ForschungsrateZugewinnExtern => WichtigesKonstanten.LeerWichtigesZeug.GesamteForschungsrate,
                                               RechnenSetzenExtern          => False);
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
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