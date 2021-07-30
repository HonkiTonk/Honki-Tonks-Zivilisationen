pragma SPARK_Mode (On);

with EinheitenMenschen, EinheitenKasrodiah, EinheitenLasupin, EinheitenLamustra, EinheitenManuky, EinheitenSuroka, EinheitenPryolon, EinheitenTalbidahr, EinheitenMoruPhisihl,
     EinheitenLarinosLotaris, EinheitenCarupex, EinheitenAlary, EinheitenTesorahn, EinheitenNatriesZermanis, EinheitenTridatus, EinheitenSenelari, EinheitenAspari2, EinheitenEkropa;

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
               when GlobaleDatentypen.Menschen =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenMenschen.EinheitenMenschenListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Kasrodiah =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenKasrodiah.EinheitenKasrodiahListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Lasupin =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenLasupin.EinheitenLasupinListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Lamustra =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenLamustra.EinheitenLamustraListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Manuky =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenManuky.EinheitenManukyListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Suroka =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenSuroka.EinheitenSurokaListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Pryolon =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenPryolon.EinheitenPryolonListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Talbidahr =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenTalbidahr.EinheitenTalbidahrListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Moru_Phisihl =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenMoruPhisihl.EinheitenMoruPhisihlListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Larinos_Lotaris =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenLarinosLotaris.EinheitenLarinosLotarisListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Carupex =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenCarupex.EinheitenCarupexListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Alary =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenAlary.EinheitenAlaryListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Tesorahn =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenTesorahn.EinheitenTesorahnListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Natries_Zermanis =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenNatriesZermanis.EinheitenNatriesZermanisListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Tridatus =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenTridatus.EinheitenTridatusListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Senelari =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenSenelari.EinheitenSenelariListe (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Aspari_2 =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenAspari2.EinheitenAspari2Liste (EinheitenSchleifenwert);
                  
               when GlobaleDatentypen.Ekropa =>
                  EinheitenListe (RasseSchleifenwert, EinheitenSchleifenwert) := EinheitenEkropa.EinheitenEkropaListe (EinheitenSchleifenwert);
            end case;
            
         end loop EinheitenSchleife;
      end loop RassenSchleife;
      
   end StandardEinheitenDatenbankLaden;
   
end EinheitenDatenbank;
