pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RasseMenschen;
with RasseKasrodiah;
with RasseLasupin;
with RasseLamustra;
with RasseManuky;
with RasseSuroka;
with RassePryolon;
with RasseTalbidahr;
with RasseMoruPhisihl;
with RasseLarinosLotaris;
with RasseCarupex;
with RasseAlary;
with RasseTesorahn;
with RasseNatriesZermanis;
with RasseTridatus;
with RasseSenelari;
with RasseAspari2;
with RasseEkropa;

package body RassenDatenbank is

   procedure StandardRassenDatenbankLaden
   is begin
      
      Rassenliste := (
                      RasseMenschen.RasseMenschenListe,
                      RasseKasrodiah.RasseKasrodiahListe,
                      RasseLasupin.RasseLasupinListe,
                      RasseLamustra.RasseLamustraListe,
                      RasseManuky.RasseManukyListe,
                      RasseSuroka.RasseSurokaListe,
                      RassePryolon.RassePryolonListe,
                      RasseTalbidahr.RasseTalbidahrListe,
                      RasseMoruPhisihl.RasseMoruPhisihlListe,
                      RasseLarinosLotaris.RasseLarinosLotarisListe,
                      RasseCarupex.RasseCarupexListe,
                      RasseAlary.RasseAlaryListe,
                      RasseTesorahn.RasseTesorahnListe,
                      RasseNatriesZermanis.RasseNatriesZermanisListe,
                      RasseTridatus.RasseTridatusListe,
                      RasseSenelari.RasseSenelariListe,
                      RasseAspari2.RasseAspari2Liste,
                      RasseEkropa.RasseEkropaListe
                     );
      
   end StandardRassenDatenbankLaden;

end RassenDatenbank;
