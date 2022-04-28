pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen;
with KartengrundDatentypen;

with DatenbankRecords;

package KartenDatenbank is
   
   ----------------- Die ganzen Listen mal in Datenbanken umbenennen? Warum habe ich das nicht von Anfang an so benannt?
   
   type KartengrundlisteArray is array (KartengrundDatentypen.Kartengrund_Vorhanden_Enum'Range) of DatenbankRecords.KartengrundlisteRecord;
   Kartengrundliste : KartengrundlisteArray;
   
   type KartenflusslisteArray is array (KartengrundDatentypen.Karten_Alle_Flüsse_Vorhanden_Enum'Range) of DatenbankRecords.KartenlisteRecord;
   Kartenflussliste : KartenflusslisteArray;
   
   type KartenRessourcenListeArray is array (KartengrundDatentypen.Karten_Ressourcen_Vorhanden_Enum'Range) of DatenbankRecords.KartenlisteRecord;
   KartenRessourcenListe : KartenRessourcenListeArray;
   
   procedure StandardKartengrundDatenbankLaden;
   procedure StandardKartenflussDatenbankLaden;
   procedure StandardKartenRessourcenDatenbankLaden;
   
private
   
   -- Passierbarkeit: Boden, Wasser, Luft, Weltraum, Unterwasser, Küstenwasser, Unterirdisch (Erde), Planeteninneres (Gestein), Lava
   -- Die Passierbarkeit für Ressourcen ist unwichtig, da sie sowieso nie geprüft wird!
   
   KartengrundlisteStandard : constant KartengrundlisteArray := (
                                                                 -- Normal
                                                                 KartengrundDatentypen.Eis_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                       EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                       EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
     
                                                                 KartengrundDatentypen.Wasser_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Wasser_Enum      => True,
                                                                                       EinheitStadtDatentypen.Luft_Enum        => True,
                                                                                       EinheitStadtDatentypen.Weltraum_Enum    => True,
                                                                                       others                                  => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Flachland_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                       EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                       EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Tundra_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                       EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                       EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Wüste_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                       EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                       EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                   -- Ersetzt Ebene oder ist Bestandteil von Wüste, Tundra, Wald und Dschungel
                                                                 KartengrundDatentypen.Hügel_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                       EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                       EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Gebirge_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                       EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                       EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Wald_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                       EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                       EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Dschungel_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                       EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                       EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Küstengewässer_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Wasser_Enum       => True,
                                                                                       EinheitStadtDatentypen.Luft_Enum         => True,
                                                                                       EinheitStadtDatentypen.Weltraum_Enum     => True,
                                                                                       EinheitStadtDatentypen.Küstenwasser_Enum => True,
                                                                                       others                                   => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Sumpf_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                       EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                       EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                   -- Platzhalter um die ID beim Einlesen korrekt zu behandeln, nicht löschen!, vielleicht später mehr drauf machen?
                                                                 KartengrundDatentypen.Hügel_Mit_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Boden_Enum    => True,
                                                                                       EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                       EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                                                   -- Normal
      
      
      
                                                                 -- Unterwasser/Unterirdisch
                                                                 KartengrundDatentypen.Untereis_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                       others                                   => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Erde_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                       others                                   => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
      
                                                                 KartengrundDatentypen.Erdgestein_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                       others                                   => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
      
                                                                 KartengrundDatentypen.Sand_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Unterirdisch_Enum => True,
                                                                                       others                                   => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
      
                                                                 KartengrundDatentypen.Meeresgrund_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Unterwasser_Enum => True,
                                                                                       others                                  => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Küstengrund_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Unterwasser_Enum => True,
                                                                                       others                                  => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
      
                                                                 KartengrundDatentypen.Korallen_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Unterwasser_Enum => True,
                                                                                       others                                  => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
      
                                                                 KartengrundDatentypen.Unterwald_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Unterwasser_Enum => True,
                                                                                       others                                  => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                                                   -- Unterwasser/Unterirdisch
      
      
                   
                                                                 -- Planeteninneres
                                                                 KartengrundDatentypen.Lava_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                       others                                      => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Gestein_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                       others                                      => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
      
                                                                 KartengrundDatentypen.Planetenkern_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Planeteninneres_Enum => True,
                                                                                       others                                      => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                                                   -- Planeteninneres
      
      
      
                                                                 -- Luft/Weltraum
                                                                 KartengrundDatentypen.Wolken_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                       EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Weltraum_Enum =>
                                                                   (
                                                                    Passierbarkeit => (
                                                                                       EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => 1),
                                                                    Wirtschaft     => (others => (others => 1)),
                                                                    Kampf          => (others => (others => 1))
                                                                   ),
                                                                   -- Luft/Weltraum
                                                                 
                                                                 
                                                                 
                                                                 -- Sonstiges
                                                                 KartengrundDatentypen.Vernichtet_Enum =>
                                                                   (
                                                                    Passierbarkeit => (EinheitStadtDatentypen.Luft_Enum     => True,
                                                                                       EinheitStadtDatentypen.Weltraum_Enum => True,
                                                                                       others                               => False),
                                                                    Bewertung      => (others => -10),
                                                                    Wirtschaft     => (others => (others => 0)),
                                                                    Kampf          => (others => (others => 0))
                                                                   )
                                                                   -- Sonstiges
                                                                );
   
   
   
   KartenflusslisteStandard : constant KartenflusslisteArray := (
                                                                 -- Normal
                                                                 KartengrundDatentypen.Flusskreuzung_Vier_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Fluss_Waagrecht_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Fluss_Senkrecht_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Flusskurve_Unten_Rechts_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Flusskurve_Unten_Links_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Flusskurve_Oben_Rechts_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Flusskurve_Oben_Links_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Flusskreuzung_Drei_Oben_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                                                 
                                                                 KartengrundDatentypen.Flusskreuzung_Drei_Unten_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Flusskreuzung_Drei_Rechts_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Flusskreuzung_Drei_Links_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Flussendstück_Links_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Flussendstück_Rechts_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Flussendstück_Unten_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Flussendstück_Oben_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.See_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                                                   -- Normal
      
      
      
                                                                 -- Unterirdisch
                                                                 KartengrundDatentypen.Unterirdische_Flusskreuzung_Vier_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Unterirdischer_Fluss_Waagrecht_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Unterirdischer_Fluss_Senkrecht_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Unterirdische_Flusskurve_Unten_Rechts_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Unterirdische_Flusskurve_Unten_Links_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Unterirdische_Flusskurve_Oben_Rechts_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Unterirdische_Flusskurve_Oben_Links_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Unterirdische_Flusskreuzung_Drei_Oben_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Unterirdische_Flusskreuzung_Drei_Unten_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Unterirdische_Flusskreuzung_Drei_Rechts_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Unterirdische_Flusskreuzung_Drei_Links_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Unterirdisches_Flussendstück_Links_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Unterirdisches_Flussendstück_Rechts_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Unterirdisches_Flussendstück_Unten_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Unterirdisches_Flussendstück_Oben_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Unterirdischer_See_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                                                   -- Unterirdisch
      
      
      
                                                                 -- Lava
                                                                 KartengrundDatentypen.Lavaflusskreuzung_Vier_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Lavafluss_Waagrecht_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Lavafluss_Senkrecht_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Lavaflusskurve_Unten_Rechts_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Lavaflusskurve_Unten_Links_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Lavaflusskurve_Oben_Rechts_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Lavaflusskurve_Oben_Links_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Lavaflusskreuzung_Drei_Oben_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Lavaflusskreuzung_Drei_Unten_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Lavaflusskreuzung_Drei_Rechts_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Lavaflusskreuzung_Drei_Links_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Lavaflussendstück_Links_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Lavaflussendstück_Rechts_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Lavaflussendstück_Unten_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Lavaflussendstück_Oben_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   ),
                                      
                                                                 KartengrundDatentypen.Lavasee_Enum =>
                                                                   (
                                                                    Bewertung  => (others => 1),
                                                                    Wirtschaft => (others => (others => 1)),
                                                                    Kampf      => (others => (others => 1))
                                                                   )
                                                                   -- Lava
                                                                );
     
     
   
   KartenRessourcenListeStandard : constant KartenRessourcenListeArray := (
                                                                           KartengrundDatentypen.Kohle_Enum =>
                                                                             (
                                                                              Bewertung  => (others => 1),
                                                                              Wirtschaft => (others => (others => 1)),
                                                                              Kampf      => (others => (others => 1))
                                                                             ),
                                      
                                                                           KartengrundDatentypen.Eisen_Enum =>
                                                                             (
                                                                              Bewertung  => (others => 1),
                                                                              Wirtschaft => (others => (others => 1)),
                                                                              Kampf      => (others => (others => 1))
                                                                             ),
                                      
                                                                           KartengrundDatentypen.Öl_Enum =>
                                                                             (
                                                                              Bewertung  => (others => 1),
                                                                              Wirtschaft => (others => (others => 1)),
                                                                              Kampf      => (others => (others => 1))
                                                                             ),
                                      
                                                                           KartengrundDatentypen.Fisch_Enum =>
                                                                             (
                                                                              Bewertung  => (others => 1),
                                                                              Wirtschaft => (others => (others => 1)),
                                                                              Kampf      => (others => (others => 1))
                                                                             ),
      
                                                                           KartengrundDatentypen.Wal_Enum =>
                                                                             (
                                                                              Bewertung  => (others => 1),
                                                                              Wirtschaft => (others => (others => 1)),
                                                                              Kampf      => (others => (others => 1))
                                                                             ),
                                      
                                                                           KartengrundDatentypen.Hochwertiger_Boden_Enum =>
                                                                             (
                                                                              Bewertung  => (others => 1),
                                                                              Wirtschaft => (others => (others => 1)),
                                                                              Kampf      => (others => (others => 1))
                                                                             ),
                                      
                                                                           KartengrundDatentypen.Gold_Enum =>
                                                                             (
                                                                              Bewertung  => (others => 1),
                                                                              Wirtschaft => (others => (others => 1)),
                                                                              Kampf      => (others => (others => 1))
                                                                             )
                                                                          );

end KartenDatenbank;
