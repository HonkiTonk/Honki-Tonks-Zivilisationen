pragma Warnings (Off, "*array aggregate*");

with SchreibenDatenbankenLogik;

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
         for EinheitSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            case
              RasseSchleifenwert
            is
               when RassenDatentypen.Menschen_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenMenschen.EinheitenlisteMenschen (EinheitSchleifenwert);
                  
               when RassenDatentypen.Kasrodiah_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenKasrodiah.EinheitenlisteKasrodiah (EinheitSchleifenwert);
                  
               when RassenDatentypen.Lasupin_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenLasupin.EinheitenlisteLasupin (EinheitSchleifenwert);
                  
               when RassenDatentypen.Lamustra_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenLamustra.EinheitenlisteLamustra (EinheitSchleifenwert);
                  
               when RassenDatentypen.Manuky_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenManuky.EinheitenlisteManuky (EinheitSchleifenwert);
                  
               when RassenDatentypen.Suroka_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenSuroka.EinheitenlisteSuroka (EinheitSchleifenwert);
                  
               when RassenDatentypen.Pryolon_Enum =>
                 Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenPryolon.EinheitenlistePryolon (EinheitSchleifenwert);
                  
               when RassenDatentypen.Moru_Phisihl_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenMoruPhisihl.EinheitenlisteMoruPhisihl (EinheitSchleifenwert);
                  
               when RassenDatentypen.Larinos_Lotaris_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenLarinosLotaris.EinheitenlisteLarinosLotaris (EinheitSchleifenwert);
                  
               when RassenDatentypen.Carupex_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenCarupex.EinheitenlisteCarupex (EinheitSchleifenwert);
                  
               when RassenDatentypen.Alary_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenAlary.EinheitenlisteAlary (EinheitSchleifenwert);
                  
               when RassenDatentypen.Natries_Zermanis_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenNatriesZermanis.EinheitenlisteNatriesZermanis (EinheitSchleifenwert);
                  
               when RassenDatentypen.Tridatus_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenTridatus.EinheitenlisteTridatus (EinheitSchleifenwert);
                  
               when RassenDatentypen.Senelari_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenSenelari.EinheitenlisteSenelari (EinheitSchleifenwert);
                  
               when RassenDatentypen.Aspari_2_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenAspari2.EinheitenlisteAspari2 (EinheitSchleifenwert);
                  
               when RassenDatentypen.Ekropa_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenEkropa.EinheitenlisteEkropa (EinheitSchleifenwert);
                  
               when RassenDatentypen.Tesorahn_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenTesorahn.EinheitenlisteTesorahn (EinheitSchleifenwert);
                  
               when RassenDatentypen.Talbidahr_Enum =>
                  Einheitenliste (RasseSchleifenwert, EinheitSchleifenwert) := EinheitenTalbidahr.EinheitenlisteTalbidahr (EinheitSchleifenwert);
            end case;
            
         end loop EinheitenSchleife;
      end loop RassenSchleife;
      
   end StandardEinheitenDatenbankLaden;
   
   

   procedure EinheitenDatenbankSpeichern
   is begin
      
      SchreibenDatenbankenLogik.SchreibenEinheitenDatenbank;
      
   end EinheitenDatenbankSpeichern;
   
end EinheitenDatenbank;
