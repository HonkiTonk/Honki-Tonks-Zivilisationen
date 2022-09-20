pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GebaeudeMenschen;
with GebaeudeKasrodiah;
with GebaeudeLasupin;
with GebaeudeLamustra;
with GebaeudeManuky;
with GebaeudeSuroka;
with GebaeudePryolon;
with GebaeudeTalbidahr;
with GebaeudeMoruPhisihl;
with GebaeudeLarinosLotaris;
with GebaeudeCarupex;
with GebaeudeAlary;
with GebaeudeTesorahn;
with GebaeudeNatriesZermanis;
with GebaeudeTridatus;
with GebaeudeSenelari;
with GebaeudeAspari2;
with GebaeudeEkropa;

-- Diese Parallelisierungen wieder entfernen, sind ziemlich Unsinn, wenn überhaupt dann wäre es vermutlich sinnvollder alles gleichzeitig einzulesen. äöü
package body GebaeudeDatenbank is
   
   procedure StandardGebaeudeDatenbankLaden
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
         for MenschenSchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Menschen_Enum, MenschenSchleifenwert) := GebaeudeMenschen.GebäudelisteMenschen (MenschenSchleifenwert);

         end loop MenschenSchleife;

      end Menschen;



      task body Kasrodiah
      is begin

         KasrodiahSchleife:
         for KasrodiahSchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Kasrodiah_Enum, KasrodiahSchleifenwert) := GebaeudeKasrodiah.GebäudelisteKasrodiah (KasrodiahSchleifenwert);

         end loop KasrodiahSchleife;

      end Kasrodiah;



      task body Lasupin
      is begin

         LasupinSchleife:
         for LasupinSchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Lasupin_Enum, LasupinSchleifenwert) := GebaeudeLasupin.GebäudelisteLasupin (LasupinSchleifenwert);

         end loop LasupinSchleife;

      end Lasupin;



      task body Lamustra
      is begin

         LamustraSchleife:
         for LamustraSchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Lamustra_Enum, LamustraSchleifenwert) := GebaeudeLamustra.GebäudelisteLamustra (LamustraSchleifenwert);

         end loop LamustraSchleife;

      end Lamustra;



      task body Manuky
      is begin

         ManukySchleife:
         for ManukySchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Manuky_Enum, ManukySchleifenwert) := GebaeudeManuky.GebäudelisteManuky (ManukySchleifenwert);

         end loop ManukySchleife;

      end Manuky;



      task body Suroka
      is begin

         SurokaSchleife:
         for SurokaSchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Suroka_Enum, SurokaSchleifenwert) := GebaeudeSuroka.GebäudelisteSuroka (SurokaSchleifenwert);

         end loop SurokaSchleife;

      end Suroka;



      task body Pryolon
      is begin

         PryolonSchleife:
         for PryolonSchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Pryolon_Enum, PryolonSchleifenwert) := GebaeudePryolon.GebäudelistePryolon (PryolonSchleifenwert);

         end loop PryolonSchleife;

      end Pryolon;



      task body MoruPhisihl
      is begin

         MoruPhisihlSchleife:
         for MoruPhisihlSchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Moru_Phisihl_Enum, MoruPhisihlSchleifenwert) := GebaeudeMoruPhisihl.GebäudelisteMoruPhisihl (MoruPhisihlSchleifenwert);

         end loop MoruPhisihlSchleife;

      end MoruPhisihl;



      task body LarinosLotaris
      is begin

         LarinosLotarisSchleife:
         for LarinosLotarisSchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Larinos_Lotaris_Enum, LarinosLotarisSchleifenwert) := GebaeudeLarinosLotaris.GebäudelisteLarinosLotaris (LarinosLotarisSchleifenwert);

         end loop LarinosLotarisSchleife;

      end LarinosLotaris;



      task body Carupex
      is begin

         CarupexSchleife:
         for CarupexSchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Carupex_Enum, CarupexSchleifenwert) := GebaeudeCarupex.GebäudelisteCarupex (CarupexSchleifenwert);

         end loop CarupexSchleife;

      end Carupex;



      task body Alary
      is begin

         AlarySchleife:
         for AlarySchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Alary_Enum, AlarySchleifenwert) := GebaeudeAlary.GebäudelisteAlary (AlarySchleifenwert);

         end loop AlarySchleife;

      end Alary;



      task body NatriesZermanis
      is begin

         NatriesZermanisSchleife:
         for NatriesZermanisSchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Natries_Zermanis_Enum, NatriesZermanisSchleifenwert) := GebaeudeNatriesZermanis.GebäudelisteNatriesZermanis (NatriesZermanisSchleifenwert);

         end loop NatriesZermanisSchleife;

      end NatriesZermanis;



      task body Tridatus
      is begin

         TridatusSchleife:
         for TridatusSchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Tridatus_Enum, TridatusSchleifenwert) := GebaeudeTridatus.GebäudelisteTridatus (TridatusSchleifenwert);

         end loop TridatusSchleife;

      end Tridatus;



      task body Senelari
      is begin

         SenelariSchleife:
         for SenelariSchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Senelari_Enum, SenelariSchleifenwert) := GebaeudeSenelari.GebäudelisteSenelari (SenelariSchleifenwert);

         end loop SenelariSchleife;

      end Senelari;



      task body Aspari2
      is begin

         Aspari2Schleife:
         for Aspari2Schleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Aspari_2_Enum, Aspari2Schleifenwert) := GebaeudeAspari2.GebäudelisteAspari2 (Aspari2Schleifenwert);

         end loop Aspari2Schleife;

      end Aspari2;



      task body Ekropa
      is begin

         EkropaSchleife:
         for EkropaSchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Ekropa_Enum, EkropaSchleifenwert) := GebaeudeEkropa.GebäudelisteEkropa (EkropaSchleifenwert);

         end loop EkropaSchleife;

      end Ekropa;



      task body Tesorahn
      is begin

         TesorahnSchleife:
         for TesorahnSchleifenwert in GebäudelisteArray'Range (2) loop

            Gebäudeliste (RassenDatentypen.Tesorahn_Enum, TesorahnSchleifenwert) := GebaeudeTesorahn.GebäudelisteTesorahn (TesorahnSchleifenwert);

         end loop TesorahnSchleife;

      end Tesorahn;

   begin

      TalbidahrSchleife:
      for TalbidahrSchleifenwert in GebäudelisteArray'Range (2) loop

         Gebäudeliste (RassenDatentypen.Talbidahr_Enum, TalbidahrSchleifenwert) := GebaeudeTalbidahr.GebäudelisteTalbidahr (TalbidahrSchleifenwert);

      end loop TalbidahrSchleife;
      
   end StandardGebaeudeDatenbankLaden;

end GebaeudeDatenbank;
