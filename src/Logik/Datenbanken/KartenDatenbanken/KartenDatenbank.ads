pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen;
with KartenGrundDatentypen;
with KartenRecordKonstanten;

with DatenbankRecords;

package KartenDatenbank is
   
   type KartenFelderListeArray is array (KartenGrundDatentypen.Karten_Grund_Enum'Range) of DatenbankRecords.KartenGrundListeRecord;
   KartenFelderListe : KartenFelderListeArray;
   
   procedure StandardKartenDatenbankLaden;
   
private
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava
   -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft wird!
   
   KartenFelderListeStandard : constant KartenFelderListeArray := (
                                                                   -- Nullwert für Ressourcen, notwendig da sonst das Aufrechnen der Stadtwerte nicht funktioniert.
                                                                   KartenGrundDatentypen.Leer_Grund_Enum => KartenRecordKonstanten.LeerKartenGrundListe,
                                      
                                                                   -- Feld
                                                                   -- Normal
                                                                   KartenGrundDatentypen.Eis_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
     
                                                                   KartenGrundDatentypen.Wasser_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Wasser_Enum      => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum        => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum    => True,
                                                                                         others                             => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Flachland_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Tundra_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Wüste_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
                                                                   KartenGrundDatentypen.Hügel_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Gebirge_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Wald_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Dschungel_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Küstengewässer_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Wasser_Enum       => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum         => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum     => True,
                                                                                         EinheitStadtDatentypen.Küstenwasser_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Sumpf_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   -- Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr drauf machen?
                                                                   KartenGrundDatentypen.Hügel_Mit_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                                                   -- Normal
      
      
      
                                                                   -- Unterwasser/Unterirdisch
                                                                   KartenGrundDatentypen.Unterwasser_Eis_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Erde_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
      
                                                                   KartenGrundDatentypen.Erdgestein_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
      
                                                                   KartenGrundDatentypen.Sand_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
      
                                                                   KartenGrundDatentypen.Unterwasser_Wasser_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterwasser_Enum => True,
                                                                                         others                             => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterwasser_Küstengewässer_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterwasser_Enum => True,
                                                                                         others                             => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
      
                                                                   KartenGrundDatentypen.Korallen_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterwasser_Enum => True,
                                                                                         others                             => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
      
                                                                   KartenGrundDatentypen.Unterwasser_Wald_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterwasser_Enum => True,
                                                                                         others                             => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                                                   -- Unterwasser/Unterirdisch
      
      
                   
                                                                   -- Planeteninneres
                                                                   KartenGrundDatentypen.Lava_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Gestein_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
      
                                                                   KartenGrundDatentypen.Planetenkern_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                                                   -- Planeteninneres
      
      
      
                                                                   -- Luft/Weltraum
                                                                   KartenGrundDatentypen.Wolken_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Weltraum_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                                                   -- Luft/Weltraum
                                                                   -- Feld
      
      
                                      
                                                                   -- Ressourcen
                                                                   -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft wird!
                                                                   KartenGrundDatentypen.Kohle_Enum =>
                                                                     (Passierbarkeit => (others => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Eisen_Enum =>
                                                                     (Passierbarkeit => (others => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Öl_Enum =>
                                                                     (Passierbarkeit => (others => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Fisch_Enum =>
                                                                     (Passierbarkeit => (others => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
      
                                                                   KartenGrundDatentypen.Wal_Enum =>
                                                                     (Passierbarkeit => (others => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Hochwertiger_Boden_Enum =>
                                                                     (Passierbarkeit => (others => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Gold_Enum =>
                                                                     (Passierbarkeit => (others => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                                                   -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft wird!
                                                                   -- Ressourcen
      
      
      
                                                                   -- Flüsse
                                                                   -- Normal
                                                                   KartenGrundDatentypen.Flusskreuzung_Vier_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Fluss_Waagrecht_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Fluss_Senkrecht_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Flusskurve_Unten_Rechts_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Flusskurve_Unten_Links_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Flusskurve_Oben_Rechts_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Flusskurve_Oben_Links_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Flusskreuzung_Drei_Oben_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Flusskreuzung_Drei_Unten_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Flusskreuzung_Drei_Rechts_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Flusskreuzung_Drei_Links_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Flussendstück_Links_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Flussendstück_Rechts_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Flussendstück_Unten_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Flussendstück_Oben_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.See_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                         EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                         EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                         others                          => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                                                   -- Normal
      
      
      
                                                                   -- Unterirdisch
                                                                   KartenGrundDatentypen.Unterirdische_Flusskreuzung_Vier_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterirdischer_Fluss_Waagrecht_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterirdischer_Fluss_Senkrecht_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterirdische_Flusskurve_Unten_Rechts_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterirdische_Flusskurve_Unten_Links_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterirdische_Flusskurve_Oben_Rechts_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterirdische_Flusskurve_Oben_Links_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterirdische_Flusskreuzung_Drei_Oben_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterirdische_Flusskreuzung_Drei_Unten_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterirdische_Flusskreuzung_Drei_Rechts_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterirdische_Flusskreuzung_Drei_Links_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterirdisches_Flussendstück_Links_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterirdisches_Flussendstück_Rechts_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterirdisches_Flussendstück_Unten_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterirdisches_Flussendstück_Oben_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Unterirdischer_See_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                         others                              => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                                                   -- Unterirdisch
      
      
      
                                                                   -- Lava
                                                                   KartenGrundDatentypen.Lavaflusskreuzung_Vier_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Lavafluss_Waagrecht_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Lavafluss_Senkrecht_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Lavaflusskurve_Unten_Rechts_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Lavaflusskurve_Unten_Links_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Lavaflusskurve_Oben_Rechts_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Lavaflusskurve_Oben_Links_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Lavaflusskreuzung_Drei_Oben_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Lavaflusskreuzung_Drei_Unten_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Lavaflusskreuzung_Drei_Rechts_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Lavaflusskreuzung_Drei_Links_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Lavaflussendstück_Links_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Lavaflussendstück_Rechts_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Lavaflussendstück_Unten_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Lavaflussendstück_Oben_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1))),
                                      
                                                                   KartenGrundDatentypen.Lavasee_Enum =>
                                                                     (Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                         others                                 => False),
                                                                      Bewertung      => (others => 1),
                                                                      Wirtschaft     => (others => (others => 1)),
                                                                      Kampf          => (others => (others => 1)))
                                                                   -- Lava
                                                                   -- Flüsse
      
                                                                   -- others                 => GlobaleKonstanten.LeerKartenListe
                                                                  );

end KartenDatenbank;
