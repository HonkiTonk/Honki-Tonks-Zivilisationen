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
               when RassenDatentypen.Menschen_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungMenschen.ForschungMenschenListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Kasrodiah_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungKasrodiah.ForschungKasrodiahListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Lasupin_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungLasupin.ForschungLasupinListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Lamustra_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungLamustra.ForschungLamustraListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Manuky_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungManuky.ForschungManukyListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Suroka_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungSuroka.ForschungSurokaListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Pryolon_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungPryolon.ForschungPryolonListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Talbidahr_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungTalbidahr.ForschungTalbidahrListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Moru_Phisihl_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungMoruPhisihl.ForschungMoruPhisihlListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Larinos_Lotaris_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungLarinosLotaris.ForschungLarinosLotarisListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Carupex_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungCarupex.ForschungCarupexListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Alary_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungAlary.ForschungAlaryListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Tesorahn_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungTesorahn.ForschungTesorahnListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Natries_Zermanis_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungNatriesZermanis.ForschungNatriesZermanisListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Tridatus_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungTridatus.ForschungTridatusListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Senelari_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungSenelari.ForschungSenelariListe (ForschungSchleifenwert);
                  
               when RassenDatentypen.Aspari_2_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungAspari2.ForschungAspari2Liste (ForschungSchleifenwert);
                  
               when RassenDatentypen.Ekropa_Enum =>
                  ForschungListe (RasseSchleifenwert, ForschungSchleifenwert) := ForschungEkropa.ForschungEkropaListe (ForschungSchleifenwert);
            end case;
            
         end loop ForschungsSchleife;
      end loop RassenSchleife;
      
   end StandardForschungsDatenbankLaden;

end ForschungsDatenbank;
