with ForschungenDatenbank;
with ForschungKonstanten;

with ForschungenMenschen;
with ForschungenKasrodiah;
with ForschungenLasupin;
with ForschungenLamustra;
with ForschungenManuky;
with ForschungenSuroka;
with ForschungenPryolon;
with ForschungenTalbidahr;
with ForschungenMoruPhisihl;
with ForschungenLarinosLotaris;
with ForschungenCarupex;
with ForschungenAlary;
with ForschungenTesorahn;
with ForschungenNatriesZermanis;
with ForschungenTridatus;
with ForschungenSenelari;
with ForschungenAspari2;
with ForschungenEkropa;

package body StandardForschungenDatenbank is

   procedure StandardForschungenDatenbankLaden
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in ForschungenDatenbank.ForschungslisteArray'Range (1) loop
                          
         StandardTechnologienLaden (RasseExtern => RasseSchleifenwert);
         
         ForschungenSchleife:
         for ForschungSchleifenwert in ForschungenDatenbank.ForschungslisteArray'Range (2) loop
            
            case
              RasseSchleifenwert
            is
               when RassenDatentypen.Menschen_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenMenschen.ForschungslisteMenschen (ForschungSchleifenwert);
                  
               when RassenDatentypen.Kasrodiah_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenKasrodiah.ForschungslisteKasrodiah (ForschungSchleifenwert);
                  
               when RassenDatentypen.Lasupin_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenLasupin.ForschungslisteLasupin (ForschungSchleifenwert);
                  
               when RassenDatentypen.Lamustra_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenLamustra.ForschungslisteLamustra (ForschungSchleifenwert);
                  
               when RassenDatentypen.Manuky_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenManuky.ForschungslisteManuky (ForschungSchleifenwert);
                  
               when RassenDatentypen.Suroka_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenSuroka.ForschungslisteSuroka (ForschungSchleifenwert);
                  
               when RassenDatentypen.Pryolon_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenPryolon.ForschungslistePryolon (ForschungSchleifenwert);
                  
               when RassenDatentypen.Moru_Phisihl_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenMoruPhisihl.ForschungslisteMoruPhisihl (ForschungSchleifenwert);
                  
               when RassenDatentypen.Larinos_Lotaris_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenLarinosLotaris.ForschungslisteLarinosLotaris (ForschungSchleifenwert);
                  
               when RassenDatentypen.Carupex_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenCarupex.ForschungslisteCarupex (ForschungSchleifenwert);
                  
               when RassenDatentypen.Alary_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenAlary.ForschungslisteAlary (ForschungSchleifenwert);
                  
               when RassenDatentypen.Natries_Zermanis_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenNatriesZermanis.ForschungslisteNatriesZermanis (ForschungSchleifenwert);
                  
               when RassenDatentypen.Tridatus_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenTridatus.ForschungslisteTridatus (ForschungSchleifenwert);
                  
               when RassenDatentypen.Senelari_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenSenelari.ForschungslisteSenelari (ForschungSchleifenwert);
                  
               when RassenDatentypen.Aspari_2_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenAspari2.ForschungslisteAspari2 (ForschungSchleifenwert);
                  
               when RassenDatentypen.Ekropa_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenEkropa.ForschungslisteEkropa (ForschungSchleifenwert);
                  
               when RassenDatentypen.Tesorahn_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenTesorahn.ForschungslisteTesorahn (ForschungSchleifenwert);
                  
               when RassenDatentypen.Talbidahr_Enum =>
                  ForschungenDatenbank.Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenTalbidahr.ForschungslisteTalbidahr (ForschungSchleifenwert);
            end case;
            
         end loop ForschungenSchleife;
      end loop RassenSchleife;
      
   end StandardForschungenDatenbankLaden;
   
   
   
   procedure StandardTechnologienLaden
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      VerbesserungenSchleife:
      for VerbesserungSchleifenwert in ForschungKonstanten.TechnologieVerbesserungenArray'Range (1) loop
         
         ForschungenDatenbank.TechnologieVerbesserungen (VerbesserungSchleifenwert, RasseExtern) := ForschungKonstanten.StandardtechnologieVerbesserungen (VerbesserungSchleifenwert, RasseExtern);
         
      end loop VerbesserungenSchleife;
      
      
      
      WegeSchleife:
      for WegSchleifenwert in ForschungKonstanten.TechnologieWegeArray'Range (1) loop
         
         ForschungenDatenbank.TechnologieWege (WegSchleifenwert, RasseExtern) := ForschungKonstanten.StandardtechnologieWege (WegSchleifenwert, RasseExtern);
         
      end loop WegeSchleife;
      
      
      
      UmgebungSchleife:
      for UmgebungSchleifenwert in ForschungKonstanten.TechnologieUmgebungsgrößeArray'Range (1) loop
         
         ForschungenDatenbank.TechnologieUmgebungsgröße (UmgebungSchleifenwert, RasseExtern) := ForschungKonstanten.StandardtechnologieUmgebungsgröße (UmgebungSchleifenwert, RasseExtern);
         
      end loop UmgebungSchleife;
      
   end StandardTechnologienLaden;

end StandardForschungenDatenbank;
