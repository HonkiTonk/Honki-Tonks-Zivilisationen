with EinheitenDatenbank;
with RassenDatentypen;

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
   
      RassenSchleife:
      for RasseSchleifenwert in EinheitenDatenbank.EinheitenlisteArray'Range (1) loop
         EinheitenSchleife:
         for EinheitSchleifenwert in EinheitenDatenbank.EinheitenlisteArray'Range (2) loop
            
            case
              RasseSchleifenwert
            is
               when RassenDatentypen.Menschen_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenMenschen.EinheitenlisteMenschen (EinheitSchleifenwert);
                  
               when RassenDatentypen.Kasrodiah_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenKasrodiah.EinheitenlisteKasrodiah (EinheitSchleifenwert);
                  
               when RassenDatentypen.Lasupin_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenLasupin.EinheitenlisteLasupin (EinheitSchleifenwert);
                  
               when RassenDatentypen.Lamustra_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenLamustra.EinheitenlisteLamustra (EinheitSchleifenwert);
                  
               when RassenDatentypen.Manuky_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenManuky.EinheitenlisteManuky (EinheitSchleifenwert);
                  
               when RassenDatentypen.Suroka_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenSuroka.EinheitenlisteSuroka (EinheitSchleifenwert);
                  
               when RassenDatentypen.Pryolon_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenPryolon.EinheitenlistePryolon (EinheitSchleifenwert);
                  
               when RassenDatentypen.Moru_Phisihl_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenMoruPhisihl.EinheitenlisteMoruPhisihl (EinheitSchleifenwert);
                  
               when RassenDatentypen.Larinos_Lotaris_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenLarinosLotaris.EinheitenlisteLarinosLotaris (EinheitSchleifenwert);
                  
               when RassenDatentypen.Carupex_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenCarupex.EinheitenlisteCarupex (EinheitSchleifenwert);
                  
               when RassenDatentypen.Alary_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenAlary.EinheitenlisteAlary (EinheitSchleifenwert);
                  
               when RassenDatentypen.Natries_Zermanis_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenNatriesZermanis.EinheitenlisteNatriesZermanis (EinheitSchleifenwert);
                  
               when RassenDatentypen.Tridatus_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenTridatus.EinheitenlisteTridatus (EinheitSchleifenwert);
                  
               when RassenDatentypen.Senelari_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenSenelari.EinheitenlisteSenelari (EinheitSchleifenwert);
                  
               when RassenDatentypen.Aspari_2_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenAspari2.EinheitenlisteAspari2 (EinheitSchleifenwert);
                  
               when RassenDatentypen.Ekropa_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenEkropa.EinheitenlisteEkropa (EinheitSchleifenwert);
                  
               when RassenDatentypen.Tesorahn_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenTesorahn.EinheitenlisteTesorahn (EinheitSchleifenwert);
                  
               when RassenDatentypen.Talbidahr_Enum =>
                  EinheitenDatenbank.Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenTalbidahr.EinheitenlisteTalbidahr (EinheitSchleifenwert);
            end case;
            
         end loop EinheitenSchleife;
      end loop RassenSchleife;
      
   end StandardEinheitenDatenbankLaden;

end StandardEinheitenDatenbank;
