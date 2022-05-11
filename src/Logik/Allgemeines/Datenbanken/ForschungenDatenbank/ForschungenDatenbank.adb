pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

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

package body ForschungenDatenbank is
   
   procedure StandardForschungenDatenbankLaden
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
         for MenschenSchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Menschen_Enum, MenschenSchleifenwert) := ForschungenMenschen.ForschungslisteMenschen (MenschenSchleifenwert);

         end loop MenschenSchleife;

      end Menschen;



      task body Kasrodiah
      is begin

         KasrodiahSchleife:
         for KasrodiahSchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Kasrodiah_Enum, KasrodiahSchleifenwert) := ForschungenKasrodiah.ForschungslisteKasrodiah (KasrodiahSchleifenwert);

         end loop KasrodiahSchleife;

      end Kasrodiah;



      task body Lasupin
      is begin

         LasupinSchleife:
         for LasupinSchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Lasupin_Enum, LasupinSchleifenwert) := ForschungenLasupin.ForschungslisteLasupin (LasupinSchleifenwert);

         end loop LasupinSchleife;

      end Lasupin;



      task body Lamustra
      is begin

         LamustraSchleife:
         for LamustraSchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Lamustra_Enum, LamustraSchleifenwert) := ForschungenLamustra.ForschungslisteLamustra (LamustraSchleifenwert);

         end loop LamustraSchleife;

      end Lamustra;



      task body Manuky
      is begin

         ManukySchleife:
         for ManukySchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Manuky_Enum, ManukySchleifenwert) := ForschungenManuky.ForschungslisteManuky (ManukySchleifenwert);

         end loop ManukySchleife;

      end Manuky;



      task body Suroka
      is begin

         SurokaSchleife:
         for SurokaSchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Suroka_Enum, SurokaSchleifenwert) := ForschungenSuroka.ForschungslisteSuroka (SurokaSchleifenwert);

         end loop SurokaSchleife;

      end Suroka;



      task body Pryolon
      is begin

         PryolonSchleife:
         for PryolonSchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Pryolon_Enum, PryolonSchleifenwert) := ForschungenPryolon.ForschungslistePryolon (PryolonSchleifenwert);

         end loop PryolonSchleife;

      end Pryolon;



      task body MoruPhisihl
      is begin

         MoruPhisihlSchleife:
         for MoruPhisihlSchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Moru_Phisihl_Enum, MoruPhisihlSchleifenwert) := ForschungenMoruPhisihl.ForschungslisteMoruPhisihl (MoruPhisihlSchleifenwert);

         end loop MoruPhisihlSchleife;

      end MoruPhisihl;



      task body LarinosLotaris
      is begin

         LarinosLotarisSchleife:
         for LarinosLotarisSchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Larinos_Lotaris_Enum, LarinosLotarisSchleifenwert) := ForschungenLarinosLotaris.ForschungslisteLarinosLotaris (LarinosLotarisSchleifenwert);

         end loop LarinosLotarisSchleife;

      end LarinosLotaris;
      


      task body Carupex
      is begin

         CarupexSchleife:
         for CarupexSchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Carupex_Enum, CarupexSchleifenwert) := ForschungenCarupex.ForschungslisteCarupex (CarupexSchleifenwert);

         end loop CarupexSchleife;

      end Carupex;



      task body Alary
      is begin

         AlarySchleife:
         for AlarySchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Alary_Enum, AlarySchleifenwert) := ForschungenAlary.ForschungslisteAlary (AlarySchleifenwert);

         end loop AlarySchleife;

      end Alary;



      task body NatriesZermanis
      is begin

         NatriesZermanisSchleife:
         for NatriesZermanisSchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Natries_Zermanis_Enum, NatriesZermanisSchleifenwert) := ForschungenNatriesZermanis.ForschungslisteNatriesZermanis (NatriesZermanisSchleifenwert);

         end loop NatriesZermanisSchleife;

      end NatriesZermanis;



      task body Tridatus
      is begin

         TridatusSchleife:
         for TridatusSchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Tridatus_Enum, TridatusSchleifenwert) := ForschungenTridatus.ForschungslisteTridatus (TridatusSchleifenwert);

         end loop TridatusSchleife;

      end Tridatus;



      task body Senelari
      is begin

         SenelariSchleife:
         for SenelariSchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Senelari_Enum, SenelariSchleifenwert) := ForschungenSenelari.ForschungslisteSenelari (SenelariSchleifenwert);

         end loop SenelariSchleife;

      end Senelari;



      task body Aspari2
      is begin

         Aspari2Schleife:
         for Aspari2Schleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Aspari_2_Enum, Aspari2Schleifenwert) := ForschungenAspari2.ForschungslisteAspari2 (Aspari2Schleifenwert);

         end loop Aspari2Schleife;

      end Aspari2;



      task body Ekropa
      is begin

         EkropaSchleife:
         for EkropaSchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Ekropa_Enum, EkropaSchleifenwert) := ForschungenEkropa.ForschungslisteEkropa (EkropaSchleifenwert);

         end loop EkropaSchleife;

      end Ekropa;



      task body Tesorahn
      is begin

         TesorahnSchleife:
         for TesorahnSchleifenwert in ForschungslisteArray'Range (2) loop

            Forschungsliste (RassenDatentypen.Tesorahn_Enum, TesorahnSchleifenwert) := ForschungenTesorahn.ForschungslisteTesorahn (TesorahnSchleifenwert);

         end loop TesorahnSchleife;

      end Tesorahn;

   begin

      TalbidahrSchleife:
      for TalbidahrSchleifenwert in ForschungslisteArray'Range (2) loop

         Forschungsliste (RassenDatentypen.Talbidahr_Enum, TalbidahrSchleifenwert) := ForschungenTalbidahr.ForschungslisteTalbidahr (TalbidahrSchleifenwert);

      end loop TalbidahrSchleife;
      
   end StandardForschungenDatenbankLaden;

end ForschungenDatenbank;
