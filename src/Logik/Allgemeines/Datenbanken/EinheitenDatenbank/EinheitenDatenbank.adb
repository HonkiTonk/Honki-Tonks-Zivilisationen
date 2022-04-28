pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

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

package body EinheitenDatenbank is
   
   procedure StandardEinheitenDatenbankLaden
   is begin
            
      RassenSchleife:
      for RasseSchleifenwert in EinheitenlisteArray'Range (1) loop
         EinheitenSchleife:
         for EinheitenSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            case
              RasseSchleifenwert
            is
               when RassenDatentypen.Menschen_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenMenschen.EinheitenlisteMenschen (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Kasrodiah_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenKasrodiah.EinheitenlisteKasrodiah (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Lasupin_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenLasupin.EinheitenlisteLasupin (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Lamustra_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenLamustra.EinheitenlisteLamustra (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Manuky_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenManuky.EinheitenlisteManuky (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Suroka_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenSuroka.EinheitenlisteSuroka (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Pryolon_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenPryolon.EinheitenlistePryolon (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Talbidahr_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenTalbidahr.EinheitenlisteTalbidahr (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Moru_Phisihl_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenMoruPhisihl.EinheitenlisteMoruPhisihl (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Larinos_Lotaris_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenLarinosLotaris.EinheitenlisteLarinosLotaris (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Carupex_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenCarupex.EinheitenlisteCarupex (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Alary_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenAlary.EinheitenlisteAlary (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Tesorahn_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenTesorahn.EinheitenlisteTesorahn (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Natries_Zermanis_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenNatriesZermanis.EinheitenlisteNatriesZermanis (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Tridatus_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenTridatus.EinheitenlisteTridatus (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Senelari_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenSenelari.EinheitenlisteSenelari (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Aspari_2_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenAspari2.EinheitenlisteAspari2 (EinheitenSchleifenwert);
                  
               when RassenDatentypen.Ekropa_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenEkropa.EinheitenlisteEkropa (EinheitenSchleifenwert);
            end case;
            
         end loop EinheitenSchleife;
      end loop RassenSchleife;
      
   end StandardEinheitenDatenbankLaden;
   
end EinheitenDatenbank;
