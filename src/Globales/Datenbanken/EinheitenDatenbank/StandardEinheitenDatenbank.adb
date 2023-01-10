with EinheitenDatenbank;
with SpeziesDatentypen;

with EinheitenMenschen;
with EinheitenKasrodiah;
with EinheitenLasupin;
with EinheitenLamustra;
with EinheitenManuky;
with EinheitenSuroka;
with EinheitenPryolon;
with EinheitenTalbidahr;
with EinheitenMoruPhisihl;
with EinheitenLarinosLotaris;
with EinheitenCarupex;
with EinheitenAlary;
with EinheitenTesorahn;
with EinheitenNatriesZermanis;
with EinheitenTridatus;
with EinheitenSenelari;
with EinheitenAspari2;
with EinheitenEkropa;

package body StandardEinheitenDatenbank is

   procedure StandardEinheitenDatenbankLaden
   is begin
   
      SpeziesSchleife:
      for SpeziesSchleifenwert in EinheitenDatenbank.EinheitenlisteArray'Range (1) loop
         EinheitenSchleife:
         for EinheitSchleifenwert in EinheitenDatenbank.EinheitenlisteArray'Range (2) loop
            
            case
              SpeziesSchleifenwert
            is
               when SpeziesDatentypen.Menschen_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenMenschen.EinheitenlisteMenschen (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Kasrodiah_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenKasrodiah.EinheitenlisteKasrodiah (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Lasupin_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenLasupin.EinheitenlisteLasupin (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Lamustra_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenLamustra.EinheitenlisteLamustra (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Manuky_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenManuky.EinheitenlisteManuky (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Suroka_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenSuroka.EinheitenlisteSuroka (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Pryolon_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenPryolon.EinheitenlistePryolon (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Moru_Phisihl_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenMoruPhisihl.EinheitenlisteMoruPhisihl (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Larinos_Lotaris_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenLarinosLotaris.EinheitenlisteLarinosLotaris (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Carupex_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenCarupex.EinheitenlisteCarupex (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Alary_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenAlary.EinheitenlisteAlary (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Natries_Zermanis_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenNatriesZermanis.EinheitenlisteNatriesZermanis (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Tridatus_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenTridatus.EinheitenlisteTridatus (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Senelari_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenSenelari.EinheitenlisteSenelari (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Aspari_2_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenAspari2.EinheitenlisteAspari2 (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Ekropa_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenEkropa.EinheitenlisteEkropa (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Tesorahn_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenTesorahn.EinheitenlisteTesorahn (EinheitSchleifenwert);
                  
               when SpeziesDatentypen.Talbidahr_Enum =>
                  EinheitenDatenbank.Einheitenliste (SpeziesSchleifenwert, EinheitSchleifenwert) := EinheitenTalbidahr.EinheitenlisteTalbidahr (EinheitSchleifenwert);
            end case;
            
         end loop EinheitenSchleife;
      end loop SpeziesSchleife;
      
   end StandardEinheitenDatenbankLaden;

end StandardEinheitenDatenbank;
