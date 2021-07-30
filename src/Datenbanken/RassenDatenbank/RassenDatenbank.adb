pragma SPARK_Mode (On);

with RasseMenschen, RasseKasrodiah, RasseLasupin, RasseLamustra, RasseManuky, RasseSuroka, RassePryolon, RasseTalbidahr, RasseMoruPhisihl, RasseLarinosLotaris, RasseCarupex, RasseAlary,
     RasseTesorahn, RasseNatriesZermanis, RasseTridatus, RasseSenelari, RasseAspari2, RasseEkropa;

package body RassenDatenbank is

   procedure StandardRassenDatenbankLaden
   is begin
      
      RassenListe := (
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
