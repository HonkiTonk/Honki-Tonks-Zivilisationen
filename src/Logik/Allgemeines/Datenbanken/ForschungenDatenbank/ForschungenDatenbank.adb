pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

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

package body ForschungenDatenbank is
   
   procedure StandardForschungenDatenbankLaden
   is begin
            
      RassenSchleife:
      for RasseSchleifenwert in ForschungslisteArray'Range (1) loop
         ForschungenSchleife:
         for ForschungSchleifenwert in ForschungslisteArray'Range (2) loop
            
            case
              RasseSchleifenwert
            is
               when RassenDatentypen.Menschen_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenMenschen.ForschungslisteMenschen (ForschungSchleifenwert);
                  
               when RassenDatentypen.Kasrodiah_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenKasrodiah.ForschungslisteKasrodiah (ForschungSchleifenwert);
                  
               when RassenDatentypen.Lasupin_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenLasupin.ForschungslisteLasupin (ForschungSchleifenwert);
                  
               when RassenDatentypen.Lamustra_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenLamustra.ForschungslisteLamustra (ForschungSchleifenwert);
                  
               when RassenDatentypen.Manuky_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenManuky.ForschungslisteManuky (ForschungSchleifenwert);
                  
               when RassenDatentypen.Suroka_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenSuroka.ForschungslisteSuroka (ForschungSchleifenwert);
                  
               when RassenDatentypen.Pryolon_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenPryolon.ForschungslistePryolon (ForschungSchleifenwert);
                  
               when RassenDatentypen.Talbidahr_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenTalbidahr.ForschungslisteTalbidahr (ForschungSchleifenwert);
                  
               when RassenDatentypen.Moru_Phisihl_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenMoruPhisihl.ForschungslisteMoruPhisihl (ForschungSchleifenwert);
                  
               when RassenDatentypen.Larinos_Lotaris_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenLarinosLotaris.ForschungslisteLarinosLotaris (ForschungSchleifenwert);
                  
               when RassenDatentypen.Carupex_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenCarupex.ForschungslisteCarupex (ForschungSchleifenwert);
                  
               when RassenDatentypen.Alary_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenAlary.ForschungslisteAlary (ForschungSchleifenwert);
                  
               when RassenDatentypen.Tesorahn_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenTesorahn.ForschungslisteTesorahn (ForschungSchleifenwert);
                  
               when RassenDatentypen.Natries_Zermanis_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenNatriesZermanis.ForschungslisteNatriesZermanis (ForschungSchleifenwert);
                  
               when RassenDatentypen.Tridatus_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenTridatus.ForschungslisteTridatus (ForschungSchleifenwert);
                  
               when RassenDatentypen.Senelari_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenSenelari.ForschungslisteSenelari (ForschungSchleifenwert);
                  
               when RassenDatentypen.Aspari_2_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenAspari2.ForschungslisteAspari2 (ForschungSchleifenwert);
                  
               when RassenDatentypen.Ekropa_Enum =>
                  Forschungsliste (RasseSchleifenwert, ForschungSchleifenwert) := ForschungenEkropa.ForschungslisteEkropa (ForschungSchleifenwert);
            end case;
            
         end loop ForschungenSchleife;
      end loop RassenSchleife;
      
   end StandardForschungenDatenbankLaden;

end ForschungenDatenbank;
