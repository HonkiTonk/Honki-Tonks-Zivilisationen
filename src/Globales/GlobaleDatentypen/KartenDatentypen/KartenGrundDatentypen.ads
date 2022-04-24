pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KartenGrundDatentypen is

   type Karten_Grund_Enum is (
                              Leer_Grund_Enum,
                              
                              Wasser_Enum, Küstengewässer_Enum, Unterwasser_Wasser_Enum, Unterwasser_Küstengewässer_Enum,
                              Eis_Enum, Unterwasser_Eis_Enum,
                              Lava_Enum, Planetenkern_Enum,
                              Tundra_Enum, Wüste_Enum, Hügel_Enum, Gebirge_Enum, Wald_Enum, Dschungel_Enum, Sumpf_Enum, Flachland_Enum, Hügel_Mit_Enum, Wolken_Enum, Weltraum_Enum, Erde_Enum, Erdgestein_Enum, Sand_Enum,
                              Gestein_Enum,
                              Korallen_Enum, Unterwasser_Wald_Enum,
                              
                              Vernichtet_Enum
                             );
   pragma Ordered (Karten_Grund_Enum);
   
   subtype Karten_Grund_Vorhanden_Enum is Karten_Grund_Enum range Wasser_Enum .. Karten_Grund_Enum'Last;

   subtype Karten_Grund_Alle_Felder_Enum is Karten_Grund_Vorhanden_Enum range Wasser_Enum .. Unterwasser_Wald_Enum;
   subtype Karten_Grund_Wasser_Mit_Eis_Enum is Karten_Grund_Alle_Felder_Enum range Wasser_Enum .. Unterwasser_Eis_Enum;
   subtype Karten_Grund_Wasser_Enum is Karten_Grund_Wasser_Mit_Eis_Enum range Wasser_Enum .. Unterwasser_Küstengewässer_Enum;
   subtype Karten_Grund_Land_Enum is Karten_Grund_Alle_Felder_Enum range Eis_Enum .. Gestein_Enum;
   subtype Karten_Grund_Land_Ohne_Eis_Enum is Karten_Grund_Land_Enum range Tundra_Enum .. Gestein_Enum;
   subtype Landschaft_Wahrscheinlichkeit_Enum is Karten_Grund_Land_Ohne_Eis_Enum range Tundra_Enum .. Sumpf_Enum;
   
   -- Flachland muss hier immer am Schluss kommen, sonst geht der Kartengenerator kaputt? Auf jeden Fall mal in der neuen Version des Kartengenerators ändern?
   subtype Karten_Grund_Generator_Enum is Karten_Grund_Land_Ohne_Eis_Enum range Tundra_Enum .. Flachland_Enum;
   subtype Karten_Unterwasser_Generator_Enum is Karten_Grund_Alle_Felder_Enum range Korallen_Enum .. Unterwasser_Wald_Enum;
   
   
   
   -- Hier gibt eine Einteilung nur mäßig Sinn denke ich, oder?
   type Karten_Ressourcen_Enum is (
                                   Leer_Ressource_Enum,
                                   
                                   -- Wasserressourcen
                                   Fisch_Enum, Wal_Enum,
                                   
                                   -- Landressourcen
                                   Kohle_Enum, Eisen_Enum, Öl_Enum, Hochwertiger_Boden_Enum, Gold_Enum
                                  );
   pragma Ordered (Karten_Ressourcen_Enum);
   
   subtype Karten_Ressourcen_Vorhanden_Enum is Karten_Ressourcen_Enum range Fisch_Enum .. Gold_Enum;
   subtype Karten_Ressourcen_Wasser is Karten_Ressourcen_Vorhanden_Enum range Karten_Ressourcen_Vorhanden_Enum'First .. Wal_Enum;
   subtype Karten_Ressourcen_Land is Karten_Ressourcen_Vorhanden_Enum range Kohle_Enum .. Karten_Ressourcen_Vorhanden_Enum'Last;
   
   
   
   type Karten_Fluss_Enum is (
                              Leer_Fluss_Enum,
                              
                              -- Fluss
                              Flusskreuzung_Vier_Enum, Fluss_Waagrecht_Enum, Fluss_Senkrecht_Enum, Flusskurve_Unten_Rechts_Enum, Flusskurve_Unten_Links_Enum, Flusskurve_Oben_Rechts_Enum, Flusskurve_Oben_Links_Enum,
                              Flusskreuzung_Drei_Oben_Enum, Flusskreuzung_Drei_Unten_Enum, Flusskreuzung_Drei_Rechts_Enum, Flusskreuzung_Drei_Links_Enum, Flussendstück_Links_Enum, Flussendstück_Rechts_Enum,
                              Flussendstück_Unten_Enum, Flussendstück_Oben_Enum, See_Enum,
                              
                              -- Unterirdischer Fluss
                              Unterirdische_Flusskreuzung_Vier_Enum, Unterirdischer_Fluss_Waagrecht_Enum, Unterirdischer_Fluss_Senkrecht_Enum, Unterirdische_Flusskurve_Unten_Rechts_Enum,
                              Unterirdische_Flusskurve_Unten_Links_Enum, Unterirdische_Flusskurve_Oben_Rechts_Enum, Unterirdische_Flusskurve_Oben_Links_Enum, Unterirdische_Flusskreuzung_Drei_Oben_Enum,
                              Unterirdische_Flusskreuzung_Drei_Unten_Enum, Unterirdische_Flusskreuzung_Drei_Rechts_Enum, Unterirdische_Flusskreuzung_Drei_Links_Enum, Unterirdisches_Flussendstück_Links_Enum,
                              Unterirdisches_Flussendstück_Rechts_Enum, Unterirdisches_Flussendstück_Unten_Enum, Unterirdisches_Flussendstück_Oben_Enum, Unterirdischer_See_Enum,
                              
                              -- Lavafluss
                              Lavaflusskreuzung_Vier_Enum, Lavafluss_Waagrecht_Enum, Lavafluss_Senkrecht_Enum, Lavaflusskurve_Unten_Rechts_Enum, Lavaflusskurve_Unten_Links_Enum, Lavaflusskurve_Oben_Rechts_Enum,
                              Lavaflusskurve_Oben_Links_Enum, Lavaflusskreuzung_Drei_Oben_Enum, Lavaflusskreuzung_Drei_Unten_Enum, Lavaflusskreuzung_Drei_Rechts_Enum, Lavaflusskreuzung_Drei_Links_Enum,
                              Lavaflussendstück_Links_Enum, Lavaflussendstück_Rechts_Enum, Lavaflussendstück_Unten_Enum, Lavaflussendstück_Oben_Enum, Lavasee_Enum
                             );
   pragma Ordered (Karten_Fluss_Enum);
                              
   subtype Karten_Alle_Flüsse_Vorhanden_Enum is Karten_Fluss_Enum range Flusskreuzung_Vier_Enum .. Karten_Fluss_Enum'Last;
   subtype Karten_Fluss_Vorhanden_Enum is Karten_Alle_Flüsse_Vorhanden_Enum range Flusskreuzung_Vier_Enum .. See_Enum;
   subtype Karten_Unterirdischer_Fluss_Vorhanden_Enum is Karten_Alle_Flüsse_Vorhanden_Enum range Unterirdische_Flusskreuzung_Vier_Enum .. Unterirdischer_See_Enum;
   subtype Karten_Lavafluss_Vorhanden_Enum is Karten_Alle_Flüsse_Vorhanden_Enum range Lavaflusskreuzung_Vier_Enum .. Lavasee_Enum;

end KartenGrundDatentypen;
