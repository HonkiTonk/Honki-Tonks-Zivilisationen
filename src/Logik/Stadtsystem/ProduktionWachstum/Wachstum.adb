pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with StadtDatentypen; use StadtDatentypen;
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
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      SchreibeStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          NahrungsmittelExtern   => LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                          ÄndernSetzenExtern     => True);
      
      VorhandeneNahrung := LeseStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern);

      if
        VorhandeneNahrung > BenötigteNahrung (StadtRasseNummerExtern => StadtRasseNummerExtern)
      then
         WachstumSchrumpfung := NeuerEinwohner (StadtRasseNummerExtern => StadtRasseNummerExtern);

      elsif
        VorhandeneNahrung < StadtKonstanten.LeerNahrungsmittel
      then
         SchreibeStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                             NahrungsmittelExtern   => StadtKonstanten.LeerNahrungsmittel,
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

      EinwohnerÄnderung (StadtRasseNummerExtern    => StadtRasseNummerExtern,
                          WachstumSchrumpfungExtern => WachstumSchrumpfung);
      
   end WachstumEinwohner;
   
   
   
   function BenötigteNahrung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return ProduktionDatentypen.Stadtproduktion
   is begin
      
      return GrundwertEinwohnerwachstum (StadtRasseNummerExtern.Rasse)
        + MultiplikatorEinwohnerwachstum (StadtRasseNummerExtern.Rasse) * ProduktionDatentypen.Produktion (LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                                                              EinwohnerArbeiterExtern => True));
      
   end BenötigteNahrung;
   
   
   
   function NeuerEinwohner
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      SchreibeStadtGebaut.Nahrungsmittel (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                          NahrungsmittelExtern   => StadtKonstanten.LeerStadt.Nahrungsmittel,
                                          ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => True,
                                             WachsenSchrumpfenExtern => True);
      StadtWerteFestlegen.BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                                         StadtRasseNummerExtern   => StadtRasseNummerExtern);
      
      return True;
      
   end NeuerEinwohner;
   
   
   
   procedure EinwohnerÄnderung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      WachstumSchrumpfungExtern : in Boolean)
   is begin
      
      VorhandeneEinwohner := LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                EinwohnerArbeiterExtern => True);
      
      case
        WachstumSchrumpfungExtern
      is
         when True =>
            StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             EreignisExtern         => StadtDatentypen.Einwohner_Wachstum_Enum);
            
            if
              VorhandeneEinwohner = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, StadtRasseNummerExtern.Rasse)
              or
                VorhandeneEinwohner = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, StadtRasseNummerExtern.Rasse)
            then
               StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
               Sichtbarkeit.SichtbarkeitsprüfungFürStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
            else
               null;
            end if;
            
         when False =>
            StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             EreignisExtern         => StadtDatentypen.Einwohner_Reduktion_Enum);
            
            if
              VorhandeneEinwohner = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Anfangswert_Enum, StadtRasseNummerExtern.Rasse) - 1
              or
                VorhandeneEinwohner = StadtKonstanten.StadtUmgebungWachstum (SystemDatentypen.Endwert_Enum, StadtRasseNummerExtern.Rasse) - 1
            then
               StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
            else
               null;
            end if;
      end case;
      
   end EinwohnerÄnderung;
   
   
   
   procedure WachstumProduktion
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      RessourcenExtern       => LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                      ÄndernSetzenExtern     => True);
      
      Bauprojekt := LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern);
        
      if
        Bauprojekt.Gebäude = 0
        and
          Bauprojekt.Einheit = 0
      then
         SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         RessourcenExtern       => StadtKonstanten.LeerRessourcen,
                                         ÄndernSetzenExtern     => False);
         
      elsif
        Bauprojekt.Gebäude /= 0
      then
         if
           LeseStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern)
           >= LeseGebaeudeDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                     IDExtern    => StadtDatentypen.GebäudeID (Bauprojekt.Gebäude))
         then
            StadtGebaeudeBauen.GebäudeFertiggestellt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         else
            null;
         end if;
         
      else
         if
           LeseStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern)
           >= LeseEinheitenDatenbank.PreisRessourcen (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                      IDExtern    => EinheitenDatentypen.EinheitenID (Bauprojekt.Einheit))
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
      
      case
        RasseExtern
      is
         when RassenDatentypen.Ekropa_Enum =>
            null;
            
         when others =>
            SchreibeWichtiges.GeldZugewinnProRunde (RasseExtern         => RasseExtern,
                                                    GeldZugewinnExtern  => WichtigesKonstanten.LeerGeldZugewinnProRunde,
                                                    RechnenSetzenExtern => False);
      end case;
      
      SchreibeWichtiges.GesamteForschungsrate (RasseExtern                  => RasseExtern,
                                               ForschungsrateZugewinnExtern => WichtigesKonstanten.LeerGesamteForschungsrate,
                                               RechnenSetzenExtern          => False);
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
               null;
               
            when others =>
               if
                 RasseExtern = RassenDatentypen.Ekropa_Enum
               then
                  null;
                  
               else
                  SchreibeWichtiges.GeldZugewinnProRunde (RasseExtern         => RasseExtern,
                                                          GeldZugewinnExtern  => LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)),
                                                          RechnenSetzenExtern => True);
               end if;
               
               SchreibeWichtiges.GesamteForschungsrate (RasseExtern                  => RasseExtern,
                                                        ForschungsrateZugewinnExtern => LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)),
                                                        RechnenSetzenExtern          => True);
         end case;
         
      end loop StadtSchleife;
      
   end WachstumsratenBerechnen;

end Wachstum;
