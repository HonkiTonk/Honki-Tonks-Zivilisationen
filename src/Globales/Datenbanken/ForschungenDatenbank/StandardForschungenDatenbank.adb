with ForschungenDatenbank;
with ForschungRecordKonstanten;

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
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in ForschungenDatenbank.ForschungslisteArray'Range (1) loop
                          
         StandardTechnologienLaden (SpeziesExtern => SpeziesSchleifenwert);
         
         ForschungenSchleife:
         for ForschungSchleifenwert in ForschungenDatenbank.ForschungslisteArray'Range (2) loop
            
            case
              SpeziesSchleifenwert
            is
               when SpeziesDatentypen.Menschen_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenMenschen.ForschungslisteMenschen (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Kasrodiah_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenKasrodiah.ForschungslisteKasrodiah (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Lasupin_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenLasupin.ForschungslisteLasupin (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Lamustra_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenLamustra.ForschungslisteLamustra (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Manuky_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenManuky.ForschungslisteManuky (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Suroka_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenSuroka.ForschungslisteSuroka (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Pryolon_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenPryolon.ForschungslistePryolon (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Moru_Phisihl_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenMoruPhisihl.ForschungslisteMoruPhisihl (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Larinos_Lotaris_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenLarinosLotaris.ForschungslisteLarinosLotaris (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Carupex_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenCarupex.ForschungslisteCarupex (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Alary_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenAlary.ForschungslisteAlary (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Natries_Zermanis_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenNatriesZermanis.ForschungslisteNatriesZermanis (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Tridatus_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenTridatus.ForschungslisteTridatus (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Senelari_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenSenelari.ForschungslisteSenelari (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Aspari_2_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenAspari2.ForschungslisteAspari2 (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Ekropa_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenEkropa.ForschungslisteEkropa (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Tesorahn_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenTesorahn.ForschungslisteTesorahn (ForschungSchleifenwert);
                  
               when SpeziesDatentypen.Talbidahr_Enum =>
                  ForschungenDatenbank.Forschungsliste (SpeziesSchleifenwert, ForschungSchleifenwert) := ForschungenTalbidahr.ForschungslisteTalbidahr (ForschungSchleifenwert);
            end case;
            
         end loop ForschungenSchleife;
      end loop SpeziesSchleife;
      
   end StandardForschungenDatenbankLaden;
   
   
   
   procedure StandardTechnologienLaden
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      VerbesserungenSchleife:
      for VerbesserungSchleifenwert in ForschungRecordKonstanten.TechnologieVerbesserungenArray'Range (1) loop
         
         ForschungenDatenbank.TechnologieVerbesserungen (VerbesserungSchleifenwert, SpeziesExtern) := ForschungRecordKonstanten.StandardtechnologieVerbesserungen (VerbesserungSchleifenwert, SpeziesExtern);
         
      end loop VerbesserungenSchleife;
      
      
      
      WegeSchleife:
      for WegSchleifenwert in ForschungRecordKonstanten.TechnologieWegeArray'Range (1) loop
         
         ForschungenDatenbank.TechnologieWege (WegSchleifenwert, SpeziesExtern) := ForschungRecordKonstanten.StandardtechnologieWege (WegSchleifenwert, SpeziesExtern);
         
      end loop WegeSchleife;
      
      
      
      UmgebungSchleife:
      for UmgebungSchleifenwert in ForschungRecordKonstanten.TechnologieUmgebungsgrößeArray'Range (1) loop
         
         ForschungenDatenbank.TechnologieUmgebungsgröße (UmgebungSchleifenwert, SpeziesExtern) := ForschungRecordKonstanten.StandardtechnologieUmgebungsgröße (UmgebungSchleifenwert, SpeziesExtern);
         
      end loop UmgebungSchleife;
      
   end StandardTechnologienLaden;

end StandardForschungenDatenbank;
