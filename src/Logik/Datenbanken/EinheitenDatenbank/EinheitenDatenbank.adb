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
      for RasseSchleifenwert in EinheitenListe'Range (1) loop
         EinheitenSchleife:
         for EinheitenSchleifenwert in EinheitenListe'Range (2) loop
            
            case
              RasseSchleifenwert
            is
               when SystemDatentypen.Menschen_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenMenschen.EinheitenMenschenListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Kasrodiah_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenKasrodiah.EinheitenKasrodiahListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Lasupin_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenLasupin.EinheitenLasupinListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Lamustra_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenLamustra.EinheitenLamustraListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Manuky_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenManuky.EinheitenManukyListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Suroka_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenSuroka.EinheitenSurokaListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Pryolon_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenPryolon.EinheitenPryolonListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Talbidahr_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenTalbidahr.EinheitenTalbidahrListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Moru_Phisihl_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenMoruPhisihl.EinheitenMoruPhisihlListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Larinos_Lotaris_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenLarinosLotaris.EinheitenLarinosLotarisListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Carupex_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenCarupex.EinheitenCarupexListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Alary_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenAlary.EinheitenAlaryListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Tesorahn_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenTesorahn.EinheitenTesorahnListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Natries_Zermanis_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenNatriesZermanis.EinheitenNatriesZermanisListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Tridatus_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenTridatus.EinheitenTridatusListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Senelari_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenSenelari.EinheitenSenelariListe (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Aspari_2_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenAspari2.EinheitenAspari2Liste (EinheitenSchleifenwert);
                  
               when SystemDatentypen.Ekropa_Enum =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenEkropa.EinheitenEkropaListe (EinheitenSchleifenwert);
            end case;
            
         end loop EinheitenSchleife;
      end loop RassenSchleife;
      
   end StandardEinheitenDatenbankLaden;
   
end EinheitenDatenbank;
