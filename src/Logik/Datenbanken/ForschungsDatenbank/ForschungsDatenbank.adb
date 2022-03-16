pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungMenschen;
with ForschungKasrodiah;
with ForschungLasupin;
with ForschungLamustra;
with ForschungManuky;
with ForschungSuroka;
with ForschungPryolon;
with ForschungTalbidahr;
with ForschungMoruPhisihl;
with ForschungLarinosLotaris;
with ForschungCarupex;
with ForschungAlary;
with ForschungTesorahn;
with ForschungNatriesZermanis;
with ForschungTridatus;
with ForschungSenelari;
with ForschungAspari2;
with ForschungEkropa;

package body ForschungsDatenbank is
   
   procedure StandardForschungsDatenbankLaden
   is begin
            
      RassenSchleife:
      for RasseSchleifenwert in ForschungListe'Range (1) loop
         ForschungsSchleife:
         for ForschungSchleifenwert in ForschungListe'Range (2) loop
            
            case
              RasseSchleifenwert
            is
               when SystemDatentypen.Menschen_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungMenschen.ForschungMenschenListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Kasrodiah_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungKasrodiah.ForschungKasrodiahListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Lasupin_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungLasupin.ForschungLasupinListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Lamustra_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungLamustra.ForschungLamustraListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Manuky_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungManuky.ForschungManukyListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Suroka_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungSuroka.ForschungSurokaListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Pryolon_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungPryolon.ForschungPryolonListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Talbidahr_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungTalbidahr.ForschungTalbidahrListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Moru_Phisihl_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungMoruPhisihl.ForschungMoruPhisihlListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Larinos_Lotaris_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungLarinosLotaris.ForschungLarinosLotarisListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Carupex_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungCarupex.ForschungCarupexListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Alary_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungAlary.ForschungAlaryListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Tesorahn_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungTesorahn.ForschungTesorahnListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Natries_Zermanis_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungNatriesZermanis.ForschungNatriesZermanisListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Tridatus_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungTridatus.ForschungTridatusListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Senelari_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungSenelari.ForschungSenelariListe (ForschungSchleifenwert);
                  
               when SystemDatentypen.Aspari_2_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungAspari2.ForschungAspari2Liste (ForschungSchleifenwert);
                  
               when SystemDatentypen.Ekropa_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungEkropa.ForschungEkropaListe (ForschungSchleifenwert);
            end case;
            
         end loop ForschungsSchleife;
      end loop RassenSchleife;
      
   end StandardForschungsDatenbankLaden;

end ForschungsDatenbank;
