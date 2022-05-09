pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with EinheitenDatentypen;
with KartengrundDatentypen;
with RassenDatentypen;

with DatenbankRecords;

package KartengrundDatenbank is
   
   ----------------- Die ganzen Listen mal in Datenbanken umbenennen? Warum habe ich das nicht von Anfang an so benannt?
   
   type KartengrundlisteArray is array (KartengrundDatentypen.Kartengrund_Vorhanden_Enum'Range) of DatenbankRecords.KartengrundlisteRecord;
   Kartengrundliste : KartengrundlisteArray;
   
   procedure StandardKartengrundDatenbankLaden;
   
private
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava
   
   KartengrundlisteStandard : constant KartengrundlisteArray := (
                                                                 -- Normal
                                                                 KartengrundDatentypen.Eis_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                       EinheitenDatentypen.Luft_Enum     => True,
                                                                                       EinheitenDatentypen.Weltraum_Enum => True,
                                                                                       others                            => False),
                                                                    
                                                                    Bewertung => 
                                                                      (
                                                                       RassenDatentypen.Menschen_Enum         => 1,
                                                                       RassenDatentypen.Kasrodiah_Enum        => 1,
                                                                       RassenDatentypen.Lasupin_Enum          => 1,
                                                                       RassenDatentypen.Lamustra_Enum         => 1,
                                                                       RassenDatentypen.Manuky_Enum           => 1,
                                                                       RassenDatentypen.Suroka_Enum           => 1,
                                                                       RassenDatentypen.Pryolon_Enum          => 1,
                                                                       RassenDatentypen.Moru_Phisihl_Enum     => 1,
                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => 1,
                                                                       RassenDatentypen.Carupex_Enum          => 1,
                                                                       RassenDatentypen.Alary_Enum            => 1,
                                                                       RassenDatentypen.Natries_Zermanis_Enum => 1,
                                                                       RassenDatentypen.Tridatus_Enum         => 1,
                                                                       RassenDatentypen.Senelari_Enum         => 1,
                                                                       RassenDatentypen.Aspari_2_Enum         => 1,
                                                                       RassenDatentypen.Ekropa_Enum           => 1,
                                                                       RassenDatentypen.Tesorahn_Enum         => 1,
                                                                       RassenDatentypen.Talbidahr_Enum        => 1
                                                                      ),
                                                                       
                                                                      -- Nahrung, Produktion, Geld, Forschung
                                                                    Wirtschaft => 
                                                                      (
                                                                       RassenDatentypen.Menschen_Enum         => (1, 1, 1, 1),
                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1, 1, 1),
                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1, 1, 1),
                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1, 1, 1),
                                                                       RassenDatentypen.Manuky_Enum           => (1, 1, 1, 1),
                                                                       RassenDatentypen.Suroka_Enum           => (1, 1, 1, 1),
                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1, 1, 1),
                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1, 1, 1),
                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1, 1, 1),
                                                                       RassenDatentypen.Carupex_Enum          => (1, 1, 1, 1),
                                                                       RassenDatentypen.Alary_Enum            => (1, 1, 1, 1),
                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1, 1, 1),
                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1, 1, 1),
                                                                       RassenDatentypen.Senelari_Enum         => (1, 1, 1, 1),
                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1, 1, 1),
                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1, 1, 1),
                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1, 1, 1),
                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1, 1, 1)
                                                                      ),
                                                                    
                                                                    -- Verteidigung, Angriff
                                                                    Kampf => 
                                                                      (
                                                                       RassenDatentypen.Menschen_Enum         => (1, 1),
                                                                       RassenDatentypen.Kasrodiah_Enum        => (1, 1),
                                                                       RassenDatentypen.Lasupin_Enum          => (1, 1),
                                                                       RassenDatentypen.Lamustra_Enum         => (1, 1),
                                                                       RassenDatentypen.Manuky_Enum           => (1, 1),
                                                                       RassenDatentypen.Suroka_Enum           => (1, 1),
                                                                       RassenDatentypen.Pryolon_Enum          => (1, 1),
                                                                       RassenDatentypen.Moru_Phisihl_Enum     => (1, 1),
                                                                       RassenDatentypen.Larinos_Lotaris_Enum  => (1, 1),
                                                                       RassenDatentypen.Carupex_Enum          => (1, 1),
                                                                       RassenDatentypen.Alary_Enum            => (1, 1),
                                                                       RassenDatentypen.Natries_Zermanis_Enum => (1, 1),
                                                                       RassenDatentypen.Tridatus_Enum         => (1, 1),
                                                                       RassenDatentypen.Senelari_Enum         => (1, 1),
                                                                       RassenDatentypen.Aspari_2_Enum         => (1, 1),
                                                                       RassenDatentypen.Ekropa_Enum           => (1, 1),
                                                                       RassenDatentypen.Tesorahn_Enum         => (1, 1),
                                                                       RassenDatentypen.Talbidahr_Enum        => (1, 1)
                                                                      )
                                                                   ),
     
                                                                 KartengrundDatentypen.Wasser_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Wasser_Enum   => True,
                                                                                       EinheitenDatentypen.Luft_Enum     => True,
                                                                                       EinheitenDatentypen.Weltraum_Enum => True,
                                                                                       others                            => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Flachland_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                       EinheitenDatentypen.Luft_Enum     => True,
                                                                                       EinheitenDatentypen.Weltraum_Enum => True,
                                                                                       others                            => False),
                                                                    Bewertung      => (others => 10),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Tundra_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                       EinheitenDatentypen.Luft_Enum     => True,
                                                                                       EinheitenDatentypen.Weltraum_Enum => True,
                                                                                       others                            => False),
                                                                    Bewertung      => (others => 5),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Wüste_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                       EinheitenDatentypen.Luft_Enum     => True,
                                                                                       EinheitenDatentypen.Weltraum_Enum => True,
                                                                                       others                            => False),
                                                                    Bewertung      => (others => 5),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                   -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
                                                                 KartengrundDatentypen.Hügel_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                       EinheitenDatentypen.Luft_Enum     => True,
                                                                                       EinheitenDatentypen.Weltraum_Enum => True,
                                                                                       others                            => False),
                                                                    Bewertung      => (others => 8),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Gebirge_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                       EinheitenDatentypen.Luft_Enum     => True,
                                                                                       EinheitenDatentypen.Weltraum_Enum => True,
                                                                                       others                            => False),
                                                                    Bewertung      => (others => 5),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Wald_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                       EinheitenDatentypen.Luft_Enum     => True,
                                                                                       EinheitenDatentypen.Weltraum_Enum => True,
                                                                                       others                            => False),
                                                                    Bewertung      => (others => 8),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Dschungel_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                       EinheitenDatentypen.Luft_Enum     => True,
                                                                                       EinheitenDatentypen.Weltraum_Enum => True,
                                                                                       others                            => False),
                                                                    Bewertung      => (others => 5),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Küstengewässer_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Wasser_Enum       => True,
                                                                                       EinheitenDatentypen.Luft_Enum         => True,
                                                                                       EinheitenDatentypen.Weltraum_Enum     => True,
                                                                                       EinheitenDatentypen.Küstenwasser_Enum => True,
                                                                                       others                                => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Sumpf_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                       EinheitenDatentypen.Luft_Enum     => True,
                                                                                       EinheitenDatentypen.Weltraum_Enum => True,
                                                                                       others                            => False),
                                                                    Bewertung      => (others => 3),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                   -- Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr drauf machen?
                                                                 KartengrundDatentypen.Hügel_Mit_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Boden_Enum    => True,
                                                                                       EinheitenDatentypen.Luft_Enum     => True,
                                                                                       EinheitenDatentypen.Weltraum_Enum => True,
                                                                                       others                            => False),
                                                                    Bewertung      => (others => 5),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                                                   -- Normal
      
      
      
                                                                 -- Unterwasser/Unterirdisch
                                                                 KartengrundDatentypen.Untereis_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                       others                                => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Erde_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                       others                                => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
      
                                                                 KartengrundDatentypen.Erdgestein_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                       others                                => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
      
                                                                 KartengrundDatentypen.Sand_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Unterirdisch_Enum => True,
                                                                                       others                                => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
      
                                                                 KartengrundDatentypen.Meeresgrund_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Unterwasser_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Küstengrund_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Unterwasser_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
      
                                                                 KartengrundDatentypen.Korallen_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Unterwasser_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
      
                                                                 KartengrundDatentypen.Unterwald_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Unterwasser_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                                                   -- Unterwasser/Unterirdisch
      
      
                   
                                                                 -- Planeteninneres
                                                                 KartengrundDatentypen.Lava_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Planeteninneres_Enum => True,
                                                                                       others                                   => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Gestein_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Planeteninneres_Enum => True,
                                                                                       others                                   => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
      
                                                                 KartengrundDatentypen.Planetenkern_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Planeteninneres_Enum => True,
                                                                                       others                                   => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                                                   -- Planeteninneres
      
      
      
                                                                 -- Luft/Weltraum
                                                                 KartengrundDatentypen.Wolken_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Luft_Enum     => True,
                                                                                       EinheitenDatentypen.Weltraum_Enum => True,
                                                                                       others                            => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Weltraum_Enum =>
                                                                   (
                                                                    Passierbarkeit => (
                                                                                       EinheitenDatentypen.Weltraum_Enum => True,
                                                                                       others                            => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                                                   -- Luft/Weltraum
                                                                 
                                                                 
                                                                 
                                                                 -- Sonstiges
                                                                 KartengrundDatentypen.Vernichtet_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitenDatentypen.Luft_Enum     => True,
                                                                                       EinheitenDatentypen.Weltraum_Enum => True,
                                                                                       others                            => False),
                                                                    Bewertung      => (others => KartenDatentypen.BewertungFeld'First),
                                                                    Wirtschaft     => (others => (others => 0)),
                                                                    Kampf          => (others => (others => 0))
                                                                   )
                                                                   -- Sonstiges
                                                                );

end KartengrundDatenbank;
