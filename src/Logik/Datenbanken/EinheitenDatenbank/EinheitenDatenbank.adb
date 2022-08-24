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
   is
   
      task Menschen;
      task Kasrodiah;
      task Lasupin;
      task Lamustra;
      task Manuky;
      task Suroka;
      task Pryolon;
      task MoruPhisihl;
      task LarinosLotaris;
      task Carupex;
      task Alary;
      task NatriesZermanis;
      task Tridatus;
      task Senelari;
      task Aspari2;
      task Ekropa;
      task Tesorahn;
      
      task body Menschen
      is begin
         
         MenschenSchleife:
         for MenschenSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Menschen_Enum, MenschenSchleifenwert) := EinheitenMenschen.EinheitenlisteMenschen (MenschenSchleifenwert);
            
         end loop MenschenSchleife;
         
      end Menschen;
      
      
      
      task body Kasrodiah
      is begin
         
         KasrodiahSchleife:
         for KasrodiahSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Kasrodiah_Enum, KasrodiahSchleifenwert) := EinheitenKasrodiah.EinheitenlisteKasrodiah (KasrodiahSchleifenwert);
            
         end loop KasrodiahSchleife;
         
      end Kasrodiah;
      
      
      
      task body Lasupin
      is begin
         
         LasupinSchleife:
         for LasupinSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Lasupin_Enum, LasupinSchleifenwert) := EinheitenLasupin.EinheitenlisteLasupin (LasupinSchleifenwert);
            
         end loop LasupinSchleife;
         
      end Lasupin;
      
      
      
      task body Lamustra
      is begin
         
         LamustraSchleife:
         for LamustraSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Lamustra_Enum, LamustraSchleifenwert) := EinheitenLamustra.EinheitenlisteLamustra (LamustraSchleifenwert);
            
         end loop LamustraSchleife;
         
      end Lamustra;
      
      
      
      task body Manuky
      is begin
         
         ManukySchleife:
         for ManukySchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Manuky_Enum, ManukySchleifenwert) := EinheitenManuky.EinheitenlisteManuky (ManukySchleifenwert);
            
         end loop ManukySchleife;
         
      end Manuky;
      
      
      
      task body Suroka
      is begin
         
         SurokaSchleife:
         for SurokaSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Suroka_Enum, SurokaSchleifenwert) := EinheitenSuroka.EinheitenlisteSuroka (SurokaSchleifenwert);
            
         end loop SurokaSchleife;
         
      end Suroka;
      
      
      
      task body Pryolon
      is begin
         
         PryolonSchleife:
         for PryolonSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Pryolon_Enum, PryolonSchleifenwert) := EinheitenPryolon.EinheitenlistePryolon (PryolonSchleifenwert);  
            
         end loop PryolonSchleife;
         
      end Pryolon;
      
      
      
      task body MoruPhisihl
      is begin
         
         MoruPhisihlSchleife:
         for MoruPhisihlSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Moru_Phisihl_Enum, MoruPhisihlSchleifenwert) := EinheitenMoruPhisihl.EinheitenlisteMoruPhisihl (MoruPhisihlSchleifenwert);
            
         end loop MoruPhisihlSchleife;
         
      end MoruPhisihl;
      
      
      
      task body LarinosLotaris
      is begin
         
         LarinosLotarisSchleife:
         for LarinosLotarisSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Larinos_Lotaris_Enum, LarinosLotarisSchleifenwert) := EinheitenLarinosLotaris.EinheitenlisteLarinosLotaris (LarinosLotarisSchleifenwert);
            
         end loop LarinosLotarisSchleife;
         
      end LarinosLotaris;
      
      
      
      task body Carupex
      is begin
         
         CarupexSchleife:
         for CarupexSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Carupex_Enum, CarupexSchleifenwert) := EinheitenCarupex.EinheitenlisteCarupex (CarupexSchleifenwert);
            
         end loop CarupexSchleife;
         
      end Carupex;
      
      
      
      task body Alary
      is begin
         
         AlarySchleife:
         for AlarySchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Alary_Enum, AlarySchleifenwert) := EinheitenAlary.EinheitenlisteAlary (AlarySchleifenwert);
            
         end loop AlarySchleife;
         
      end Alary;
      
      
      
      task body NatriesZermanis
      is begin
         
         NatriesZermanisSchleife:
         for NatriesZermanisSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Natries_Zermanis_Enum, NatriesZermanisSchleifenwert) := EinheitenNatriesZermanis.EinheitenlisteNatriesZermanis (NatriesZermanisSchleifenwert);
            
         end loop NatriesZermanisSchleife;
         
      end NatriesZermanis;
      
      
      
      task body Tridatus
      is begin
         
         TridatusSchleife:
         for TridatusSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Tridatus_Enum, TridatusSchleifenwert) := EinheitenTridatus.EinheitenlisteTridatus (TridatusSchleifenwert);
            
         end loop TridatusSchleife;
         
      end Tridatus;
      
      
      
      task body Senelari
      is begin
         
         SenelariSchleife:
         for SenelariSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Senelari_Enum, SenelariSchleifenwert) := EinheitenSenelari.EinheitenlisteSenelari (SenelariSchleifenwert);
            
         end loop SenelariSchleife;
         
      end Senelari;
      
      
      
      task body Aspari2
      is begin
         
         Aspari2Schleife:
         for Aspari2Schleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Aspari_2_Enum, Aspari2Schleifenwert) := EinheitenAspari2.EinheitenlisteAspari2 (Aspari2Schleifenwert);
            
         end loop Aspari2Schleife;
         
      end Aspari2;
      
      
      
      task body Ekropa
      is begin
         
         EkropaSchleife:
         for EkropaSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Ekropa_Enum, EkropaSchleifenwert) := EinheitenEkropa.EinheitenlisteEkropa (EkropaSchleifenwert);
            
         end loop EkropaSchleife;
         
      end Ekropa;
      
      
      
      task body Tesorahn
      is begin
         
         TesorahnSchleife:
         for TesorahnSchleifenwert in EinheitenlisteArray'Range (2) loop
            
            Einheitenliste (RassenDatentypen.Tesorahn_Enum, TesorahnSchleifenwert) := EinheitenTesorahn.EinheitenlisteTesorahn (TesorahnSchleifenwert);
            
         end loop TesorahnSchleife;
         
      end Tesorahn;
   
   begin
         
      TalbidahrSchleife:
      for TalbidahrSchleifenwert in EinheitenlisteArray'Range (2) loop
            
         Einheitenliste (RassenDatentypen.Talbidahr_Enum, TalbidahrSchleifenwert) := EinheitenTalbidahr.EinheitenlisteTalbidahr (TalbidahrSchleifenwert);
            
      end loop TalbidahrSchleife;
      
   end StandardEinheitenDatenbankLaden;
   
end EinheitenDatenbank;
