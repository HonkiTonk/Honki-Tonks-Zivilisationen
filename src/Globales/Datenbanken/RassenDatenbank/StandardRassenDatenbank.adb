with RassenDatenbank;

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

package body StandardRassenDatenbank is

   -- Das hier später auch mal anpassen oder entfernen. äöü
   procedure StandardRassenDatenbankLaden
   is begin
      
      RassenDatenbank.Rassenliste := (
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
      
      -- Kann wegen dam Kompilerfehler mit gnat-wu aktuell nicht verwendet werden. äöü
      -- RassenDatenbank.Rassenliste := (
      --                                 RassenDatentypen.Menschen_Enum         => RasseMenschen.RasseMenschenListe,
      --                               RassenDatentypen.Kasrodiah_Enum        => RasseKasrodiah.RasseKasrodiahListe,
      --                             RassenDatentypen.Lasupin_Enum          => RasseLasupin.RasseLasupinListe,
      --                           RassenDatentypen.Lamustra_Enum         => RasseLamustra.RasseLamustraListe,
      --                         RassenDatentypen.Manuky_Enum           => RasseManuky.RasseManukyListe,
      --                       RassenDatentypen.Suroka_Enum           => RasseSuroka.RasseSurokaListe,
      --                     RassenDatentypen.Pryolon_Enum          => RassePryolon.RassePryolonListe,
      --                   RassenDatentypen.Talbidahr_Enum        => RasseTalbidahr.RasseTalbidahrListe,
      --                 RassenDatentypen.Moru_Phisihl_Enum     => RasseMoruPhisihl.RasseMoruPhisihlListe,
      --               RassenDatentypen.Larinos_Lotaris_Enum  => RasseLarinosLotaris.RasseLarinosLotarisListe,
      --             RassenDatentypen.Carupex_Enum          => RasseCarupex.RasseCarupexListe,
      --           RassenDatentypen.Alary_Enum            => RasseAlary.RasseAlaryListe,
      --         RassenDatentypen.Tesorahn_Enum         => RasseTesorahn.RasseTesorahnListe,
      --       RassenDatentypen.Natries_Zermanis_Enum => RasseNatriesZermanis.RasseNatriesZermanisListe,
      --     RassenDatentypen.Tridatus_Enum         => RasseTridatus.RasseTridatusListe,
      --   RassenDatentypen.Senelari_Enum         => RasseSenelari.RasseSenelariListe,
      -- RassenDatentypen.Aspari_2_Enum         => RasseAspari2.RasseAspari2Liste,
      -- RassenDatentypen.Ekropa_Enum           => RasseEkropa.RasseEkropaListe
      -- );
      
   end StandardRassenDatenbankLaden;

end StandardRassenDatenbank;
